#!/bin/bash
ZABBIX_SERVER="172.20.10.4"

# Get the IP address of this machine
AGENT_IP=$(ip addr show | grep -oP 'inet \K[\d.]+')

# Get the hostname of this machine
AGENT_HOSTNAME=$(hostname)

# Install Zabbix Agent
sudo apt update
sudo apt install zabbix-agent -y

# Update Zabbix Agent configuration
sudo sed -i "s+Server=127.0.0.1+Server=$ZABBIX_SERVER+g" /etc/zabbix/zabbix_agentd.conf
sudo sed -i "s+ServerActive=127.0.0.1+ServerActive=$ZABBIX_SERVER+g" /etc/zabbix/zabbix_agentd.conf
sudo sed -i "s+# ListenIP=0.0.0.0+ListenIP=$AGENT_IP+g" /etc/zabbix/zabbix_agentd.conf
sudo sed -i "s+# Hostname=Zabbix server+Hostname=$AGENT_HOSTNAME+g" /etc/zabbix/zabbix_agentd.conf

# Enable and start Zabbix Agent
sudo systemctl enable zabbix-agent
sudo systemctl start zabbix-agent

# Install ZeroTier
if ! command -v zerotier-one &>/dev/null; then
    curl -s https://install.zerotier.com | sudo bash
    if [ $? -eq 0 ]; then
        echo "ZeroTier installed successfully."
    else
        echo "Error installing ZeroTier."
        exit 1
    fi
else
    echo "ZeroTier is already installed."
fi

echo "Zabbix Agent and ZeroTier have been installed and configured."
