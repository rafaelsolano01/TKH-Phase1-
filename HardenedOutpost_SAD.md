# TITAN SMALL BUSINESS SERVICES: SECURITY ARCHITECTURE DOCUMENT (SAD)

**Operator:** Rafael Solano  
**Date:** 2026-04-21  

---

## 1. Perimeter Hardening (UFW & SSH)

* **SSH Status:**
  - Disabled root login in `/etc/ssh/sshd_config`
  - Disabled password authentication
  - Enabled SSH key-based authentication (ED25519 keypair)
  - Verified secure SSH login after restart

* **Firewall Logic:**
  - Default deny incoming traffic
  - Allowed port 22/tcp for SSH access
  - Allowed port 8080/tcp for web application access
  - Outbound traffic allowed by default

---

## 2. The Automated Auditor (Python)

* **Script Logic:**
  - Python script uses `os` and `datetime`
  - Sends ICMP ping requests to monitor system availability
  - Logs system status as "DC is UP" or "DC is DOWN"
  - Appends timestamped results to `/var/log/dc_audit.log`

```python
import os
import datetime

DC_IP = "8.8.8.8"

response = os.system(f"ping -c 4 {DC_IP}")

status = "DC is UP" if response == 0 else "DC is DOWN"

log_entry = f"{datetime.datetime.now()} - {status}\n"

with open("/var/log/dc_audit.log", "a") as log_file:
    log_file.write(log_entry)
