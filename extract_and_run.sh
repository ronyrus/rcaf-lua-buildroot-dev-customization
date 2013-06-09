#!/bin/bash

TARGETDIR=$1

[[ $BASE_DIR != *sdk ]] && echo 'dada'

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
sudo mount --bind /home/maint/Developer/rcaf/mac_dev rony

echo "[[[[[[[[ chrooting ..."
sudo chroot . /bin/ash

