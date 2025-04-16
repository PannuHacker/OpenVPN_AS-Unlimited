#!/bin/bash

clear
echo "   ___         _    ___  ___ ____   "
echo "  / __|___ _ _| |_ / _ \/ __|__  |  "
echo " | (__/ -_) ' \  _| (_) \__ \ / /   "
echo "  \___\___|_||_\__|\___/|___//_/    "
echo " OpenVPN Access Server With Unlimited License"
echo " Only Working Perfect with CentOS-7"

yum update -y
yum install wget -y
yum install net-tools -y
yum install iptables iptables-services -y
./merge_openvpn_parts.sh
RET_CODE=$?
if [ "$RET_CODE" -ne 0 ]; then
    echo "[-] Merging failed with code $RET_CODE"
    exit $RET_CODE
fi
rpm -i openvpn-as-2.5-CentOS7.x86_64.rpm
cd /usr/local/openvpn_as/lib/python2.7/site-packages/
rm pyovpn-2.0-py2.7.egg
cd /usr/local/openvpn_as/bin
./ovpn-init

echo "=========================DONE=============================="
echo "SETUP ADMIN PASSWORD"

passwd openvpn

echo "=========================DONE=============================="

echo "=================== Help Free ============="
