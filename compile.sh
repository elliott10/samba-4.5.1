#!/bin/bash -x
CWD=$(pwd)

#WAF_MAKE=1 python $CWD/buildtools/bin/waf build --targets=smbclient $*
WAF_MAKE=1 python $CWD/buildtools/bin/waf build --targets=client/smbclient,nmbd/nmbd,winbindd/winbindd,smbd/smbd,smbpasswd,pdbedit,net $*
