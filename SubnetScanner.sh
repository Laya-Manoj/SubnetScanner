#!/bin/bash

if [ "$#" -ne 2 ]; then
    echo "Usage: $0 <subnet> <netmask>"
    exit 1
fi

SUBNET=$1
NETMASK=$2

# Calculate the start and end IP addresses for the given subnet
IFS='.' read -r -a octets <<< "$SUBNET"

# Calculate range of IPs in the subnet
START_IP="${octets[0]}.${octets[1]}.${octets[2]}.1"
END_IP="${octets[0]}.${octets[1]}.${octets[2]}.254"

echo "Scanning subnet $SUBNET with netmask $NETMASK"
echo "Scanning from $START_IP to $END_IP..."

for (( ip=1; ip<=254; ip++ )); do
    # Construct the IP address
    CURRENT_IP="${octets[0]}.${octets[1]}.${octets[2]}.$ip"

    # Ping the current IP address
    ping -c 1 -w 1 $CURRENT_IP &>/dev/null
    if [ $? -eq 0 ]; then
        echo "Host $CURRENT_IP is up"
    fi
done

echo "Scan complete!"
