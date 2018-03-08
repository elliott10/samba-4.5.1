#!/bin/bash
CWD=$(pwd)

#WAF_MAKE=1 python $CWD/buildtools/bin/waf build --targets=smbclient $*
WAF_MAKE=1 python $CWD/buildtools/bin/waf build --targets=client/smbclient,nmbd/nmbd,winbindd/winbindd,smbd/smbd,smbpasswd,pdbedit $*
