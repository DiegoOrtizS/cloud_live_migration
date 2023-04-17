#!/bin/bash

VBoxManage starvm "vm_a"

sleep 60
VBoxManage guestcontrol "vm_a" run --exe /bin/stress-ng --no-wait-stdout --username user --password password  --cpu 3 --io 3 --vm 1 --vm-bytes 10M --timeout 10s &

sleep 5
VBoxManage modifyvm "vm_b" --teleporter on --teleporterport 8080 --teleporterpassword password

sleep 5
VBoxManage starvm "vm_b" --type separate

sleep 5
VBoxManage controlvm "vm_a" teleport --host "IP_LOCAL" --port 8080 --password password

