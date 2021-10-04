#!/bin/bash

OPENVPNDIR="/etc/openvpn"
. $OPENVPNDIR/remote.env
CA_CONTENT=$(cat $OPENVPNDIR/easy-rsa/keys/ca.crt)

cat <<- EOF
remote $REMOTE_IP $REMOTE_PORT
client
dev tun
proto tcp
remote-random
resolv-retry infinite
cipher AES-128-CBC
auth SHA1
nobind
link-mtu 1500
persist-key
persist-tun
comp-lzo
verb 3
auth-user-pass
auth-retry interact
ns-cert-type server
<ca>
$CA_CONTENT
</ca>
EOF
