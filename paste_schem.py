import socket, struct, time, sys

HOST, PORT, PWD = "127.0.0.1", 25575, "lifesteal123"
PLAYER = "Itx_Zaid_3"


def rcon(cmd):
    s = socket.create_connection((HOST, PORT), 10)
    s.settimeout(10)
    body = struct.pack("<ii", 1, 3) + PWD.encode() + b"\x00\x00"
    s.sendall(struct.pack("<i", len(body)) + body)
    raw = b""
    while len(raw) < 4: raw += s.recv(4-len(raw))
    size = struct.unpack("<i", raw)[0]
    s.recv(size)

    body = struct.pack("<ii", 2, 2) + cmd.encode() + b"\x00\x00"
    s.sendall(struct.pack("<i", len(body)) + body)
    raw = b""
    while len(raw) < 4: raw += s.recv(4-len(raw))
    size = struct.unpack("<i", raw)[0]
    data = b""
    while len(data) < size: data += s.recv(size-len(data))
    s.close()
    return data[8:-2].decode("utf-8", errors="replace")


def step(cmd, label=None):
    r = rcon(cmd)
    print(f"> {label or cmd}")
    print(f"  {r.strip()[:200]}")
    return r


print("=== Phase 1: Prep ===")
step(f"list")
step(f"gamemode creative {PLAYER}")
step(f"effect give {PLAYER} minecraft:resistance 600 4 true")
step(f"tp {PLAYER} 0 200 0")
time.sleep(2)

print("\n=== Phase 2: Force-load paste area chunks ===")
# Paste area roughly at -21 to 21 in X and Z (schematic 42x44 centered)
# Chunks span -2 to 1 in both X and Z
step("forceload add -32 -32 31 31")
step("save-all")
time.sleep(2)

print("\n=== Phase 3: Load & paste schematic (run as player) ===")
# FAWE: execute as player so commands use their clipboard
step(f'execute as {PLAYER} run /schem load medieval_spawn', "schem load")
time.sleep(1)
# Paste with -a (ignore air), at the player's location
step(f'execute as {PLAYER} at {PLAYER} run /paste -a', "paste -a")
time.sleep(3)

print("\n=== Phase 4: Set spawn at paste center ===")
# Schematic likely pastes with origin at player; find a safe spawn spot
step("setworldspawn 0 200 0")
step(f"spawnpoint {PLAYER} 0 200 0")
step(f"effect clear {PLAYER}")
step(f"gamemode survival {PLAYER}")

print("\nDONE - check the medieval spawn around (0, 200, 0)!")
