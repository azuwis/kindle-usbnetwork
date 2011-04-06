Since it didn't seem to be clear for everyone where to find the updated hacks for the 2.5.x updates (at the time), I took it upon myself to make this (hopefully) clean & clear post about it! (And a bit long, I know... Sorry :p)

First things first, a huge thanks to the original creators/updaters of these hacks, all the people who, at some point, worked on these hacks, and some of the pioneers! In no particular order:
* clarknova : http://www.mobileread.com/forums/showpost.php?p=963004&postcount=2 for the first 2.5.x jailbreak & screensavers hacks
* porkupan : http://www.the-ebook.org/forum/viewtopic.php?t=11259 for one of the first bind mount based fonts hack
* kukyakya : http://www.mobileread.com/forums/showthread.php?t=87995 for the usb watchdog & update-safe tweaks : https://redmine.kukyakya.pe.kr/projects/customfont/wiki/Customfont
* jyavenard : http://www.mobileread.com/forums/showthread.php?t=63225 for the packager
* tedsan : https://sites.google.com/a/etccreations.com/kdesignworks/Home/font-install-files & blogkindle : http://blogkindle.com/unicode-fonts-hack/ for their fonts hack
* igorsk : http://igorsk.blogspot.com/, ebs : http://www.mobileread.com/forums/showthread.php?t=49350 & Jesse Vincent  : http://blog.fsck.com/ for all they did to make this possible!
* yifanlu : http://www.mobileread.com/forums/showthread.php?t=122519 and dsmid : http://www.mobileread.com/forums/showthread.php?t=122000 for the Kindle 3.1 jailbreak!

*Latest Updates (03/07/2011):*

JailBreak v0.6.N (works on 3.1, thanks to yifanlu!), USBNetwork v0.32.N (updated a whole bunch of binaries), Fonts v4.4.N (updated libs), ScreenSavers v0.20.N.



*Note for Kindle 3.1 Users:*

If you haven't done so already (either with >= 0.5.N or yifanlu's jailbreak), please update your jailbreak hack.



*IMPORTANT NOTE REGARDING UPDATES:*

Here are general *update* instructions for these hacks:

    * First of all, no need to touch the jailbreak again. You already installed it the first time you installed hacks. Just forget about it now ;).
    * Next, no need to run the update_*_uninstall.bin updates, ever. (except in some specific cases, like if you're updating from another font/ss hack [in which case you should use the original uninstaller for your hacks, and not the ones found here]).
    * Then, you can apply the latest update_*_install.bin updates, one by one. You can safely chain both hacks installs.
    * After that, to make sure everything's in order, do a full Restart of your Kindle (*[HOME] -> [MENU] > Settings -> [MENU] > Restart*), and you'll be good to go ;). Note that in some cases, especially for minor updates, this restart is not strictly necessary, but better be safe than sorry ;).



*INSTALL:*

*Jailbreak:*

Download the attached kindle-jailbreak-0.6.N.zip file, and unpack it. In here, you'll find a bunch of .bin files, and a src directory.
Leave the directory alone, and upload the correct *update_*_install.bin* file for your kindle to the root directory of your Kindle.
(As always, k2 means K2 US, k2i means K2 GW, dx means KDX US, dxi means KDX GW, dxg means KDX Graphite, k3g means K3 3G (US [B006]), k3w means K3 WiFi [B008] and k3gb means K3 3G (UK [B00A]).
For a Kindle 2 International, that would be *update_jailbreak_0.6.N_k2i_install.bin* for example.

Now, eject your Kindle, and go to *[HOME] -> [MENU] > Settings -> [MENU] > Update Your Kindle*. It should be quick. (And, on FW 2.x only, it should *FAIL* (With a *U006* error, in the bottom left corner of the screen). It's completely normal, intended, and *harmless*).

And that's it, your Kindle is now ready to install custom hacks!


*ScreenSavers:*

Download the attached kindle-ss-0.20.N.zip file, and unpack it. In here, you'll find a bunch of .bin files, and a src directory.

First, upload the correct *update_*_install.bin* file for your kindle to the root directory of your Kindle.
For a Kindle 2 International, that would be *update_ss_0.20.N_k2i_install.bin* for example.

Now, eject your Kindle, and go to *[HOME] -> [MENU] > Settings -> [MENU] > Update Your Kindle*. It should take a couple dozen of seconds.

To change your custom screensavers, plug your Kindle to your computer via USB, and upload them to the *linkss/screensavers* folder that has been created by the hack. You'll have to restart your Kindle in order to take your new screensavers into account. To that effect, you can either use the autoreboot feature, or simply do a full restart of your Kindle.

To use the autoreboot feature: Just drop a blank file named *reboot* in the linkss folder (by copying and renaming the already existing "autoreboot" blank file, for example) (*or in the linkfonts folder if you also have the fonts hack installed!*), and your Kindle will do a quick reboot 10s after you've unplugged it!

If you want to randomize the sequence in which your screensavers will be shown, create a blank file named *random* in the linkss folder (right alongside the "auto" file), and then do a full restart of your Kindle! This will shuffle your screensavers around on each boot.


*Fonts:*

Download the attached kindle-fonts-4.4.N.zip file, and unpack it. In here, you'll find a bunch of .bin files, and a src directory.
*NOTE:* Since v3.9.N, this package has been split in two (solely because we were over the attachment size limit :D).
The K2, K2I, DX, DXI and DXG packages are in the kindle-fonts-4.4.N-k2.zip archive, and the K3G, K3W and K3GB packages are in the kindle-fonts-4.4.N-k3.zip archive.

First, upload the correct *update_*_install.bin* file for your kindle to the root directory of your Kindle.
For a Kindle 2 International, that would be *update_fonts_4.4.N_k2i_install.bin* for example.

Now, eject your Kindle, and go to *[HOME] -> [MENU] > Settings -> [MENU] > Update Your Kindle*. It should take a few dozen of seconds. If you're on FW 3.x, and this is your first install, it may seem to hang for about a minute or two on the "Update successful, Your Kindle is restarting..." screen, that's okay.

If you want to change the fonts used by the hack, you'll have to upload them in the *linkfonts/fonts* directory, strictly following the usual naming scheme. (Type_Style.ttf) (for details on where each font is used, please see this post : http://www.mobileread.com/forums/showpost.php?p=977006&postcount=97). The default fonts installed by the hack are the usual non-cjk unicode fonts (Droid Sans, Droid Serif & DejaVu Sans Mono), with the addition of the CJK-aware Droid Fallback if you're on FW 3.x. You'll find a bunch of other prepackaged, ready to use, font sets here, and in the next few replies.

You'll have to restart your Kindle in order to properly take your new fonts into account.

*By default, the autoreboot feature is enabled*. If you wish to make use of it, don't forget to drop a blank file named *reboot* in the linkfonts folder (right alongside the "autoreboot" file, by copying and renaming it, for example). When that file is present, your Kindle should automatically do a quick reboot 10s after you've unplugged it.

*FW 3.x:* If you chose to handle the browser fonts, this will add a considerable overhead to this process (We need to regenerate FontConfig's config & cache). That can take more than a couple of minutes! It'll happen each time you update your fonts, either during the framework startup if you did a full restart, or *before the framework restart when using the autoreboot feature!*. So, if you're switching fonts on a K3, and you have enabled the browser fonts handling (more on that later), and you use the autoreboot feature, don't be surprised if it takes considerably more than 10s before the framework restarts!

Another thing to take into account with the FW 3.x is that the settings of the rendering engine have changed a bit. It now makes use of the TrueType bytecode hinting instructions of your fonts, and uses them to hint at the most aggressive level. (In terms of FT/FC settings: hinting=true, hintstyle=hintfull, autohint=false). What this means is that fonts without hinting instructions (or with crappy code) will look considerably fuzzier than they did before. It's especially noticeable at small sizes, and in the browser.

If you really want to be able to tweak the browser fonts, and don't care about the overhead involved, just remove the *nobrowser* file in the linkfonts folder, and Restart your Kindle, and wait. A lot. *NOTE*: Because regenerating the cache takes so much time, we won't try to handle the browser fonts by default, in order not to waste 5 minutes each font switch.

There's also two new custom fonts used for rendering non-latin scripts. CJK.ttf, like the name implies, is used to render Chinese/Japanese/Korean scripts. After that, there's I18N.ttf, which is used as a fallback. By default, the hack uses the DejaVu Sans font. While it's far more pretty than the vanilla fallback font usually used (code2000), it does seem to support a lot less different types of scripts. Long story short, if you have weird non-latin rendering issues, those are the two fonts you should look at ;).

If you don't use the autoreboot feature (for exemple if you removed the autoreboot file in the linkfonts folder), you'll have to do at least a framework restart each time you change the fonts. If you have no means of doing a framework restart (ie. via usbnetwork), you'll have to do a full restart via the Settings menu, or by holding the power switch for ~15 seconds). Do note that the autoreboot & Restart methods are both way cleaner (and possibly safer) than the physical hard-reboot (which basically just plugs the battery off for a little while, which explains why your Kindle needs to be unplugged from any power source for this to work).

/!\ Be careful, if you miss a font, the hack won't be applied, so you shouldn't have any problem, but if for some reason, the Kindle software doesn't like one of your custom font, they'll be garbled, or invisible. Also, it may prevent you from actually _seeing_ the Settings page to do the restart. (And actually reading any books, also.) If that happens to you, try one of the three methods described earlier to reboot your Kindle. *If you want to avoid this kind of issue, use the autoreboot feature ;)* Also, *don't remove the other fonts found in the linkfonts/fonts folder*. We need them, and the hack won't be applied if they're missing.

*FW 3.x:* Apparently, even when using the autoreboot feature, some of you are still encountering some of these weird issues (on FW 3.x only!). To try to workaround this, I have packaged some of these fonts as an update file. Check this post : http://www.mobileread.com/forums/showpost.php?p=1139265&postcount=767 for more details. It might not fix the issue at all, but it is a neat way to package the fonts ;). What might fix these issues, though, is using an ft override (check the next paragraph)!

*Since v4.0.N:* You can now control a bit more the settings used by the rendering engine. For example, if you want to make sure it'll be using FreeType's autohinter (like on FW 2.x) instead of native hinting on FW 3.x, drop a blank *autohint* file in the linkfonts folder. The same applies on FW 2.x if you want to make sure the renderer uses native hinting (like FW 3.x) instead of the autohinter on FW 2.x, drop a blank *bci* file in the linkfonts folder.
You will have to do a full *Restart* of your Kindle for the changes to be taken into account (a framework restart won't be enough).
(Note that both settings are always available (ie. you can use bci on FW 3.x, and autohint on FW 2.x), in which case while the rendering should be mostly similar to your Kindle's defaults, it won't be exactly the same, due to changes in FreeType, and possibly patches Amazon might be using. If you have both files present, autohint will take precedence. It might also impact page turns perceived speed (good or bad, YMMV).)
*v4.1.N:* In addition to autohint & bci, there is now a third setting available: *light*. It's based on autohint, but with lighter hinting and a bunch of other tweaks used in order to try to preserve each glyph's shape, at the expense of being potentially a bit fuzzier. It's a bit like font rendering on OS X. It might very well look better than both the autohint or bci settings in the latest versions of the Hack.
*NOTE:* For obvious reasons (it's a bit more intrusive than usual), this is disabled by default. But it might very well workaround the 'blank fonts' issue some of you have been suffering on FW 3.x ;).
*NOTE:* If all of this is still a bit unclear, please check this post : http://www.mobileread.com/forums/showpost.php?p=1210081&postcount=1066. And if you're still confused, you can of course skip this feature entirely ;).


*WIKI:*

If you have some trouble with by briefs instructions, the MR wiki has been updated (with some screenshots):
Fonts Hack: http://wiki.mobileread.com/wiki/Kindle_Font_Hack_for_all_2.x_and_3.x_Kindles
SS Hack: http://wiki.mobileread.com/wiki/Kindle_Screen_Saver_Hack_for_all_2.x_and_3.x_Kindles


*NOTES:*

Some people reported losing their collections when installing these hacks... It shouldn't happen, but apparently it's a bug in the vanilla 2.5 firmware, so make sure you do a Whispernet Sync and/or that you make a backup of your *system/collections.json* file before doing anything ;).

Don't try to force a custom update by rebooting your Kindle. You should *always* install custom hacks via the Settings page. If the 'Update Your Kindle' link is greyed out, it's because you uploaded the wrong binfile for your device. Don't try to force an install by rebooting. It'll, at best, fail, and at worst, force you to start your Kindle in recovery mode to delete the offending update.

Again, if you're having issues with the Fonts hack (missing fonts, blank pages/menu, ...), do try to use one of the new freetype override settings! In the same vein, disable your Kindle's password before switching fonts, there's been reports that a messed up font will prevent the password box from popping up, in which case you won't be able to unlock your device... And that probably means a hard reset to factory defaults will be needed to clear things up, and that's never fun ;'(.

Also note that, while there is a zipfile for the usbnetwok hack attached here, I won't provide *any* support for it, and I *strongly* discourage anyone not well versed in bare-bone Linux CLI system administration to even try it. It's far too easy to brick your device/mess up the software with that thing.


*ChangeLog:*


**Jailbreak*:

    * *v0.1.N*:
    
        * Added an uninstaller, just in case
    
    * *v0.2.N*:
    
        * Works on firmware <= 3.0.2 :).
    
    * *v0.4.N*:
    
        * Works on firmware <= 3.0.3 :).
    
    * *v0.5.N*:
    
        * Works on firmware <= 3.1, thanks to yifanlu!
    
    * *v0.6.N*:
    
        * Fix uninstall so that it immediately switches back to default keys (on FW 3.1), instead of requiring a reboot.
    

**Fonts*:

    * *v.3.2.N*:
    
        * Make backups of the original files on the first boot
        * If there's a script in linkfonts/bin/emergency.sh, run it and abort the hack on startup
        * If there's a file in linkfonts/bin/prettyversion.txt, use it to override the system's copy. (The original will be part of the backups)
        * Use the DejaVu Sans font instead of the Free Sans font in the default fonts set.
        * Added some safety checks to abort the hack if we're missing a font. It won't do a thing for fonts the Kindle Software doesn't happen to really like, though...
    
    * *v.3.3.N*:
    
        * You won't have to uninstall/deactivate the hack in order to install official updates!
        * Added the possibility to let the Kindle automatically soft-reboot when switching fonts. It's now both safer & faster! (Check the detailed instructions belox for the detail)
        * And a bunch of tweaks in the scripts to make them safer. I don't remember everything right now, there's a detailed ChangeLog in each zipfile for those interested ;).
    
    * *v3.4.N*:
    
        * Fix a bug with the autoreboot feature, which would, occasionally, after an update, go a bit crazy, and do *two* restarts instead of one. That upsets the Kindle for a while, but it ends up doing a full reboot ;).
        * If you had a custom prettversion.txt, that wasn't update-safe. It's now fixed ;).
    
    * *v3.5.N*:
    
        * Use the system logger instead of pointless echo's to stdout. (That way, it'll end up in the output of ;dumpMessages among other things).
        * Avoid forking & parsing ls in some cases, when a shell glob can do the job.
    
    * *v3.6.N*:
    
        * Fix a silly case sensitivity bug that prevented official OTA updates from being trapped by the scripts.
    
    * *v3.7.N*:
    
        * Don't trap update files from our own hacks
        * Log to syslog during install & uninstall updates
        * The linkfonts folder is now installed by the update binfile! No need to copy it manually anymore.
            And if you're already using custom content, it won't be overwritten, allowing you to keep your choice of fonts and/or screensavers when updating the hacks.
            Both this thread and the Wiki have been updated to reflect this change, simplifying a bit the install & update process :).
    
    * *v3.8.N*:
    
        * Works on firmware v3.x :).
        * FW 3.x only: Customizing the browser fonts adds a certain overhead to the font switching process (it'll most likely take a few minutes during boot or before a framework restart)
            if you have updated your fonts. Moreover, the Kindle FW now makes use of TrueType hinting instructions. That tends to make fonts not having TT hinting instructions (or crappy ones)
            fuzzier than they looked on a K2. That is especially marked with small font sizes and with the browser. In order to let the browser use the default fonts, to both be sure you'll have readable fonts, and
            to avoid the overhead when switching fonts, create a blank "nobrowser" file in the linkfonts directory. All this is explained in a bit more details in the install instructions.
            *NOTE*: Because it really takes a *long* time to regenerate fontconfig's cache, the "nobrowser" feature in *enabled by default*.
    
    * *v3.9.N*:
    
        * FW 3.x: Added a different font config file that replaces the "condensed" font with the original serif (Caecilia). To enable this, drop a blank "nocondensed" file in the linkss folder.
        * Update the CJK.ttf font (Droid Fallback). Supports even more Chinese glyphs.
        * The install script now correctly upgrades default custom fonts.
        * Move pid & lock files in a dedicated folder (run) to unclutter the bin folder.
        * Move all the config files to a dedicated folder (etc). The bin folder now really only contains binaries ;).
    
    * *v4.0.N*:
    
        * Tweak the usb watchdog a bit to avoid false-positives, and implement a proper locking mechanism to avoid race conditions.
        * Whitelist font_pkg & duokan update files (don't trap them).
        * Update the fc-scan binary (updated FontConfig & TC).
        * New feature: you can now override the FreeType library used to render fonts, in order for example to force the usage of FT's
            autohinter, to get a rendering resembling that of FW 2.x. Check the post for more details.
        * Fix the fontconfig config generation to properly take all styles into account, while still avoiding multiple entries for the same font family.
        * And, actually, fix the fontconfig cache generation, too. (Stupid mistake that would break this on vanilla Kindles...)
        * Properly check if the hack is already applied instead of the usual workarounds to avoid double mounts.
        * A few code cleanups.
    
    * *v4.1.N*:
    
        * A tiny code cleanup.
        * Support light FT hinting (override)
        * Fix the FW 3.x browser when using an FT override.
    
    * *v4.2.N*:
    
        * Only use the FT override + FW 3.x browser fix when we're actually using an FT override on FW 3.x.
        * Updated FT libs (updated ft)
    
    * *v4.3.N*:
    
        * Updated FT libs (updated ft)
        * Updated fc-scan binary (updated fc)
        * Use the new jailbreak whitelist to check wether of not we want to trap an update file.
    
    * *v4.4.N*:
    
        * Updated FT libs (updated ft)
        * Fix the rendering issues encountered with the 'light' ft override in the Symbols popup, Note edit popup and address bars.
        * Updated fallback whitelist
    


**ScreenSavers*:

    * *v0.5.N*:
    
        * Reworked the script to use the same wonderful idea of bind mounts as the font hack. (And use a single script for everything, handling both the K2 & KDX)
        * Same system of backup/emergency/prettyversion as the font hack.
        * A bit of safety check to avoid using an empty directory for the screensavers
    
    * *v0.6.N*:
    
        * Same tweaks & updates as the Fonts hack.
        * You now have the possibility to automatically randomize the order in which your screensavers will be displayed. (Check the detailed instructions below)
    
    * *v0.7.N*:
    
        * Same bugfixes as the Fonts hack.
    
    * *v0.8.N*:
    
        * Same new featured/bug fixes as the Fonts hack (system logging, less forking).
        * Fix a bug with the screensavers randomizing (and possibly the set up of the hack in itself, if you're really unlucky) when your screensavers have spaces or special characters in their filenames.
        * In the same vein, fix a bug with some safety checks when using the random feature.
    
    * *v0.9.N*:
    
        * Same bugfixes as the Fonts hack.
        * Made the double mount safety check faster & more robust.
    
    * *v0.10.N*:
    
        * Same bugfixes & changes as the Fonts hack (install/uninstall logging, linkss directory auto install).
    
    * *v0.11.N*:
    
        * Works on firmware v3.x :).
    
    * *v0.12.N*:
    
        * Use a proper random sorting algorithm (coreutils' sort -R) when using the "random" feature, instead of my previous crappy pure shell workaround.
    
    * *v0.13.N*:
    
        * Fix (again) a bug with the screensavers randomizing when your screensavers have spaces or special characters in their filenames.
    
    * *v0.14.N*:
    
        * Use a dynamically linked sort binary. (To save a bit of space).
        * Same changes as the Fonts hack (config & pidfiles moved).
    
    * *v0.15.N*:
    
        * Properly detect the screen size instead of trying every size possible. (Avoid an useless mount).
    
    * *v0.16.N*:
    
        * Same fixes as the Fonts hack (update trap, usb watchdog, cleanups, mount checks).
        * Updated sort binary (updated coreutils & TC).
    
    * *v0.17.N*:
    
        * Fixed a confusing install log message
        * Updated sort binary (updated coreutils)
    
    * *v0.18.N*:
    
        * Fix the autoreboot feature when the fonts hack is not installed.
    
    * *v0.19.N*:
    
        * Updated sort binary (updated coreutils)
        * Same fixes as the Fonts hack (update trap)
    
    * *v0.20.N*:
    
        * Updated fallback whitelist
    


