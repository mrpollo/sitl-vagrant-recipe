#!/bin/bash
# Title: SITL launcher
# Description: Helper lib to run SITL, its very limited at the moment and only understands how to run SITL for plane or copter
# Author: Ramón Roche
# Email: ramon@3drobotics.com
# Version: 0.0.1

if [[ ! -e `env | grep "RC_LOADED"` ]]; then
	# Make sure we always have the relevant paths included
	# this is a check for when sitl.sh is launched witouth loading bash
	# vagrant ssh -c "/vagrant/sitl.sh"
	source /home/vagrant/.ardupilot
fi

# define here to avoid problems with the above
SIM=`which sim_vehicle.sh`
SRC_PATH=/home/vagrant/src
ARDU_PATH="$SRC_PATH/ardupilot"
PLANE_HOME="$ARDU_PATH/ArduPlane"
COPTER_HOME="$ARDU_PATH/ArduCopter"
ROVER_HOME="$ARDU_PATH/APMrover2"


if [[ -z $SIM ]]; then
	echo "sim_vehicle.sh is not in PATH"
	exit;
fi

menu() {
	echo "SITL launcher"
	echo ""
	echo "Commands:"
	echo ""
	echo "  plane        <options>"
	echo "  copter       <options>"
	echo "  rover        <options>"
	echo ""
	while true; do
		read -p "Please enter a command (q to exit): " cmd
		args=`echo $cmd | awk '{$1=""; print $0}'`
		case $cmd in
			plane* ) runPlane $args; exit;;
			copter* ) runCopter $args; exit;;
			rover* ) runRover $args; exit;;
			q|quit|exit ) exit;;
			* ) echo "Please enter a valid command."; sleep 1; menu;;
		esac
	done
}

makeHeader() {
	echo "========================"
	echo ""
	echo "Ardupilot $1"
	echo ""
	echo "========================"
}

runPlane() {
	makeHeader "Plane"
	(cd $PLANE_HOME && runSim)
}

runCopter() {
	makeHeader "Copter"
	(cd $COPTER_HOME && runSim)
}

runRover() {
	makeHeader "Rover"
	(cd $ROVER_HOME && runSim)
}

runSim() {
	$SIM $0
}

menu
