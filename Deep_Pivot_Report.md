# Cybersecurity Lab: Operation Deep Pivot

## Phase 1: Privilege Escalation
* **Target:** Bastion Host
* **Vulnerability:** Sudo misconfiguration on `/usr/bin/find`.
* **Command:** `sudo find . -exec /bin/sh \; -quit`
* **Verification:** `whoami` -> `root`
* **Result:** Successfully obtained root-level access.

## Phase 2: Persistence
* **Method:** Crontab Backdoor.
* **Configuration:** Added a reverse shell job to the root crontab.
* **Verification:** Successfully received a connection on port 4444 after the minute mark.

## Phase 3: Lateral Movement & Pivoting
* **Objective:** Access the isolated Vault Database (10.0.10.50).
* **Execution:** 1. Established a Meterpreter session on the Bastion.
    2. Configured a static route for the 10.0.10.0/24 subnet through the session.
* **Proof of Concept:**
    * Performed a TCP port scan on `10.0.10.50`.
    * **Result:** `10.0.10.50:6379 - TCP OPEN`.