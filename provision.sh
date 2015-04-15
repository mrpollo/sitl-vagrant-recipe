#!/bin/bash
SRC_DIR='/vagrant/src'

cd $SRC_DIR

apt-get update -y
apt-get -y install git wget vim build-essential

if [[ -z `ls | grep PX4Firmware` ]]; then
	git clone https://github.com/diydrones/PX4Firmware.git
fi
if [[ -z `ls | grep PX4NuttX` ]]; then
	git clone https://github.com/diydrones/PX4NuttX.git
fi
if [[ -z `ls | grep uavcan` ]]; then
	git clone https://github.com/PX4/uavcan.git
fi
if [[ -z `ls | grep ff` ]]; then
	git clone git://github.com/tridge/jsbsim.git
fi
if [[ -z `ls | grep ardupilot` ]]; then
	git clone https://github.com/diydrones/ardupilot.git
fi

apt-get install -y libtool automake autoconf libexpat1-dev
cd jsbsim/
./autogen --enable-libraries
make
make install

cd $SRC_DIR
apt-get -y install python-dev python-pip
easy_install -U pip

apt-get install -y python-matplotlib python-serial python-wxgtk2.8 python-lxml
apt-get install -y python-scipy python-opencv ccache gawk git python-pip python-pexpect
pip install pymavlink MAVProxy

sudo echo "export SRC_DIR='/vagrant/src'
export PATH=\$PATH:\$SRC_DIR/jsbsim/src
export PATH=\$PATH:\$SRC_DIR/ardupilot/Tools/autotest
export PATH=/usr/lib/ccache:\$PATH" >> /home/vagrant/.ardupilot
sudo echo "export RC_LOADED=true
source /home/vagrant/.ardupilot" >> /home/vagrant/.bashrc
sudo chown vagrant:vagrant /home/vagrant/.ardupilot

source /home/vagrant/.bashrc
