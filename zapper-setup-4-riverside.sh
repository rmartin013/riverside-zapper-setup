#!/bin/bash -ex

if [[ "$#" -lt 1 ]]; then
  echo "./zapper-setup-4-riverside.sh <device-ip> (<device-cid> optional)"
  exit 1
fi

DEVICE_IP=$1
DEVICE_CID=$2

SSH_OPTS="-o StrictHostKeyChecking=no -o UserKnownHostsFile=/dev/null"
_run() {
    ssh -t $SSH_OPTS ubuntu@$DEVICE_IP "$@"
}

_run ssh-import-id lp:ce-certification-qa lp:rmartin013
if [ -n "$DEVICE_CID" ]; then
  _run "sudo hostnamectl set-hostname zapper-$DEVICE_CID"
fi
_run 'echo "SUBSYSTEMS==\"usb\", ATTRS{idProduct}==\"1000\", ATTRS{idVendor}==\"8564\", SYMLINK+=\"tc-disk%n\", OPTIONS+=\"all_partitions\"" \
 | sudo tee /etc/udev/rules.d/10-muxpi-names.rules'
_run 'echo SUBSYSTEMS==\"usb\", ATTRS{manufacturer}==\"Generic\", ATTRS{product}==\"Ultra Fast Media Reader\", SYMLINK+=\"sd-disk%n\", OPTIONS+=\"all_partitions\" \
 | sudo tee -a /etc/udev/rules.d/10-muxpi-names.rules'
_run sudo udevadm trigger
