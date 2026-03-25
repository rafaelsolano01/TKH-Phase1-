attack_count = 0

try:
    with open("auth_audit.log", "r") as log_file:
        with open("brute_report.txt", "w") as report_file:

            # Loop through each line
            for line in log_file:

                # Look for failed login attempts
                if "Failed password" in line:
                    report_file.write(line)
                    attack_count = attack_count + 1

    print(f"[*] Audit Complete. Extracted {attack_count} threat signatures to brute_report.txt")

except FileNotFoundError:
    print("[-] Alert: The log file is missing! Investigation halted.")
