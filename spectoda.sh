#!/bin/bash

sudo -v

NU=$(logname)

# Installation of spectoda-pws400k

cd /home/pi/

sudo -u $NU git clone https://github.com/Spectoda/spectoda-pws400k.git
cd /home/pi/spectoda-pws400k
sudo -u $NU npm install

content='[Unit]
Description=Bridge for connecting to Spectoda Ecosystem
After=network.target

[Service]
User=pi
Group=pi
WorkingDirectory=/home/pi/spectoda-pws400k
ExecStart=node main.js
Restart=on-failure
RestartSec=5s

[Install]
WantedBy=default.target'

# create the service file
echo "$content" |  tee /etc/systemd/system/spectoda-pws400k.service > /dev/null

# reload the daemon
systemctl daemon-reload

# enable the service
systemctl enable --now spectoda-pws400k

# Installation of moonraker-spectoda-connector

cd /home/pi/

sudo -u $NU git clone https://github.com/fragaria/moonraker-spectoda-connector.git
cd /home/pi/moonraker-spectoda-connector
sudo -u $NU npm ci

content='[Unit]
Description=Bridge for connecting to Moonraker events Spectoda REST API
After=network.target

[Service]
User=pi
Group=pi
WorkingDirectory=/home/pi/moonraker-spectoda-connector
ExecStart=node index.js
Restart=on-failure
RestartSec=5s

[Install]
WantedBy=default.target'

# create the service file
echo "$content" |  tee /etc/systemd/system/moonraker-spectoda-connector.service > /dev/null

# reload the daemon
systemctl daemon-reload

# enable the service
systemctl enable --now moonraker-spectoda-connector
