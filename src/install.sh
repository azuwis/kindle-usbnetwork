#!/bin/sh
#
# $Id: install.sh 7343 2011-03-03 17:34:57Z NiLuJe $
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
HACKVER="0.32.N"

# Directories
USBNET_BASEDIR="/mnt/us/usbnet"
USBNET_BINDIR="${USBNET_BASEDIR}/bin"

USBNET_LOG="${USBNET_BASEDIR}/usbnetwork_install.log"

KINDLE_TESTDIR="/test/bin"
KINDLE_USBNETBIN="${KINDLE_TESTDIR}/usbnetwork"

USBNET_USBNETBIN="${USBNET_BINDIR}/usbnetwork"

# Result codes
OK=0
ERR=${OK}

update_percent_complete 2

# Install our hack's custom content
# But keep the user's custom content...
if [ -d /mnt/us/${HACKNAME} ] ; then
    logmsg "I" "update" "our custom directory already exists, checking if we have custom content to preserve"
    # Custom IP config
    if [ -f /mnt/us/${HACKNAME}/etc/config ] ; then
        cfg_expected_md5="3d630a6bdbeae41be8c2a2436159eeee 4836fc4a5383b38ff062afebc1da4972 10d30f97f0adbdb86869e48c01095c82"
        cfg_current_md5=$( md5sum /mnt/us/${HACKNAME}/etc/config | awk '{ print $1; }' )
        cfg_md5_match="false"
        for cur_exp_md5 in ${cfg_expected_md5} ; do
            if [ "${cfg_current_md5}" == "${cur_exp_md5}" ] ; then
                cfg_md5_match="true"
            fi
        done
        if [ "${cfg_md5_match}" != "true" ] ; then
            HACK_EXCLUDE="${HACKNAME}/etc/config"
            logmsg "I" "update" "found custom ip config, excluding from archive"
        fi
   fi
fi

update_progressbar 7

# Okay, now we can extract it. Since busybox's tar is very limited, we have to use a tmp directory to perform our filtering
logmsg "I" "update" "installing custom directory"
tar -xvzf ${HACKNAME}.tar.gz

# That's very much inspired from official update scripts ;)
cd src
# And now we filter the content to preserve user's custom content
for custom_file in ${HACK_EXCLUDE} ; do
    if [ -f "./${custom_file}" ] ; then
        logmsg "I" "update" "preserving custom content (${custom_file})"
        rm -f "./${custom_file}"
    fi
done
# Finally, re-tape our filtered dir and unleash it on the live userstore
tar cf - . | (cd /mnt/us ; tar xvf -)
_RET=$?
if [ ${_RET} -ne 0 ] ; then
    logmsg "C" "update" "code=${_RET}" "failure to update userstore with custom directory"
    return 1
fi
cd - >/dev/null
rm -rf src

update_progressbar 14

# Here we go
echo >> ${USBNET_LOG}
echo "usbnetwork v${HACKVER}, $( date )" >> ${USBNET_LOG}

update_progressbar 21

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

update_percent_complete 24

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

update_progressbar 28

# Make sure our custom binaries are executable
LIST="usbnetwork busybox dropbearmulti rsync usbnet-enable usbnet-disable sftp-server htop lsof"
for var in ${LIST} ; do
    [ -x ${USBNET_BINDIR}/${var} ] || chmod +x ${USBNET_BINDIR}/${var} >> ${USBNET_LOG} 2>&1 || exit ${ERR}
done

update_progressbar 35

# Make sure the /test/bin directory exists
logmsg "I" "update" "creating the /test/bin directory if need be"
[ -d ${KINDLE_TESTDIR} ] || mkdir -p ${KINDLE_TESTDIR} >> ${USBNET_LOG} 2>&1 || exit ${ERR}

update_progressbar 42

# Setup SSH server
logmsg "I" "update" "installing SSH server"
LIST="/usr/sbin/dropbearmulti /usr/bin/dropbear /usr/bin/dbclient /usr/bin/dbscp"
for var in ${LIST} ; do
    if [ -L ${var} ] ; then
        echo "symbolic link ${var} -> $( readlink ${var} ) already exists, skipping..." >> ${USBNET_LOG}
    else
        if [ -x ${var} ] ; then
            echo "Binary ${var} already exists, skipping..." >> ${USBNET_LOG}
        else
            ln -fs ${USBNET_BINDIR}/dropbearmulti ${var} >> ${USBNET_LOG} 2>&1 || exit ${ERR}
        fi
    fi
done

update_progressbar 49

# Setup lsof
logmsg "I" "update" "installing lsof"
var="/usr/sbin/lsof"
if [ -L ${var} ] ; then
    echo "symbolic link ${var} -> $( readlink ${var} ) already exists, skipping..." >> ${USBNET_LOG}
else
    if [ -x ${var} ] ; then
        echo "Binary ${var} already exists, skipping..." >> ${USBNET_LOG}
    else
        ln -fs ${USBNET_BINDIR}/lsof ${var} >> ${USBNET_LOG} 2>&1 || exit ${ERR}
    fi
fi

update_progressbar 56

# Setup htop
logmsg "I" "update" "installing htop"
var="/usr/bin/htop"
if [ -L ${var} ] ; then
    echo "symbolic link ${var} -> $( readlink ${var} ) already exists, skipping..." >> ${USBNET_LOG}
else
    if [ -x ${var} ] ; then
        echo "Binary ${var} already exists, skipping..." >> ${USBNET_LOG}
    else
        ln -fs ${USBNET_BINDIR}/htop ${var} >> ${USBNET_LOG} 2>&1 || exit ${ERR}
    fi
fi

update_progressbar 63

# Setup rsync
logmsg "I" "update" "installing rsync"
var="/usr/bin/rsync"
if [ -L ${var} ] ; then
    echo "symbolic link ${var} -> $( readlink ${var} ) already exists, skipping..." >> ${USBNET_LOG}
else
    if [ -x ${var} ] ; then
        echo "Binary ${var} already exists, skipping..." >> ${USBNET_LOG}
    else
        ln -fs ${USBNET_BINDIR}/rsync ${var} >> ${USBNET_LOG} 2>&1 || exit ${ERR}
    fi
fi

update_progressbar 70

# Setup `usbNetwork command symlink
logmsg "I" "update" "setting up usbNetwork private command symlink"
if [ -L ${KINDLE_USBNETBIN} ] ; then
    echo "symbolic link ${KINDLE_USBNETBIN} -> $( readlink ${KINDLE_USBNETBIN} ) already exists, skipping..." >> ${USBNET_LOG}
else
    # Save normal file in case it already exists
    if [ -f ${KINDLE_USBNETBIN} ] ; then
        echo "${KINDLE_USBNETBIN} exists, saving..." >> ${USBNET_LOG}
        cp ${KINDLE_USBNETBIN} ${USBNET_USBNETBIN}-save.${HACKVER} >> ${USBNET_LOG} 2>&1 || exit ${ERR}
        rm -f ${KINDLE_USBNETBIN} >> ${USBNET_LOG} 2>&1 || exit ${ERR}
    fi

    # Create a link
    ln -fs ${USBNET_USBNETBIN} ${KINDLE_USBNETBIN} >> ${USBNET_LOG} 2>&1 || exit ${ERR}
fi

update_progressbar 77

# Setup auto USB network startup script
logmsg "I" "update" "installing init script"
cp -f ${HACKNAME}-init /etc/init.d/${HACKNAME} >> ${USBNET_LOG} 2>&1 || exit ${ERR}
[ -x /etc/init.d/${HACKNAME} ] || chmod +x /etc/init.d/${HACKNAME} >> ${USBNET_LOG} 2>&1 || exit ${ERR}

update_progressbar 84

# And make it start at boot, after userstore, after network, after volumd, and before framework (rc5)
logmsg "I" "update" "creating boot symlink"
if [ -L /etc/rc5.d/S${SLEVEL}${HACKNAME} ] ; then
    echo "symbolic link /etc/rc5.d/S${SLEVEL}${HACKNAME} already exists, skipping..." >> ${USBNET_LOG}
else
    ln -fs /etc/init.d/${HACKNAME} /etc/rc5.d/S${SLEVEL}${HACKNAME} >> ${USBNET_LOG} 2>&1 || exit ${ERR}
fi

# Make it stop at reboot (rc6), after the framework and before userstore
logmsg "I" "update" "creating reboot runlevel symlink"
if [ -L /etc/rc6.d/K${KLEVEL}${HACKNAME} ] ; then
    echo "symbolic link /etc/rc6.d/K${KLEVEL}${HACKNAME} already exists, skipping..." >> ${USBNET_LOG}
else
    ln -fs /etc/init.d/${HACKNAME} /etc/rc6.d/K${KLEVEL}${HACKNAME} >> ${USBNET_LOG} 2>&1 || exit ${ERR}
fi

# Make it stop at shutdown (rc0), after the framework and before userstore
logmsg "I" "update" "creating shutdown runlevel symlink"
if [ -L /etc/rc0.d/K${KLEVEL}${HACKNAME} ] ; then
    echo "symbolic link /etc/rc0.d/K${KLEVEL}${HACKNAME} already exists, skipping..." >> ${USBNET_LOG}
else
    ln -fs /etc/init.d/${HACKNAME} /etc/rc0.d/K${KLEVEL}${HACKNAME} >> ${USBNET_LOG} 2>&1 || exit ${ERR}
fi

# Make it stop when updating (rc3), after the framework and before the updater
logmsg "I" "update" "creating update runlevel symlink"
if [ -L /etc/rc3.d/K${KLEVEL}${HACKNAME} ] ; then
    echo "symbolic link /etc/rc3.d/K${KLEVEL}${HACKNAME} already exists, skipping..." >> ${USBNET_LOG}
else
    ln -fs /etc/init.d/${HACKNAME} /etc/rc3.d/K${KLEVEL}${HACKNAME} >> ${USBNET_LOG} 2>&1 || exit ${ERR}
fi

update_progressbar 91

# Cleanup
logmsg "I" "update" "cleaning up"
rm -f ${HACKNAME}-init ${HACKNAME}.tar.gz

update_progressbar 98

echo "Done!" >> ${USBNET_LOG}
logmsg "I" "update" "done"
update_progressbar 100

return ${OK}
