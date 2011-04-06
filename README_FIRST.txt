==== v0.X.N ====

This hack, based on ebs' code, restores `usbNetwork functionality.
If you don't know what that means, then you probably shouldn't even be trying to use this.

If you don't understand half of what's written here, see the previous paragraph.

As always, it may void your warranty, eat your Kindle, kill a kitten, and sell your first
born's soul to the devil.

I *strongly* recommend having a proper Linux CLI sysadmin background before trying to use this,
or you *WILL* probably end up messing your Kindle up. Do *NOT* do anything with this unless
your are *REALLY* sure you understand what you're doing.


=== Install/Uninstall ===

Nothing fancy, as usual, with a jailbroken Kindle, just use the appropriate update file.


=== Usage ===

I'm gonna assume Linux/BSD/OS X here, Windows people, you're on your own.

* First of all, you'll need proper support for this stuff in your Kernel. (If you're using
OS X or aren't rolling your own kernel, you probably don't need to bother with this).

usbnet (CONFIG_USB_USBNET) & cdc_ether (CONFIG_USB_NET_CDCETHER)

(Still, a note to the poor Windows users: Yes, that means you'll need a non-default driver.)

* Plug & mount your Kindle.

* Take a moment to read, and edit, if need be, the config file in usbnet/etc/config.
In case you managed to miss the shiny warnings there: this *HAS* to use UNIX line endings,
and I really wouldn't recommend editing this while you're in usbnet mode.

I'd also recommend making sure everything works with a plain eth over usb telnet/ssh shell
before fiddling around in there. Same thing with enabling the 'auto' enable at boot feature,
make sure everything works like you want it to before shooting yourself in the foot with that.

* Now would be a good time to setup your public key if you intend to auth over SSH via shared keys.
Which you should, because it's awesome :D.
The pubkeys are stored, in OpenSSH format, in usbnet/etc/authorized_keys (ie. you can safely use
a ~/.ssh/authorized_keys2 file from OpenSSH).
Also, it's the preferred method of auth when using SSH over WiFi, because it's way more elegant
than switching the root password (Because you *WILL* need to auth properly over WiFi).

* unmount & eject your Kindle

* You'll need to be in debug mode to run private commands, so, on the Home screen, bring up the
search box by hitting [DEL], and enter:

;debugOn

* And now we can enable usbnet:

~usbNetwork

(Or `usbNetwork on FW 2.x)

* Your Kindle should now be detected as something like a RNDIS/Ethernet Gadget or CDC Ethernet Device network adapter.

* If you don't need to enter any more private commands, switch debug off.

;debugOff

* Now, to actually connect to the device, we'll need to bring the shiny usb network interface
the kernel prepared for us. I'm assuming it's the only USB network interface in the system, so, usb0 on Linux.
I'm also asusming the default usbnet config, ie. HOST_IP=192.168.2.1 & KINDLE_IP=192.168.2.2
Note to OS X users: You'll probably have to configure the network interface manually via OS X GUI.

# ifconfig usb0 192.168.2.1

* Depending on how your system set USB permissions up, you may still need to be root to connect to the device over USB.
I'm assuming you have a proper udev setup, so, I'll switch to a user shell now.

$ ssh root@192.168.2.2

or

$ telnet 192.168.2.2

Note that, when WiFi mode is enabled, telnetd won't be started, and the SSH daemon *WILL* require a proper password!
When WiFi mode is disabled, telnet will log you right in without password, and SSH will log you in with anything as
the password (even a blank one, so you can just type return).

* Like I said at the beginning, if you don't understand half of what you're doing here, go away before you brick your Kindle.
It's for your own good.

* When you're done, exit your shell on the Kindle, and bring the network if down before ejecting/unplugging your Kindle.

# ifconfig usb0 down


=== Notable changes ===

Works on FW 2.x & 3.x

Note that on FW 3.x, the private command prefix has been changed to ~ instead of `
(But private commands are still only available in debug mode).

SFTP & SCP support.

SSH/SFTP over WiFi support (check usbnet/etc/config). Note that when WiFi mode is enabled, passwords
*WILL* be checked. So make sure you know it, or auth via shared keys.

IP addresses configuration is done in usbnet/etc/config instead of in the usbnetwork script.

Shared key auth support. Store your public keys in usbnet/etc/authorized_keys (OpenSSH format).
You can safely use an OpenSSH ~/.ssh/authorized_keys2 file for example.

The usbnetwork script is now a toggle, meaning that if you enter the ~usbNetwork command
a second time, it'll switch back to USB Mass Storage mode, and stop telnetd & sshd, without having
to reboot your Kindle.

Don't forget to drop back to ;debugOff before using your Kindle normally, though.

The tethering scripts (Use Host networking on the Kindle) are in usbnet/bin/usbnet-*
They're pretty much untested, and I'm not precisely enclined to really support them,
so, you're on your own, and use at your own risk.

=== BUGS ===

In order to avoid the "nothing is exported over usb ms" issue after an update,
your Kindle will automatically switch back to USB MS before launching the update process.

In that effect, I'd recommend properly exiting your shell sessions and unplugging your Kindle
before launching an update, or wall will shout at you, and your terminal will freeze ;).

In the same vein, avoid booting your Kindle while plugged to a computer, it tends to make weird things happen...

--NiLuJe