# Simple home server
Script(s) for my simple home server setup + documentation on setting up and features showcase.
## Setup (root on host)
1. Clone and cd into repo
```bash
git clone https://github.com/sunba23/homeserver.git
cd homeserver
```
2. (Optional) Put your ssh pubkey(s) in keys/
```bash
└── keys
    ├── key1.pub
    ├── key2.pub
    └── key3.pub
```
3. Match users to their pubkeys in users_keys.txt
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
## Connecting via SSH
Inside LAN, connect with `ssh username@private_ip`.\
Outside LAN, you need to add NAT rules authorizing SSH communication with your home server. In your router settings add a rule for your server machine to use port 22 (internal and external) for communication. Then connect with `ssh username@public_ip`. Additionally, you may want to configure dynDNS (with eg. [no-IP](https://www.noip.com/)) in your router settings, then connect using your custom domain.

## File sync with rsync
TODO