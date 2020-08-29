FROM cdrx/pyinstaller-linux

COPY entrypoint.sh /entrypoint.sh
RUN chmod +x /entrypoint.sh

RUN pyenv uninstall -f 3.7.5
RUN apt-get install -y tk-dev
RUN pyenv install 3.7.5
RUN pyenv rehash

ENTRYPOINT ["/entrypoint.sh"]
