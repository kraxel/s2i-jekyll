if test "$HTTP_PROXY" != ""; then
    export http_proxy="$HTTP_PROXY"
fi
if test "$HTTPS_PROXY" != ""; then
    export https_proxy="$HTTPS_PROXY"
fi
if test "$FTP_PROXY" != ""; then
    export ftp_proxy="$FTP_PROXY"
fi
if test "$ALL_PROXY" != ""; then
    export all_proxy="$ALL_PROXY"
fi
if test "$NO_PROXY" != ""; then
    export no_proxy="$NO_PROXY"
fi

echo "-=- debug -=-"
set | grep -i -e "_proxy="
echo "-=-"
