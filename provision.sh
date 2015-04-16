#!/bin/bash

doBlock() {
	SEP="==================================="
	echo "$SEP"
	echo ""
	echo "[SITL]: $1 [`date`]"
	echo ""
	echo "$SEP"
	echo ""
}

doBlock "SITL Provision"

# Create src directory
doBlock "Create source directory"
SRC_DIR='/home/vagrant/src'
mkdir $SRC_DIR
cd $SRC_DIR

# Update library cache
apt-get update -y
# Install essential utilities
doBlock "Install essential utilities"
apt-get -y install git wget vim build-essential

# Get ardupilot sources
doBlock "Get ardupilot sources"
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

# Make sure cloned repos have write/read access to vagrant user
chown -R vagrant:vagrant .

# JSBSIM
doBlock "JSBSIM make"
# we need to install some utilities to compile
apt-get install -y libtool automake autoconf libexpat1-dev
cd jsbsim/
./autogen.sh --enable-libraries
make
make install

# return to sources directory
cd $SRC_DIR

# Python
doBlock "MAVProxy and PyMavlink"
apt-get -y install python-dev python-pip
easy_install -U pip

# MAVProxy and PyMavlink
# dependencies
apt-get install -y python-matplotlib python-serial python-wxgtk2.8 python-lxml
apt-get install -y python-scipy python-opencv ccache gawk git python-pip python-pexpect
pip install pymavlink MAVProxy

# ENV required to run SITL properly
doBlock "ENV required to run SITL properly"
sudo echo "export SRC_DIR='/home/vagrant/src'
export PATH=\$PATH:\$SRC_DIR/jsbsim/src
export PATH=\$PATH:\$SRC_DIR/ardupilot/Tools/autotest
export PATH=/usr/lib/ccache:\$PATH" >> /home/vagrant/.ardupilot
sudo echo "export RC_LOADED=true
source /home/vagrant/.ardupilot" >> /home/vagrant/.bashrc
sudo chown vagrant:vagrant /home/vagrant/.ardupilot

source /home/vagrant/.bashrc

# Copy SITL launcher
doBlock "Copy SITL launcher"
cp /vagrant/sitl.sh /home/vagrant

doBlock "SITL provision ended"
