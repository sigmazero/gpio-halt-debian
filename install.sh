#!/bin/bash

#RUN SCRIPT AS SUPER USER

# Set up path to dir
LOCAL_DIR="$( dirname "$( readlink -f "$0" )" )"

#We will install wiring pi now
command -v gpio
if [ $? -eq 1 ]; then
if [ -d wiringPi ]; then
	cd wiringPi
	git pull origin master
else
	git clone git://git.drogon.net/wiringPi
	cd wiringPi
fi
./build
fi

#Now we will install GPIO Halt
install -D "${LOCAL_DIR}/gpio_halt.sh" "/usr/bin/gpio_halt"
install -D "${LOCAL_DIR}/gpio_halt.service" "/etc/systemd/system/gpio_halt.service"

systemctl daemon-reload
systemctl enable gpio_halt.service


systemctl start gpio_halt.service
