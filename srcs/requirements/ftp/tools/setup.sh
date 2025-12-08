#!/bin/bash
set -e

# .env variables
FTP_USER="${FTP_USER:?FTP_USER not set}"
FTP_PASS="${FTP_PASS:?FTP_PASS not set}"

# Creating ftp user
if ! id "$FTP_USER" >/dev/null 2>&1; then
    useradd "$FTP_USER"
    echo "$FTP_USER:$FTP_PASS" | chpasswd
fi

echo "FTP server ready (proftpd)"

exec proftpd -n
