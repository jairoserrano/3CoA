#!/bin/bash
# John Alexander Sanabria Ordonez <john.sanabria@correounivalle.edu.co>
# 3CoA

serv=("avahi-daemon" "avahi-dnsconfd" "autofs" "bluetooth" "conman"
"cups" "dhcdbd" "dund" "iptables" "irda" "firstboot" "kdum"
"kudzu" "mcstrans" "mdmpd" "netconsole" "netplugd"
"NetworkManager" "oddjobd" "pand" "pcscd" "rdisk" "restorecond"
"saslauthd" "sendmail" "setroubleshoot" "wpa_supplicant"
"ypbindg")

desc() {
	for i in ${serv[@]}; do
		echo "--------${i}----------"
		service ${i} status
		if [ $? == 0 ]; then
			chkconfig ${i} off
			chkconfig --list ${i}
			service ${i} stop
			service ${i} status
		fi
	done
}

desc
