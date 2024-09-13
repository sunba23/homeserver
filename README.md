# Simple home server
This repository contains:
- Script for quick set up of a simple home server secured with key auth, ufw and [fail2ban](https://github.com/fail2ban/fail2ban), given a list of usernames and paths to their pubkey(s); along with some laptop configuration scripts,
- Additional scripts for synchronization with [rsync](https://github.com/rsyncproject/rsync), backup creation with tar & rsync.
## Setup (root on host)
1. Clone and cd into repo
```bash
git clone https://github.com/sunba23/homeserver.git
cd homeserver/server/
```
2. (Optional) Put your ssh pubkey(s) in `server/setup/pubkeys/`
```bash
└── pubkeys
    ├── key1.pub
    ├── key2.pub
    └── key3.pub
```
3. Match users to their pubkeys in `server/setup/users_keys.txt` and put the users_keys.txt filepath in `server/VARIABLES`.
```
user1 /path/to/key1.pub
user1 /path/to/key2.pub
user2 /path/to/key3.pub
```
4. Install required packages and run server
```bash
sudo apt install openssh-server ufw
chmod +x run_server.sh
run_server.sh
```
### Extras
[Script](server/scripts/laptop_scripts/lid_config.sh) disabling laptop suspension.
## Connecting via SSH
Inside LAN, connect with `ssh username@private_ip`.\
Outside LAN, you need to add NAT rules authorizing SSH communication with your home server. In your router settings add a rule for your server machine to use port 22 (internal and external) for communication. Then connect with `ssh username@public_ip`. Additionally, you may want to configure dynDNS (with eg. [no-IP](https://www.noip.com/)) in your router settings, then connect using your custom domain.
## Script - file sync with rsync
Use [the scripts](client/scripts/rsync_scripts/) to synchronize files across different devices that have ssh access to your server. Set `SSH_USER`, `SSH_ADDRESS`, and `SYNC_FOLDER` in `client/VARIABLES` and then use the pull and push scripts to achieve the below functionality. \
\
[![rsync demo](http://img.youtube.com/vi/OztlTa4PURg/0.jpg)](http://www.youtube.com/watch?v=OztlTa4PURg "rsync synchronization")
## Script - backups with tar & rsync
Use [the script](client/scripts/backup_scripts/create_backup.sh) to create backup of your local folders on remote server. Set `BACKUP_DIR`,
`INCLUDE_ITEMS_HOME` and `INCLUDE_ITEMS_NON_HOME` in `client/variables`