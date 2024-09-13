#!/bin/bash

# This script disables screen suspension and restarts systemd-logind

sudo cp /etc/systemd/logind.conf /etc/systemd/logind.conf.bak
sed -i 's/#HandleLidSwitch=suspend/HandleLidSwitch=ignore/' /etc/systemd/logind.conf
sed -i 's/#HandleLidSwitchExternalPower=suspend/HandleLidSwitchExternalPower=ignore/' /etc/systemd/logind.conf
sudo systemctl restart systemd-logind

echo "Lid close behavior updated and systemd-logind restarted."