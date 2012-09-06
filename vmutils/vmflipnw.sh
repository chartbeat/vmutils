#!/bin/bash
#
# Flip the VM's network interface: I.e. turn it off and then on
# again. A weak attempt at "fixing" that VMs sometimes seem to lose
# network connectivity.
#
LIBDIR=$0
if [ -h $LIBDIR ]; then LIBDIR=`readlink $LIBDIR`; fi
LIBDIR=`dirname $LIBDIR`
. $LIBDIR/common

VM=$1
get_vm

echo Turning network off
VBoxManage controlvm $VM setlinkstate1 off
echo Sleeping...
sleep 10
echo Turning network on
VBoxManage controlvm $VM setlinkstate1 on

wait_for_up
ssh ubuntu@$VM.local
