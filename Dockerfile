# DEPRECATED – this image is no longer maintained.
# Successor: https://github.com/maximilian1001/docker-all-nextcloud-smb
# This final build keeps the base version and only adds a periodic deprecation
# notice to the container log (every DEPRECATION_NOTICE_INTERVAL seconds, default 3600, 0 = only at start).
FROM nextcloud:31-apache

LABEL org.opencontainers.image.description="DEPRECATED – use ghcr.io/maximilian1001/docker-all-nextcloud-smb" \
      org.opencontainers.image.source="https://github.com/maximilian1001/docker-nextcloud-smb"

# smbclient extension (tarball installed directly: the PEAR installer of current
# base images cannot resolve the newest PECL version on its own)
RUN set -eux; \
    apt-get update; \
    apt-get install -y --no-install-recommends smbclient libsmbclient-dev; \
    curl -fsSL --retry 3 -o /tmp/smbclient.tgz "https://pecl.php.net/get/smbclient-1.2.0dev.tgz"; \
    pecl install /tmp/smbclient.tgz; \
    docker-php-ext-enable smbclient; \
    rm -rf /var/lib/apt/lists/* /tmp/pear /tmp/smbclient.tgz; \
    php -m | grep -qix smbclient

COPY --chmod=755 deprecation-notice.sh /usr/local/bin/deprecation-notice.sh

ENV DEPRECATION_NOTICE_INTERVAL=3600
ENTRYPOINT ["/usr/local/bin/deprecation-notice.sh"]
CMD ["apache2-foreground"]
