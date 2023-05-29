#!/bin/bash
###Please defind your gateway address here###
echo -n "Please define your gateway address:"
read target_gw
##target_gw=2222:2222::2222
###Please defind your main interface here ###
#net_iface=ens18#Automatically determine your MAIN IFACE
net_iface=$(ip r g 254.254.254.254|grep via|head -n 1|awk -v FS='dev ' '{print $2}'|cut -d ' ' -f 1)

echo "net.ipv4.ip_local_port_range = 32768 64999" >> /etc/sysctl.conf
ip r a 2602:fbda:730:aaaa::/48 dev $net_iface
ip -6 r r default via $target_gw dev $net_iface
sysctl -p
