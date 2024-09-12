#!/bin/bash

# Save users and their key paths in a dictionary
USERS_KEYS="/root/server/users_keys.txt"
declare -A USER_KEYS
while read -r username key_path; do
    USER_KEYS["$username"]+="$key_path "
done < "$USERS_KEYS"

# Create user directories and add authorized_keys
for username in "${!USER_KEYS[@]}"; do
    if ! id "$username" >/dev/null 2>&1; then
        sudo useradd -m -s /bin/bash "$username"
        sudo mkdir -p /home/$username/.ssh
        sudo chmod 700 /home/$username/.ssh
        sudo touch /home/$username/.ssh/authorized_keys
        sudo chmod 600 /home/$username/.ssh/authorized_keys

        for key_path in ${USER_KEYS[$username]}; do
            if [ -f "$key_path" ]; then
                sudo cat "$key_path" >> /home/$username/.ssh/authorized_keys
                echo "Added key from $key_path for user $username."
            else
                echo "Key file $key_path not found for user $username."
            fi
        done

        sudo chown -R $username:$username /home/$username/.ssh
    fi
done

# Allow SSH and rsync traffic (optional IP-based configuration)
# while read ip; do
#     sudo ufw allow from "$ip" proto tcp to any port 22
#     sudo ufw allow from "$ip" to any port 873
# done < "$IPS"

# Allow SSH and rsync traffic
sudo ufw allow 22/tcp
sudo ufw allow 873

# Enable UFW and start SSH server daemon
sudo ufw enable
sudo ufw status verbose
sudo systemctl start sshd

# Disable password authentication for SSH and allow only key-based authentication
sudo sed -i 's/^#PasswordAuthentication yes/PasswordAuthentication no/' /etc/ssh/sshd_config
sudo sed -i 's/^#PubkeyAuthentication yes/PubkeyAuthentication yes/' /etc/ssh/sshd_config

# Restart sshd for auth changes to take effect
sudo systemctl restart sshd
sudo systemctl status sshd
