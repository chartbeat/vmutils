#!/bin/bash
#
# Instantiate a new VM from the template VM image.
#
LIBDIR=$0
if [ -h $LIBDIR ]; then LIBDIR=`readlink $LIBDIR`; fi
LIBDIR=`dirname $LIBDIR`
. $LIBDIR/common

VM=$1
if [ -z $VM ]; then
    echo "Usage: $0 <hostname>"
    echo "       (not fqdn, only hostname)"
    exit 1
fi

echo Cloning
VBoxManage clonevm chartbeatdev01 --name $VM --register
echo Set property
VBoxManage guestproperty set $VM hostname $VM
echo Snapshotting
VBoxManage snapshot $VM take clean
echo Starting
VBoxManage startvm --type headless $1

wait_for_up
