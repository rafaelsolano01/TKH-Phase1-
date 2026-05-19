#!/bin/bash
# =================================================================
# Coursework: Lab Submission - Firewall Configuration Script
# Description: Micro-lab UFW setup and DMZ Netfilter Lockdown
# =================================================================

echo "[+] Starting Firewall Configuration Workflow..."

# -----------------------------------------------------------------
# 🔵 PHASE 1: UFW Micro-Lab Configuration (Disabled for Phase 2)
# -----------------------------------------------------------------
# ufw default deny incoming
# ufw default allow outgoing
# ufw allow 22/tcp
# ufw allow 443/tcp
# ufw disable

# -----------------------------------------------------------------
# 🔴 PHASE 2: Core Netfilter/iptables DMZ Lockdown
# -----------------------------------------------------------------
echo "[+] Applying iptables DMZ security policies..."

# Flush any conflicting/duplicate rules first to clean up the tables
iptables -F INPUT
iptables -F OUTPUT

# Step 1: Allow incoming HTTP (80) and HTTPS (443) traffic from the Internet
iptables -A INPUT -p tcp -m multiport --dports 80,443 -j ACCEPT

# Step 2: Permit explicit outbound egress to the DB container (10.0.5.50) on port 3306
iptables -A OUTPUT -p tcp -d 10.0.5.50 --dport 3306 -j ACCEPT

# Step 3: Absolute drop rule for all other lateral movement across the internal network
iptables -A OUTPUT -d 10.0.5.0/24 -j DROP

echo "[+] Firewall policies successfully written."
echo "[+] Current Rule Posture:"
iptables -L -v -n
