#!/bin/bash
# T1-M1-S02: SECURITY HARDENING AUTOMATION

# Phase 1: Secure local Vault
chmod 700 ~/Vault
chmod 600 ~/Vault/secrets.txt

# Phase 2: Secure system identity file
sudo chmod 640 /etc/shadow
sudo chown root:shadow /etc/shadow
