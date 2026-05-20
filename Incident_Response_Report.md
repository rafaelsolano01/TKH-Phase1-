# INCIDENT RESPONSE REPORT: PHANTOM PURSUIT

**Operator:** Rafael Solano

---

## PHASE 1: SIEM CORRELATION

* **Initial Alert Source IP:** 172.50.0.1

### Findings
The SIEM alert identified suspicious activity associated with the above source IP through Kibana log correlation using the `enterprise_logs*` index pattern.

---

## PHASE 2: LIVE TRIAGE & CHAIN OF CUSTODY

* **Suspicious Process ID (PID):** 10 (Netcat listener)
* **Outbound C2 Process PID:** 30266 / 30432 (bash)

* **Evidence SHA256 Hash:**  
`f50180d1602bfde2ad4612b6dbbbbd32c62760a255ace6cc48e5f150b5fe732e`

### Network Activity Findings

Initial investigation identified a Netcat listener on TCP port 4444. Further live triage using `ss -antp` revealed active outbound connection attempts originating from `bash` processes.

### Command-and-Control Indicators

- Source Host: 192.168.1.76  
- Destination: 172.50.0.1:4444  
- Connection State: SYN-SENT (outbound attempt)  
- Process: bash (PID 30266, 30432)

### Findings
The system exhibits both inbound listening behavior and outbound beaconing activity, strongly indicating active command-and-control (C2) communication attempts between the compromised host and external infrastructure.
## PHASE 3: DISK FORENSICS

* **Deleted File Inode Number:** 582

### Forensic Analysis
The disk image was analyzed using The Sleuth Kit forensic utilities. Recursive enumeration with `fls` identified a deleted executable artifact associated with `beacon.exe`.

Metadata inspection using `istat` confirmed the file was marked as unallocated and had a recorded size of 0 bytes at the time of analysis.

### Recovery Attempts

```bash
fls -r compromised_drive.dd
icat -r compromised_drive.dd 582 > ~/recovered_payload.txt
icat -R compromised_drive.dd 582 > ~/recovered_payload.txt
istat compromised_drive.dd 582
```

### Findings
The deleted malware artifact was successfully identified within the filesystem metadata; however, the payload contents were unrecoverable because the file had been truncated or zeroed prior to forensic acquisition.
