#!/bin/sh
#
# Changes the hostname in all the needed places on the local VM.
#
# Not the prettiest script...

if [ $USER != "root" ]; then
    echo "You need to run this as root"
    exit 1
fi

if [ -z $1 ]; then
    echo "Usage: $0 <hostname>"
    echo "       Don't specify the FQDN, just the host name, i.e. like: $0 devping01"
    exit 2
fi
OLD=chartbeatdev01
NEW=$1

echo Renaming from $OLD to $NEW

# We have to blow away the puppetmaster's SSL certs because they have
# the (old) hostname in them.
service puppetmaster stop
rm -fR /var/lib/puppet/ssl

# Change the hostname in needed config files
sed -i "s/$OLD/$NEW/g" /etc/hostname
sed -i "s/$OLD/$NEW/g" /etc/hosts
sed -i "s/$OLD/$NEW/g" /etc/puppet/puppet.conf

echo Reboot, please
