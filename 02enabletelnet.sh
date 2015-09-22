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
echo enable root shell
sed -i "s|:/root:/sbin/nologin|:/:/bin/sh|" /etc/passwd
