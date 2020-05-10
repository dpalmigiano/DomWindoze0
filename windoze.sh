#!/usr/bin/bash
#For those times when windows just doesn't wanna install and you wanna speed up debugging and reduce errors: Automate the install and removal process, taking breaks along the way.
echo "Removing failed installation attempt -- win7-x64-template and winbak"
qvm-remove win7-x64-template && qvm-remove winbak
echo "Waiting 30 seconds for a clean removal"
sleep 30
echo "Creating Template -- win7-x64-template"
qvm-create --class TemplateVM --label black --property virt_mode=hvm win7-x64-template
echo "Setting Windows VM parameters -- win7-x64-template"
qvm-prefs win7-x64-template memory 4069
qvm-prefs win7-x64-template maxmem 4069
qvm-prefs win7-x64-template kernel ''
qvm-volume extend win7-x64-template:root 40g
qvm-prefs win7-x64-template debug true
qvm-features win7-x64-template video-model cirrus
qvm-prefs -s win7-x64-template qrexec_timeout 300
###Add a shell variable for the AppVM name and filepath containing the iso
echo "Finished. Starting from iso on ENTERTAIN:/home/user/win7.iso in 15 seconds -- win7-x64-template"
sleep 15
qvm-start --cdrom=ENTERTAIN:/home/user/win7.iso win7-x64-template
echo "When windows has been installed and rebooted once press any key to continue with backup -- winbak"
read -p "Press ENTER to continue"
qvm-clone -v win7-x64-template winbak
echo "Backup complete. Press any key to continue starting VM -- win7-x64-template -- without iso."
read -p "Press ENTER to continue"
qvm-start win7-x64-template
