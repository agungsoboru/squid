#!/bin/bash

if [ `whoami` != root ]; then
	echo "ERROR: You need to run the script as user root or add sudo before command."
	exit 1
fi
chmod 755 sok-find-os

chmod 755 squid-uninstall

chmod 755 squid-add-user

if [[ -d /etc/squid/ || -d /etc/squid3/ ]]; then
    echo "Squid Proxy already installed. If you want to reinstall, first uninstall squid proxy by running command: squid-uninstall"
    exit 1
fi

if cat /etc/os-release | grep PRETTY_NAME | grep "Ubuntu 20.04"; then
    /usr/bin/apt update
    /usr/bin/apt -y install apache2-utils squid3
    touch /etc/squid/passwd
    /bin/rm -f /etc/squid/squid.conf
    /usr/bin/touch /etc/squid/blacklist.acl
    #/usr/bin/wget --no-check-certificate -O /etc/squid/squid.conf https://raw.githubusercontent.com/serverok/squid-proxy-installer/master/squid.conf
    sudo cp squid.conf /etc/squid/
    if [ -f /sbin/iptables ]; then
        /sbin/iptables -I INPUT -p tcp --dport 3128 -j ACCEPT
        /sbin/iptables-save
    fi
    service squid restart
    systemctl enable squid

else
    echo "OS NOT SUPPORTED.\n"
    echo "Contact https://serverok.in/contact to add support for your os."
    exit 1;
fi

echo
echo "Thank you for using ServerOk.in Squid Proxy Installer."
echo "To create a proxy user, run command: squid-add-user"
echo 












############################################################
# Squid Proxy Installer
# Author: Yujin Boby
# Email: admin@serverOk.in
# Github: https://github.com/serverok/squid-proxy-installer/
# Web: https://serverok.in/squid
############################################################
# For paid support, contact
# https://serverok.in/contact
############################################################