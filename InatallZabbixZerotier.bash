#!/bin/bash

# Install Zabbix Agent
sudo apt update
sudo apt-get install zabbix-agent

# Update Zabbix Agent configuration
ZABBIX_SERVER="172.20.10.4"
sudo sed -i "s+Server=127.0.0.1+Server=$ZABBIX_SERVER+g" /etc/zabbix/zabbix_agentd.conf
sudo sed -i "s+ServerActive=127.0.0.1+ServerActive=$ZABBIX_SERVER+g" /etc/zabbix/zabbix_agentd.conf

# Enable Zabbix Agent 
sudo systemctl start zabbix-agent

# Install Zerotier-one 
curl -s https://install.zerotier.com | sudo bash

echo "Zabbix Agent and ZeroTier have been installed and configured."
