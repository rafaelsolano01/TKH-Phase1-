# TITANCORP: PERIMETER ASSESSMENT REPORT

**Operator:** Rafael Solano  
**Target Subnet:** 172.88.0.0/24  

---

## PHASE 1: ACTIVE ENUMERATION (NMAP)

* **Host 1 (172.88.0.10):** HTTP — nginx/1.14.2  
* **Host 2 (172.88.0.15):** No HTTP service detected (no web server on port 80)  
* **Host 3 (172.88.0.20):** Redis cache service (port 6379)  

---

## PHASE 2: VULNERABILITY AUDIT (NIKTO)

* **Web Server 1 Finding (172.88.0.10):**  
Outdated Nginx version (1.14.2) detected, which may be vulnerable to known exploits.

* **Web Server 2 Finding (172.88.0.15):**  
No web server detected on port 80; host is not running an HTTP service and could not be assessed with Nikto.

---

## PHASE 3: RISK TRIAGE

* **Top Priority Remediation:** Outdated Nginx Server (nginx/1.14.2)

* **Justification:**  
The outdated Nginx server presents the highest risk due to its high likelihood of exploitation using publicly available vulnerabilities and its high impact,
which could allow remote code execution or full system compromise on an internet-facing host.
