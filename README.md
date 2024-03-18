# Purpose
This script allows to perform the initial setup of a newly installed zapper to a Riverside device.
* Imports LP keys from lab and user rmartin013 (lab keys are mandatory for TF jobs)
* Optionally (if arg 2 is provided) modify the hostname to "zapper-<CID>" (CID being the DUT's one)
* Create udev rules to match boot media devices (to make sure the device name is always predictable)
  * SD card connected via sdwire is symlinked to /dev/sd-disk
  * Transcend Jetflash USB stick connected via typecmux is symlinked to /dev/tc-disk

# Usage
zapper-setup$ ./zapper-setup-4-riverside.sh 10.102.232.231 c33506