#!/bin/bash
# i3exit.sh - Called from i3 $mod+Shift+E, will ask if you want to shutdown or logout using dmenu

# Written by Tim Gremalm 2014-06-02 (tim@gremalm.se http://tim.gremalm.se)

shopt -s extglob
#If you set shopt -s extglob then you can also use:
# ?() - zero or one occurrences of pattern
# *() - zero or more occurrences of pattern
# +() - one or more occurrences of pattern
# @() - one occurrence of pattern
# !() - anything except the pattern

#dmenu options:
# -i	dmenu matches menu items case insensitively.
# RGB, #RRGGBB, and color names are supported.
# -nb color	defines the normal background color
# -nf color	defines the normal foreground color
# -sb color	defines the selected background color
# -sf color	defines the selected foreground color

#Is this script a symbolic link?
if [ -h $0 ]
then
	#echo Its a symbolic link $0
	realscriptpath=$( readlink $0)
else
	#echo Its not a symbolic link $0
	realscriptpath=$0
fi
#echo realscriptpath $realscriptpath

#Get the directory of the script
scriptdir=$(dirname $realscriptpath)
#echo scriptdir $scriptdir

#Set the full path to the commands-file
commandspath=$scriptdir\/commands.txt
#echo commandspath $commandspath

dmenuanswer=`cat $commandspath|dmenu -i -nb black -nf white -sb red -sf white`
#echo $dmenuanswer

case $dmenuanswer in
	Shutdown\ \(s\) )
		echo Shutdown
		gnome-terminal -e "sudo shutdown -h now"
		;;
	Reboot\ \(r\) )
		echo Reboot
		gnome-terminal -e "sudo shutdown -r now"
		;;
	Logout\ \(l\) )
		echo Log out
		i3-msg exit
		;;
	* )
		echo Cancel
esac

