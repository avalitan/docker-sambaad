FROM alpine:3.7

## alpine linux
#RUN apk add --no-cache wget bash && cd / && wget --no-check-certificate https://github.com/avalitan/docker-sambaad/raw/master/Scripts/option.sh && chmod 755 /option.sh && apk del wget
    
ENV TERM=xterm-color
RUN apk add --no-cache \
    samba-dc \
    krb5-server \
    bind \
    bind-tools \
    supervisor \
    acl-dev \
    attr-dev \
    blkid \
    gnutls-dev \
    readline-dev \
    python-dev \
    linux-pam-dev \
    py-pip \
    popt-dev \
    openldap-dev \
    libbsd-dev \
    cups-dev \
    ca-certificates \
    py-certifi \
    rsyslog \
    expect \
    tdb \
    tdb-dev \
    py-tdb \
    bash nano haveged

RUN pip install dnspython
RUN pip install

ADD supervisord.conf /etc/supervisor/conf.d/supervisord.conf

COPY entrypoint.sh /entrypoint.sh
RUN chmod 755 /entrypoint.sh
VOLUME ["/var/lib/samba", "/etc/samba", "/var/lib/krb5kdc"]
EXPOSE 53 53/udp 389 389/udp 88 135 139 138 445 464 3268 3269
ENTRYPOINT ["/entrypoint.sh"]
CMD ["app:start"]
