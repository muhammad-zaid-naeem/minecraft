"""RCON client - builds the Lifesteal spawn arena."""
import socket
import struct
import time
import sys

HOST = "127.0.0.1"
PORT = 25575
PASSWORD = "lifesteal123"

TYPE_AUTH = 3
TYPE_COMMAND = 2
TYPE_RESPONSE = 0


class Rcon:
    def __init__(self, host, port, password):
        self.host = host
        self.port = port
        self.password = password
        self.sock = None
        self.req_id = 0

    def connect(self):
        self.sock = socket.create_connection((self.host, self.port), timeout=10)
        self.sock.settimeout(10)
        # Auth
        self._send_packet(TYPE_AUTH, self.password)
        resp = self._read_packet()
        if resp[0] == -1:
            raise RuntimeError("Auth failed")

    def _send_packet(self, ptype, payload):
        self.req_id += 1
        data = payload.encode("utf-8")
        body = struct.pack("<ii", self.req_id, ptype) + data + b"\x00\x00"
        packet = struct.pack("<i", len(body)) + body
        self.sock.sendall(packet)
        return self.req_id

    def _read_packet(self):
        # Read length
        raw_len = b""
        while len(raw_len) < 4:
            chunk = self.sock.recv(4 - len(raw_len))
            if not chunk:
                raise ConnectionError("Connection closed while reading length")
            raw_len += chunk
        size = struct.unpack("<i", raw_len)[0]
        body = b""
        while len(body) < size:
            chunk = self.sock.recv(size - len(body))
            if not chunk:
                raise ConnectionError("Connection closed while reading body")
            body += chunk
        req_id, ptype = struct.unpack("<ii", body[:8])
        payload = body[8:-2].decode("utf-8", errors="replace")
        return req_id, ptype, payload

    def cmd(self, command):
        self._send_packet(TYPE_COMMAND, command)
        _, _, resp = self._read_packet()
        return resp

    def close(self):
        if self.sock:
            self.sock.close()
            self.sock = None


def run_with_retry(commands, max_retries=3):
    """Run commands; on connection error, reconnect and retry."""
    rcon = Rcon(HOST, PORT, PASSWORD)
    rcon.connect()
    total = len(commands)
    for i, cmd in enumerate(commands, 1):
        attempts = 0
        while attempts < max_retries:
            try:
                resp = rcon.cmd(cmd)
                print(f"[{i}/{total}] {cmd[:80]} -> {resp.strip()[:120]}")
                break
            except Exception as e:
                attempts += 1
                print(f"[{i}/{total}] reconnect (attempt {attempts}) after error: {e}")
                try:
                    rcon.close()
                except Exception:
                    pass
                time.sleep(1)
                rcon = Rcon(HOST, PORT, PASSWORD)
                rcon.connect()
        else:
            print(f"[{i}/{total}] FAILED after {max_retries} retries: {cmd}")
        time.sleep(0.05)
    rcon.close()


# Phase 1: Force load chunks around spawn (chunks are 16x16, spawn at 0,0 = chunk 0,0)
# We need to cover from -27 to 27 in X and Z = chunks -2 to 1 = -32 to 31
forceload_cmds = [
    "forceload add -32 -32 31 31",
    "save-all",
]

# Phase 2: Build the arena (without massive single fills that might fail)
build_cmds = [
    "gamerule doDaylightCycle false",
    "gamerule doWeatherCycle false",
    "gamerule mobGriefing false",
    "time set day",
    "weather clear",

    # Clear airspace (split into smaller fills to be safe)
    "fill -27 95 -27 0 125 0 minecraft:air",
    "fill 1 95 -27 27 125 0 minecraft:air",
    "fill -27 95 1 0 125 27 minecraft:air",
    "fill 1 95 1 27 125 27 minecraft:air",

    # Foundation
    "fill -25 95 -25 0 99 0 minecraft:deepslate",
    "fill 1 95 -25 25 99 0 minecraft:deepslate",
    "fill -25 95 1 0 99 25 minecraft:deepslate",
    "fill 1 95 1 25 99 25 minecraft:deepslate",

    # Floor - red nether bricks outer ring
    "fill -25 100 -25 25 100 25 minecraft:red_nether_bricks",
    # Crimson plank middle ring
    "fill -23 100 -23 23 100 23 minecraft:crimson_planks",
    # Inner red nether bricks
    "fill -20 100 -20 20 100 20 minecraft:red_nether_bricks",
    # Center nether bricks
    "fill -15 100 -15 15 100 15 minecraft:nether_bricks",

    # Walls (height 8: y=101-108)
    "fill -25 101 -25 25 108 -25 minecraft:red_nether_bricks",
    "fill -25 101 25 25 108 25 minecraft:red_nether_bricks",
    "fill -25 101 -24 -25 108 24 minecraft:red_nether_bricks",
    "fill 25 101 -24 25 108 24 minecraft:red_nether_bricks",

    # Gates (4 cardinal openings)
    "fill -2 101 -25 2 104 -25 minecraft:air",
    "fill -2 101 25 2 104 25 minecraft:air",
    "fill -25 101 -2 -25 104 2 minecraft:air",
    "fill 25 101 -2 25 104 2 minecraft:air",

    # Corner pillars (crying obsidian)
    "fill -24 101 -24 -23 110 -23 minecraft:crying_obsidian",
    "fill 23 101 -24 24 110 -23 minecraft:crying_obsidian",
    "fill -24 101 23 -23 110 24 minecraft:crying_obsidian",
    "fill 23 101 23 24 110 24 minecraft:crying_obsidian",

    # Pillar caps
    "fill -24 111 -24 -23 111 -23 minecraft:glowstone",
    "fill 23 111 -24 24 111 -23 minecraft:glowstone",
    "fill -24 111 23 -23 111 24 minecraft:glowstone",
    "fill 23 111 23 24 111 24 minecraft:glowstone",

    # Glass roof
    "fill -25 109 -25 25 109 25 minecraft:red_stained_glass",

    # Center beacon pyramid
    "fill -3 100 -3 3 100 3 minecraft:netherite_block",
    "fill -2 101 -2 2 101 2 minecraft:iron_block",
    "fill -1 102 -1 1 102 1 minecraft:iron_block",
    "setblock 0 103 0 minecraft:beacon",

    # Heart on floor (red wool, north of beacon)
    "fill -3 100 -10 -1 100 -8 minecraft:red_wool",
    "fill 1 100 -10 3 100 -8 minecraft:red_wool",
    "fill -3 100 -7 3 100 -6 minecraft:red_wool",
    "fill -2 100 -5 2 100 -5 minecraft:red_wool",
    "fill -1 100 -4 1 100 -4 minecraft:red_wool",
    "setblock 0 100 -3 minecraft:red_wool",

    # Lava moat outside walls (looks intense)
    "fill -27 99 -27 27 99 -26 minecraft:lava",
    "fill -27 99 26 27 99 27 minecraft:lava",
    "fill -27 99 -25 -26 99 25 minecraft:lava",
    "fill 26 99 -25 27 99 25 minecraft:lava",

    # Soul torches inside corners
    "setblock -22 101 -22 minecraft:soul_torch",
    "setblock 22 101 -22 minecraft:soul_torch",
    "setblock -22 101 22 minecraft:soul_torch",
    "setblock 22 101 22 minecraft:soul_torch",

    # Sea lanterns along the wall tops (lighting)
    "fill -24 108 -24 24 108 -24 minecraft:sea_lantern replace minecraft:red_nether_bricks",
    "fill -24 108 24 24 108 24 minecraft:sea_lantern replace minecraft:red_nether_bricks",

    # Set spawn point exactly at the beacon
    "setworldspawn 0 104 0",
    "spawnpoint @a 0 104 0",

    # Welcome message
    "say Lifesteal SMP spawn arena built! Type /spawn to visit.",
]


def main():
    print("Phase 1: Force-load chunks around spawn...")
    run_with_retry(forceload_cmds)
    print("\nWaiting 3s for chunks to load...")
    time.sleep(3)

    print("\nPhase 2: Building spawn arena...")
    run_with_retry(build_cmds)
    print("\nDONE - Spawn arena complete!")


if __name__ == "__main__":
    main()
