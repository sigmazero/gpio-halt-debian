#!/bin/bash

#We will install wiring pi now
if [ -d wiringPi ]; then
	cd wiringPi
	git pull origin master
else
	git clone git://git.drogon.net/wiringPi
	cd wiringPi
fi
sudo ./build

#Now we will install GPIO Halt
install -D gpio_halt.sh /usr/bin/gpio_halt
install -D gpio_halt.service /etc/systemd/system/gpio_halt.service

systemctl daemon-reload
systemctl enable gpio_halt.service


systemctl start gpio_halt.service
