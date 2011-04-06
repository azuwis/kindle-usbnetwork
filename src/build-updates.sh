#! /bin/sh
#
# $Id: build-updates.sh 7343 2011-03-03 17:34:57Z NiLuJe $
#

HACKNAME="usbnet"
PKGNAME="usbnetwork"
PKGVER="0.32.N"

KINDLE_MODELS="k2 k2i dx dxi dxg k3g k3w k3gb"

# Archive custom directory
tar --exclude="*.svn" -cvzf ${HACKNAME}.tar.gz ../src/${HACKNAME}

for model in ${KINDLE_MODELS} ; do
	# Prepare our files for this specific kindle model...
	ARCH=${PKGNAME}_${PKGVER}_${model}

	# Build install update
	./kindle_update_tool.py m --${model} --sign ${ARCH}_install install.sh ${HACKNAME}-init ${HACKNAME}.tar.gz

	# Build uninstall update
	./kindle_update_tool.py m --${model} --sign ${ARCH}_uninstall uninstall.sh
done

# Remove custom directory archive
rm -f ${HACKNAME}.tar.gz

# Move our updates :)
mv -f *.bin ../
