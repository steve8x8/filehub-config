# remove /etc/init.d/opentelnet.sh
# remove /etc/*telnetflag
# enable root shell

if [ -f /etc/init.d/opentelnet.sh ]; then
    echo remove opentelnet script
    mv -f /etc/init.d/opentelnet.sh /etc/init.d/opentelnet.sh.OFF
fi
if [ -f /etc/telnetflag ]; then
    echo remove telnetflag
    mv -f /etc/telnetflag /etc/telnetflag.OFF
fi
if [ -f /etc/checktelnetflag ]; then
    echo remove checktelnetflag
    mv -f /etc/checktelnetflag /etc/checktelnetflag.OFF
fi
if grep -q 'root:/sbin/nologin' /etc/passwd
then
    echo enable root shell
    sed -i "s|:/root:/sbin/nologin|:/:/bin/sh|" /etc/passwd
fi
#if grep -q '/bin/sh-new' /etc/*passwd
#then
#    enable guest/admin shell
#    sed -i "s|:/bin/sh-new.*|:/bin/sh|" /etc/*passwd
#fi
