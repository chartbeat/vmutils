#!/bin/bash
#
# Delete a VM
#
NAME=$1
if [ -z $NAME ]; then
    echo "Usage: $0 <hostname>"
    echo "       (not fqdn, only hostname)"
    exit 1
fi
VBoxManage unregistervm $NAME --delete
