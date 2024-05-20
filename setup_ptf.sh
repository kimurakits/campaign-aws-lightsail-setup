#!/bin/bash

# Become the root user (super user)
sudo su -

# Update the list of packages
apt-get update

# Install Python
apt-get install -y python

# Install IPTables
apt-get install -y iptables

# Set up IPTables rules (example rules)
iptables -A INPUT -p tcp --dport 22 -j ACCEPT  # Allow SSH
iptables -A INPUT -p tcp --dport 80 -j ACCEPT  # Allow HTTP
iptables -A INPUT -p tcp --dport 443 -j ACCEPT  # Allow HTTPS
iptables -A INPUT -m conntrack --ctstate ESTABLISHED,RELATED -j ACCEPT
iptables -A INPUT -p icmp -j ACCEPT
iptables -P INPUT DROP  # Drop all other traffic
iptables -P FORWARD DROP
iptables -P OUTPUT ACCEPT
iptables -L  # List the rules

# Save the IPTables rules
iptables-save > /etc/iptables/rules.v4

# Install Certbot for SSL certificates
apt-get install -y certbot

# Obtain an SSL certificate (example for domain example.com)
# certbot certonly --standalone -d example.com --non-interactive --agree-tos --email your-email@example.com

# Clone the PenTesters Framework (PTF) repository
git clone https://github.com/trustedsec/ptf /opt/ptf

# Go into the PTF folder and start it
cd /opt/ptf && ./ptf << EOF
use modules/exploitation/install_update_all
use modules/intelligence-gathering/install_update_all
use modules/post-exploitation/install_update_all
use modules/powershell/install_update_all
use modules/vulnerability-analysis/install_update_all
EOF

# Go to the pentest folder
cd /pentest

# Tell the user the setup is complete
echo "Setup Complete"

