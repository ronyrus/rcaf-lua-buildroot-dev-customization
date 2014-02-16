#!/bin/bash

TARGETDIR=$1

[[ $BASE_DIR != *sdk ]] && echo 'not SDK build ... nothing to do' && exit

RUN_DIR=$TARGETDIR/../buildroot_run
echo "[[[[[[[[ 'run dir is:'$RUN_DIR"

echo "[[[[[[[[ removing old run dir content"
sudo umount $RUN_DIR/rony
sudo rm -rf $RUN_DIR
mkdir $RUN_DIR

echo "[[[[[[[[ extracting new rootfs"
sudo tar xf $TARGETDIR/rootfs.tar -C $RUN_DIR

cd $RUN_DIR

sudo mkdir rony
sudo mount --bind /home/rkelner/Developer/rainbow/mac_dev rony

sudo cp rony/config.json opt/rainbow/config.json
sudo cp -r rony/certs opt/rainbow/

sudo mkdir mnt/fs

echo "[[[[[[[[ chrooting ..."
sudo chroot . /bin/ash -c "/usr/bin/lua /opt/rainbow/rainbow.lua"
# sudo chroot . /bin/ash

