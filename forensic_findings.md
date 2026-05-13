# FORENSIC FINDINGS REPORT (THE MALWARE AUTOPSY)

### WHO:
rootkit_beacon.exe (PID 4444)

### WHAT:
Resume.exe (malicious deleted executable)

### WHEN:
2026-05-13 00:27:24 UTC

### HOW:
Executed via Resume.exe, which was deleted from disk but persisted in memory as a hidden rootkit process (rootkit_beacon.exe PID 4444).
The malware operates as a stealth beacon/reverse shell using command-line activity (nc/cmd patterns)
and maintains runtime presence in RAM while removing filesystem traces.
