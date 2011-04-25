#!/bin/sh
#
# $Id: uninstall.sh 7420 2011-04-19 02:48:56Z NiLuJe $
#
# diff OTA patch script

_FUNCTIONS=/etc/rc.d/functions
[ -f ${_FUNCTIONS} ] && . ${_FUNCTIONS}


MSG_SLLVL_D="debug"
MSG_SLLVL_I="info"
MSG_SLLVL_W="warn"
MSG_SLLVL_E="err"
MSG_SLLVL_C="crit"
MSG_SLNUM_D=0
MSG_SLNUM_I=1
MSG_SLNUM_W=2
MSG_SLNUM_E=3
MSG_SLNUM_C=4
MSG_CUR_LVL=/var/local/system/syslog_level

logmsg()
{
    local _NVPAIRS
    local _FREETEXT
    local _MSG_SLLVL
    local _MSG_SLNUM

    _MSG_LEVEL=$1
    _MSG_COMP=$2

    { [ $# -ge 4 ] && _NVPAIRS=$3 && shift ; }

    _FREETEXT=$3

    eval _MSG_SLLVL=\${MSG_SLLVL_$_MSG_LEVEL}
    eval _MSG_SLNUM=\${MSG_SLNUM_$_MSG_LEVEL}

    local _CURLVL

    { [ -f $MSG_CUR_LVL ] && _CURLVL=`cat $MSG_CUR_LVL` ; } || _CURLVL=1

    if [ $_MSG_SLNUM -ge $_CURLVL ]; then
        /usr/bin/logger -p local4.$_MSG_SLLVL -t "ota_install" "$_MSG_LEVEL def:$_MSG_COMP:$_NVPAIRS:$_FREETEXT"
    fi

    [ "$_MSG_LEVEL" != "D" ] && echo "ota_install: $_MSG_LEVEL def:$_MSG_COMP:$_NVPAIRS:$_FREETEXT"
}

if [ -z "${_PERCENT_COMPLETE}" ]; then
    export _PERCENT_COMPLETE=0
fi

update_percent_complete()
{
    _PERCENT_COMPLETE=$((${_PERCENT_COMPLETE} + $1))
    update_progressbar ${_PERCENT_COMPLETE}
}

# Hack specific config (name and when to start/stop)
HACKNAME="usbnet"
SLEVEL="82"
KLEVEL="09"

# Based on version 0.11 (20100124), ebs, jya
HACKVER="0.33.N"

# Directories
USBNET_BASEDIR="/mnt/us/usbnet"
USBNET_BINDIR="${USBNET_BASEDIR}/bin"

USBNET_LOG="${USBNET_BASEDIR}/usbnetwork_uninstall.log"

KINDLE_TESTDIR="/test/bin"
KINDLE_USBNETBIN="${KINDLE_TESTDIR}/usbnetwork"

USBNET_USBNETBIN="${USBNET_BINDIR}/usbnetwork"

# Result codes
OK=0
ERR=${OK}

# Here we go
echo >> ${USBNET_LOG}
echo "usbnetwork v${HACKVER}, $( date )" >> ${USBNET_LOG}

update_percent_complete 2

# Remove our deprecated content
# From v0.21.N
logmsg "I" "update" "removing deprecated init scripts & symlinks (v0.21.N)"
if [ -f /etc/init.d/${HACKNAME}-wifi ] ; then
    echo "/etc/init.d/${HACKNAME}-wifi exists, deleting..." >> ${USBNET_LOG}
    rm -f /etc/init.d/${HACKNAME}-wifi >> ${USBNET_LOG} 2>&1 || exit ${ERR}
fi

if [ -L /etc/rc5.d/S72${HACKNAME}-wifi ] ; then
    echo "symbolic link /etc/rc5.d/S72${HACKNAME}-wifi exists, deleting..." >> ${USBNET_LOG}
    rm -f /etc/rc5.d/S72${HACKNAME}-wifi >> ${USBNET_LOG} 2>&1 || exit ${ERR}
fi

update_percent_complete 10

# From v0.22.N
logmsg "I" "update" "removing deprecated symlinks (v0.22.N)"
if [ -L /etc/rcS.d/S72${HACKNAME} ] ; then
    echo "symbolic link /etc/rcS.d/S72${HACKNAME} exists, deleting..." >> ${USBNET_LOG}
    rm -f /etc/rcS.d/S72${HACKNAME} >> ${USBNET_LOG} 2>&1 || exit ${ERR}
fi

# From v0.23.N
logmsg "I" "update" "removing deprecated symlinks (v0.23.N)"
if [ -L /etc/rc5.d/S99${HACKNAME} ] ; then
    echo "symbolic link /etc/rc5.d/S99${HACKNAME} exists, deleting..." >> ${USBNET_LOG}
    rm -f /etc/rc5.d/S99${HACKNAME} >> ${USBNET_LOG} 2>&1 || exit ${ERR}
fi

update_percent_complete 20

# Remove `usbNetwork command symlink
logmsg "I" "update" "removing usbNetwork private command symlink"
if [ -L ${KINDLE_USBNETBIN} ] ; then
    echo "symbolic link ${KINDLE_USBNETBIN} -> $( readlink ${KINDLE_USBNETBIN} ) exists, deleting..." >> ${USBNET_LOG}
    rm -f ${KINDLE_USBNETBIN} >> ${USBNET_LOG} 2>&1 || exit ${ERR}
fi

update_progressbar 30

# Remove SSH server symlinks
logmsg "I" "update" "removing SSH server symlinks"
LIST="/usr/sbin/dropbearmulti /usr/bin/dropbear /usr/bin/dbclient /usr/bin/dbscp"
for var in ${LIST} ; do
    if [ -L ${var} ] ; then
        echo "symbolic link ${var} -> $( readlink ${var} ) exists, deleting..." >> ${USBNET_LOG}
        DBM=$( readlink ${var} )
        if [ "${DBM}" = "${USBNET_BINDIR}/dropbearmulti" ] ; then
            rm -f ${var} >> ${USBNET_LOG} 2>&1 || exit ${ERR}
        else
            echo "symbolic link is not ours, skipping..." >> ${USBNET_LOG}
        fi
    fi
done

update_progressbar 40

# Remove lsof symlink
logmsg "I" "update" "removing lsof symlink"
var="/usr/sbin/lsof"
if [ -L ${var} ] ; then
    echo "symbolic link ${var} -> $( readlink ${var} ) exists, deleting..." >> ${USBNET_LOG}
    SYMBIN=$( readlink ${var} )
    if [ "${SYMBIN}" = "${USBNET_BINDIR}/lsof" ] ; then
        rm -f ${var} >> ${USBNET_LOG} 2>&1 || exit ${ERR}
    else
        echo "symbolic link is not ours, skipping..." >> ${USBNET_LOG}
    fi
fi

update_progressbar 50

# Remove htop symlink
logmsg "I" "update" "removing htop symlink"
var="/usr/bin/htop"
if [ -L ${var} ] ; then
    echo "symbolic link ${var} -> $( readlink ${var} ) exists, deleting..." >> ${USBNET_LOG}
    SYMBIN=$( readlink ${var} )
    if [ "${SYMBIN}" = "${USBNET_BINDIR}/htop" ] ; then
        rm -f ${var} >> ${USBNET_LOG} 2>&1 || exit ${ERR}
    else
        echo "symbolic link is not ours, skipping..." >> ${USBNET_LOG}
    fi
fi

update_progressbar 60

# Remove rsync symlink
logmsg "I" "update" "removing lsof symlink"
var="/usr/bin/rsync"
if [ -L ${var} ] ; then
    echo "symbolic link ${var} -> $( readlink ${var} ) exists, deleting..." >> ${USBNET_LOG}
    SYMBIN=$( readlink ${var} )
    if [ "${SYMBIN}" = "${USBNET_BINDIR}/rsync" ] ; then
        rm -f ${var} >> ${USBNET_LOG} 2>&1 || exit ${ERR}
    else
        echo "symbolic link is not ours, skipping..." >> ${USBNET_LOG}
    fi
fi

update_progressbar 70

# Delete init script
logmsg "I" "update" "removing init scripts"
if [ -f /etc/init.d/${HACKNAME} ] ; then
    echo "/etc/init.d/${HACKNAME} exists, deleting..." >> ${USBNET_LOG}
    rm -f /etc/init.d/${HACKNAME} >> ${USBNET_LOG} 2>&1 || exit ${ERR}
fi

logmsg "I" "update" "removing boot runlevel symlink"
if [ -L /etc/rc5.d/S${SLEVEL}${HACKNAME} ] ; then
    echo "symbolic link /etc/rc5.d/S${SLEVEL}${HACKNAME} exists, deleting..." >> ${USBNET_LOG}
    rm -f /etc/rc5.d/S${SLEVEL}${HACKNAME} >> ${USBNET_LOG} 2>&1 || exit ${ERR}
fi

logmsg "I" "update" "removing reboot runlevel symlink"
if [ -L /etc/rc6.d/K${KLEVEL}${HACKNAME} ] ; then
    echo "symbolic link /etc/rc6.d/K${KLEVEL}${HACKNAME} exists, deleting..." >> ${USBNET_LOG}
    rm -f /etc/rc6.d/K${KLEVEL}${HACKNAME} >> ${USBNET_LOG} 2>&1 || exit ${ERR}
fi

logmsg "I" "update" "removing shutdown runlevel symlink"
if [ -L /etc/rc0.d/K${KLEVEL}${HACKNAME} ] ; then
    echo "symbolic link /etc/rc0.d/K${KLEVEL}${HACKNAME} exists, deleting..." >> ${USBNET_LOG}
    rm -f /etc/rc0.d/K${KLEVEL}${HACKNAME} >> ${USBNET_LOG} 2>&1 || exit ${ERR}
fi

logmsg "I" "update" "removing update runlevel symlink"
if [ -L /etc/rc3.d/K${KLEVEL}${HACKNAME} ] ; then
    echo "symbolic link /etc/rc3.d/K${KLEVEL}${HACKNAME} exists, deleting..." >> ${USBNET_LOG}
    rm -f /etc/rc3.d/K${KLEVEL}${HACKNAME} >> ${USBNET_LOG} 2>&1 || exit ${ERR}
fi

update_progressbar 80

# Disable USB network tethering
logmsg "I" "update" "removing traces of USB network tethering"
echo "Part I done! Now to remove traces of USB network tethering..." >> ${USBNET_LOG}

# Handle K3?
for platform in mario luigi ; do
    fwk_cfg="/opt/amazon/ebook/config/framework.${platform}.conf"
    if [[ -f "${fwk_cfg}" ]] ; then
        logmsg I "update" "restoring ${platform} config"
        sed -e "s/USE_WAN : false/USE_WAN : true/g" -i "${fwk_cfg}" >> ${USBNET_LOG} 2>&1 || exit ${ERR}
    fi
done

rm -f /etc/resolv.d/resolv.conf.default >> ${USBNET_LOG} 2>&1 || exit ${ERR}
touch /etc/resolv.d/resolv.conf.default >> ${USBNET_LOG} 2>&1 || exit ${ERR}
cp -f /etc/resolv.d/resolv.conf.default /var/run/resolv.conf >> ${USBNET_LOG} 2>&1 || exit ${ERR}

echo "All done!" >> ${USBNET_LOG}
update_progressbar 90

# From v0.11.N
# Remove custom directory in userstore? [That'll remove the detailed uninstall log, of course]
logmsg "I" "update" "removing custom directory (only if /mnt/us/${HACKNAME}/uninstall exists)"
[ -d /mnt/us/${HACKNAME} -a -f /mnt/us/${HACKNAME}/uninstall ] && rm -rf /mnt/us/${HACKNAME}

logmsg "I" "update" "done"
update_progressbar 100

return ${OK}
