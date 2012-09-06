#!/bin/bash
#
# Start the given VM and ssh into it.
#
LIBDIR=$0
if [ -h $LIBDIR ]; then LIBDIR=`readlink $LIBDIR`; fi
LIBDIR=`dirname $LIBDIR`
. $LIBDIR/common

VM=$1
get_vm

vm_state=$(get_state)

if [ $vm_state != "\"running\"" ]; then
    VBoxManage startvm --type headless $VM
fi

wait_for_up
ssh ubuntu@$VM.local
