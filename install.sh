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

#Alert systemd of a new service file
systemctl daemon-reload
#Run on boot
systemctl enable gpio_halt.service
#Starts the service now
systemctl start gpio_halt.service


    echo "=="
    echo "== This package defaults to gpio pin 4 (header 7) and ground."
    echo "== If you choose a different pin, edit /usr/bin/gpio_halt"
    echo "=="
    echo "== Make sure the spst switch is connected from ground to the"
    echo "== specified header. Then continue:"
    echo "=="
    echo "== The service is not active, make sure to run:"
    echo "== $ systemctl daemon-reload"
    echo "== $ systemctl enable gpio_halt.service"
    echo "=="
    echo "== Holding the button for >=6 seconds and releasing will then"
    echo "== cause the system to safely shutdown."
    echo "=="

