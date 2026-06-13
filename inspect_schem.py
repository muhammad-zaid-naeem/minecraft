import gzip, struct, os
path = r"D:\server\plugins\FastAsyncWorldEdit\schematics\medieval_spawn.schematic"
with gzip.open(path, "rb") as f:
    data = f.read()

def find_short(data, key):
    k = key.encode()
    i = data.find(b"\x02" + struct.pack(">H", len(k)) + k)
    if i < 0:
        return None
    v = data[i + 3 + len(k):i + 5 + len(k)]
    return struct.unpack(">h", v)[0]

w = find_short(data, "Width")
h = find_short(data, "Height")
l = find_short(data, "Length")
print(f"File: {os.path.getsize(path)} bytes (gzipped)")
print(f"Decompressed: {len(data)} bytes")
print(f"Dimensions (W x H x L): {w} x {h} x {l}")
if w and h and l:
    print(f"Volume: {w*h*l:,} blocks")
