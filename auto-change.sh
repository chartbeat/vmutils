#!/bin/bash
#
# If the hostname != the VMWare guest property 'hostname', change it
# in the appropriate places and reboot the box.
#

VALUE=`sudo VBoxControl -nologo guestproperty get hostname`
if [ "$VALUE" == "No value set!" ]; then
    echo No value set
else
    NEWNAME=`echo $VALUE | cut -f 2 -d ' '`
    if [ -z $NEWNAME ]; then
	echo No name set, exiting
    else 
	CURNAME=`hostname -s`

	if [ "$NEWNAME" == "$CURNAME" ]; then
	    echo No name change
	else
	    echo Machine name changed, doing name change to: $NEWNAME
	    sudo /usr/local/bin/change-hostname.sh $NEWNAME

            # TODO: should not be needed, if we just change it early
            # enough in the boot process
	    sudo reboot
	fi
    fi
fi
