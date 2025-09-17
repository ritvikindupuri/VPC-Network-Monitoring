#!/bin/bash

# A script to generate sample network traffic for VPC Flow Log analysis.
# Automates the process of generating both ACCEPT and REJECT traffic between your instances. 

# --- Configuration ---
SSH_KEY="your-key-pair.pem" # IMPORTANT: Replace with your .pem key file
EC2_USER="ec2-user"

# --- Script Arguments ---
if [ "$#" -ne 2 ]; then
    echo "Usage: $0 <Instance1_Public_IP> <Instance2_Public_IP>"
    exit 1
fi

INSTANCE1_IP=$1
INSTANCE2_IP=$2

echo "--- Starting Traffic Generation ---"
echo "Instance 1 (Source): $INSTANCE1_IP"
echo "Instance 2 (Target): $INSTANCE2_IP"
echo "-----------------------------------"

# Get the Private IP of Instance 2 by connecting to it
INSTANCE2_PRIVATE_IP=$(ssh -o StrictHostKeyChecking=no -i "$SSH_KEY" "$EC2_USER@$INSTANCE2_IP" "hostname -I | awk '{print $1}'")
echo "Discovered Instance 2 Private IP: $INSTANCE2_PRIVATE_IP"
echo ""

# --- Step 1: Generate ACCEPTED Traffic ---
echo "✅ Generating ACCEPTED traffic (ping)..."
echo "This should appear in Flow Logs as an 'ACCEPT' record."
ssh -o StrictHostKeyChecking=no -i "$SSH_KEY" "$EC2_USER@$INSTANCE1_IP" "ping -c 3 $INSTANCE2_PRIVATE_IP"
echo ""

# --- Step 2: Generate REJECTED Traffic ---
echo "❌ Generating REJECTED traffic (probing a closed port)..."
echo "This should appear in Flow Logs as a 'REJECT' record."
# We use timeout because the connection will hang until it times out
# Connecting to port 23 (telnet) which is not open in our Security Group
timeout 5 ssh -o StrictHostKeyChecking=no -o ConnectTimeout=5 -i "$SSH_KEY" "$EC2_USER@$INSTANCE1_IP" "nc -zv $INSTANCE2_PRIVATE_IP 23"
echo "(Command may show a timeout error, which is expected)"
echo ""

echo "--- Traffic Generation Complete ---"
echo "Wait a few minutes for the events to appear in your CloudWatch Log Group."
