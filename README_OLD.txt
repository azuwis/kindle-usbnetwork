Version 0.11 (20100124)

This is unofficial Kindle DX/K2 firmware update file that restores `usbNetwork functionality.
If you don't know what that means - then you don't need this update.

This is NOT Amazon approved stuff, DO NOT USE if are not comfortable executing random
things from Internet :). It may eat your Kindle, void warranty, etc.

You have been warned.

==== Installation ====

Copy update_usbnetwork.bin (DX version) or update_usbnetwork-k2.bin (K2 version) to the
root of the mass storage Kindle partition and perform manual update.
Installation progress is saved to usbnetwork_install.log, review it (if installation
was successful, you'll see "Done!" at the end) and remove it afterward.

Installation creates 'usbnet' directory on your mass storage partition and put all
executables there. The only modification to the original firmware is a symbolic link
/test/bin/usbnetwork which points to /mnt/us/usbnet/usbnetwork.
This will allow you to easily modify this script without performing firmware updates.

Please review usbnet/usbnetwork script and tweak IP addresses to match your local setup.
Hacked telnet and ssh daemons are automatically started. Telnetd doesn't ask for any auth
info and just gives you root shell. When asked for SSH root password - enter anything.

==== Deinstallation ====

Install the uninstaller:
update_uninstall_usbnetwork-XX.bin
Then manually delete the directory usbnet on the Kindle USB drive

Or (old method)

In Kindle root shell:

[root@kindle root]# mntroot rw
[root@kindle root]# rm /etc/init.d/usbnet
[root@kindle root]# rm /test/bin/usbnetwork
[root@kindle root]# rmdir /test/bin
[root@kindle root]# mntroot ro
[root@kindle root]# /mnt/us/bin/usbnet-disable

Then delete 'usbnet' directory from the user store partition

--ebs