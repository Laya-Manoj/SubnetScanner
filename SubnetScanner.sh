#!/bin/bash

# Check if nmap is installed
if ! command -v nmap &> /dev/null; then
    echo "❌ Error: nmap is not installed. Please install it first."
    exit 1
fi

# Check input arguments
if [ "$#" -ne 1 ]; then
    echo "Usage: $0 <CIDR-subnet>"
    echo "Example: $0 192.168.1.0/24"
    exit 1
fi

SUBNET=$1

echo "🔍 Scanning subnet: $SUBNET ..."
echo "--------------------------------------"

# Perform a ping scan (-sn) to list active hosts
nmap -sn "$SUBNET" | grep -E "Nmap scan report|Host is up"

echo "--------------------------------------"
echo "✅ Scan complete!"
