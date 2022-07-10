import json

rows = {}

for line in open("echo.log"):
    if not line.startswith("{"):
        continue
    row = json.loads(line)
    if not "id" in row:
        continue
    rid = row["id"]
    if rid not in rows:
        rows[rid] = []
    rows[rid].append(row)

print(len(rows))
