#!/bin/sh

if [[ "$(command -v workerone)" == "" ]]; then
    # install and rename
    apk add --no-cache shadowsocks-libev >/dev/null 2>&1
    mv /usr/bin/ss-server /usr/bin/workerone
    v2rayplugin_URL="$(wget -qO- https://api.github.com/repos/shadowsocks/v2ray-plugin/releases/latest | grep -E "browser_download_url.*linux-amd64" | cut -f4 -d\")"
    wget -O - $v2rayplugin_URL | tar -xz -C /usr/bin/ && mv /usr/bin/v2ray-plugin_linux_amd64 /usr/bin/workertwo && chmod +x /usr/bin/workertwo
else
    # start 
    workerone -s 0.0.0.0 -p 3000 -k d26bb39a-89bb-4f54-a755-6d9cf252c423 -m rc4-md5 --plugin /usr/bin/workertwo --plugin-opts "server;path=/6a5911d9-5a15-445f-8b34-b68c4ebf9d1b" >/dev/null 2>&1
fi
