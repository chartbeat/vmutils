#!/bin/bash
#
# Forcefully power off the VM (i.e. cut the power).
#
LIBDIR=$0
if [ -h $LIBDIR ]; then LIBDIR=`readlink $LIBDIR`; fi
LIBDIR=`dirname $LIBDIR`
. $LIBDIR/common

VM=$1
get_vm

poweroff
