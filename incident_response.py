#!/usr/bin/env python3

import subprocess
import json

# Phase 1: Run grep using subprocess
result = subprocess.run(
    ["grep", "Failed password", "/var/log/titan_sim/auth_sim.log"],
    capture_output=True,
    text=True
)

raw_output = result.stdout

# Phase 2: Parse IP addresses
lines = raw_output.split('\n')

attacker_ips = []

for line in lines:
    if line:
        try:
            ip = line.split()[10]  # safer than "split(' ')"
            attacker_ips.append(ip)
        except IndexError:
            # skip malformed lines
            continue

# Optional: remove duplicates (cleaner report)
attacker_ips = list(set(attacker_ips))

# Phase 3: Create JSON structure
alert_data = {
    "alert_type": "Brute Force",
    "attacker_ips": attacker_ips
}

# Phase 4: Write JSON file
with open("threat_report.json", "w") as file:
    json.dump(alert_data, file, indent=4)

print("[+] Threat report generated: threat_report.json")
