#!/bin/bash
#
# Brings back the VM to the initial state right after the cloning from
# the template (i.e. vmnew.sh)
#
NAME=$1
if [ -z $NAME ]; then
    echo "Usage: $0 <hostname>"
    echo "       (not fqdn, only hostname)"
    exit 1
fi

VBoxManage snapshot $NAME restore clean
