#!/bin/bash
ZABBIX_SERVER="172.20.10.4"

# Install Zabbix Agent
sudo apt update
sudo apt install zabbix-agent -y

# Backup Zabbix Agent 
sudo mv /etc/zabbix/zabbix_agentd.conf /etc/zabbix/zabbix_agentd.conf.original
sudo cp /etc/zabbix/zabbix_agentd.conf.original /etc/zabbix/zabbix_agentd.conf

# Update Zabbix Agent configuration
sudo sed -i "s+Server=127.0.0.1+Server=$ZABBIX_SERVER+g" /etc/zabbix/zabbix_agentd.conf
sudo sed -i "s+ServerActive=127.0.0.1+ServerActive=$ZABBIX_SERVER+g" /etc/zabbix/zabbix_agentd.conf

# Enable Zabbix Agent 
sudo systemctl enable zabbix-agent
sudo systemctl start zabbix-agent

# Install ZeroTier
curl -s https://install.zerotier.com | sudo bash

echo "Zabbix Agent and ZeroTier have been installed and configured."


