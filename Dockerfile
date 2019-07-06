FROM debian:jessie

RUN set -ex; \
    { \
        echo 'deb http://mirrors.163.com/debian/ jessie main non-free contrib'; \
        echo 'deb http://mirrors.163.com/debian/ jessie-updates main non-free contrib'; \
        echo 'deb http://mirrors.163.com/debian/ jessie-backports main non-free contrib'; \
        echo 'deb-src http://mirrors.163.com/debian/ jessie main non-free contrib'; \
        echo 'deb-src http://mirrors.163.com/debian/ jessie-updates main non-free contrib'; \
        echo 'deb-src http://mirrors.163.com/debian/ jessie-backports main non-free contrib'; \
        echo 'deb http://mirrors.163.com/debian-security/ jessie/updates main non-free contrib'; \
        echo 'deb-src http://mirrors.163.com/debian-security/ jessie/updates main non-free contrib'; \
    } | tee /etc/apt/sources.list \
    && apt-get update \
    && apt-get install -y locales python-pip wget git

RUN mkdir -p /pentset/exploits/ && cd /pentset/exploits/ \
    && git clone https://github.com/trustedsec/social-engineer-toolkit/ set/ \
    && cd /pentset/exploits/set/ && pip install -r requirements.txt

RUN rm -rf /var/lib/apt/lists/* \
    && localedef -i en_US -c -f UTF-8 -A /usr/share/locale/locale.alias en_US.UTF-8

RUN ln -sn /pentset/exploits/set/set /usr/bin/set

CMD ['set']