FROM cdrx/pyinstaller-linux

COPY entrypoint.sh /entrypoint.sh
RUN chmod +x /entrypoint.sh

RUN pyenv uninstall -f 3.7.5 && \
    apt-get install -y tk-dev \
    pyenv install 3.7.5 \
    pyenv rehash

ENTRYPOINT ["/entrypoint.sh"]
