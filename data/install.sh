#installtion commands for Mephistopheles 
#Don't run this machine in your local machine without monitoring it.
#user passwd : Shadow{Eminence_in_shadow}

#Repo update
echo -e "\e[1;31m Updating the system \e[0m"
apt update

#install apache 
echo -e "\e[1;31m [+] Installing Apache server \e[0m"
apt install -y apache2

echo -e "\e[1;31m [+] Installing and Configuring ftp \e[0m"
apt install -y vsftpd
mkdir /var/ftp
chown nobody:nogroup ftp/
sudo cp /etc/vsftpd.conf /etc/vsftpd.conf.bak
echo "anon_root=/var/ftp" >> /etc/vsftpd.conf

echo -e "\e[1;31m [+] Installing and Configuring ssh \e[0m"
apt install openssh-server
ufw allow ssh

echo -e "\e[1;31m [+] moving the binary to ftp \e[0m"
mv /root/data/alpha /var/ftp/alpha
chown nobody:nogroup /var/ftp/alpha

#priv esc
echo -e "\e[1;31m [+] moving the binary to ftp \e[0m"
echo 'int main() {setgid(0);setuid(0);system("wget http:/\/localhost:80");return 0;}' > /usr/local/bin/Gamma.c
gcc /usr/local/bin/Gamma.c -o /usr/local/bin/Gamma
chmod 644 /usr/local/bin/Gamma.c
chmod u+s /usr/local/bin/Gamma
#add user Shadow
echo -e "\e[1;31m [+] adding user Alpha \e[0m"
useradd -m Shadow
echo Shadow:'"Shadow{Eminence_in_shadow}"' | sudo chpasswd

#cleanup
echo -e "\e[1;31m [+] CLEANING UP \e[0m"
echo "[+] Disabling IPv6"
echo "net.ipv6.conf.all.disable_ipv6 = 1" >> /etc/sysctl.conf
echo "net.ipv6.conf.default.disable_ipv6 = 1" >> /etc/sysctl.conf
sed -i 's/GRUB_CMDLINE_LINUX_DEFAULT=""/GRUB_CMDLINE_LINUX_DEFAULT="ipv6.disable=1"/' /etc/default/grub
sed -i 's/GRUB_CMDLINE_LINUX=""/GRUB_CMDLINE_LINUX="ipv6.disable=1"/' /etc/default/grub
update-grub

echo "[+] Configuring hostname"
hostnamectl set-hostname Shadow
cat << EOF > /etc/hosts
127.0.0.1 localhost
127.0.0.1 Shadow
EOF

echo "[+] Disabling history files"
ln -sf /dev/null /root/.bash_history
ln -sf /dev/null /home/Shadow/.bash_history

echo "[+] Enabling root SSH login"
sed -i 's/#PermitRootLogin prohibit-password/PermitRootLogin yes/' /etc/ssh/sshd_config

echo "[+] Setting passwords"
echo "root:EminenceinShadowCidKagneou" | sudo chpasswd

echo "[+] Dropping flags"
echo "Shadow{Stay_in_the_shadows}" > /root/root.txt
echo "Shadow{Gamma_Beta_Epsilon}" > /home/Shadow/local.txt
chmod 0600 /root/root.txt
chmod 0644 /home/Shadow/local.txt
chown Shadow:Shadow /home/Shadow/local.txt 

echo "[+] Cleaning up"
rm -rf /root/install.sh
rm -rf /root/.cache
rm -rf /root/.viminfo
rm -rf /home/Shadow/.sudo_as_admin_successful
rm -rf /home/Shadow/.cache
rm -rf /home/Shadow/.viminfo
find /var/log -type f -exec sh -c "cat /dev/null > {}" \;

apt install default-jre
apt install default-jdk