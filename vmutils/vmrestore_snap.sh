#!/bin/bash
#
# Restore VM state to a given snapshot
#
LIBDIR=$0
if [ -h $LIBDIR ]; then LIBDIR=`readlink $LIBDIR`; fi
LIBDIR=`dirname $LIBDIR`
. $LIBDIR/common

VM=$1
get_vm

poweroff

SNAP=$2
get_snap

echo "CMD: Restoring snapshot $SNAP on $VM"
VBoxManage snapshot $VM restore $SNAP

if [ $? != 0 ]; then
    echo "Got unexpected output from VBoxManage, exiting"
    exit 1
fi

echo "CMD: Starting $VM"
VBoxManage startvm --type headless $VM

wait_for_up

ssh ubuntu@$VM.local
