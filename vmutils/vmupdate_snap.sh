#!/bin/bash
#
# Update the given snapshot with the current state
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
OLD_SNAP="old_$SNAP"

echo "CMD: Renaming snapshot: $SNAP -> $OLD_SNAP"
VBoxManage snapshot $VM edit $SNAP --name $OLD_SNAP

echo "CMD: Taking new snapshot: $SNAP"
VBoxManage snapshot $VM take $SNAP

echo "CMD: Deleting snapshot: $OLD_SNAP"
VBoxManage snapshot $VM delete $OLD_SNAP
