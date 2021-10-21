#!/bin/bash -i

# Fail on errors.
# set -im

# Make sure .bashrc is sourced
. /root/.bashrc

# Allow the workdir to be set using an env var.
# Useful for CI pipiles which use docker for their build steps
# and don't allow that much flexibility to mount volumes
SRCDIR=$1

PYPI_URL=$2

PYPI_INDEX_URL=$3

WORKDIR=${SRCDIR:-/src}

SPEC_FILE=${4:-*.spec}

/root/.pyenv/shims/python -m pip install --upgrade pip wheel setuptools

#
# In case the user specified a custom URL for PYPI, then use
# that one, instead of the default one.
#
if [[ "$PYPI_URL" != "https://pypi.python.org/" ]] || \
   [[ "$PYPI_INDEX_URL" != "https://pypi.python.org/simple" ]]; then
    # the funky looking regexp just extracts the hostname, excluding port
    # to be used as a trusted-host.
    mkdir -p /root/.pip
    echo "[global]" > /root/.pip/pip.conf
    echo "index = $PYPI_URL" >> /root/.pip/pip.conf
    echo "index-url = $PYPI_INDEX_URL" >> /root/.pip/pip.conf
    echo "trusted-host = $(echo $PYPI_URL | perl -pe 's|^.*?://(.*?)(:.*?)?/.*$|$1|')" >> /root/.pip/pip.conf

    echo "Using custom pip.conf: "
    cat /root/.pip/pip.conf
fi

cd $WORKDIR


if [[ $7 == "true" ]]; then
    sudo apt update
    sudo apt upgrade -y
    sudo apt install -y libwxbase3.0-0v5 libwxgtk-media3.0-gtk3-0v5 libwxgtk-webview3.0-gtk3-0v5 \
    libwxgtk3.0-gtk3-0v5 python3-wxgtk-media4.0 python3-wxgtk-webview4.0 python3-wxgtk4.0 \
    libgtk-3-dev 
    # /root/.pyenv/shims/pip install gooey
fi # [$7]

if [ -f $6 ]; then
    /root/.pyenv/shims/pip install -r $6
fi # [ -f $6 ]


/root/.pyenv/shims/pyinstaller --clean -y --dist ./dist/linux --workpath /tmp $SPEC_FILE

chown -R --reference=. ./dist/linux