FROM alpine:3.6

MAINTAINER Caleb Favor <caleb@drumeo.com>

RUN apk add --no-cache \
        ca-certificates \
        openssl \
        curl \
        bash \
        sed \
        wget \
        zip \
        unzip \
        bzip2 \
        p7zip \
        drill \
        ldns \
        openssh-client \
        rsync \
        git \
        gnupg \
        supervisor \
        tzdata \
        patch \
        nano

# PHP
RUN set -x \
    &&  apk add --no-cache \
        imagemagick \
        graphicsmagick \
        ghostscript \
        php7-fpm \
        php7-json \
        php7-intl \
        php7-curl \
        php7-mysqli \
        php7-mysqlnd \
        php7-pdo_mysql \
        php7-pdo_sqlite \
        php7-mcrypt \
        php7-gd \
        php7-imagick \
        php7-bcmath \
        php7-soap \
        php7-sqlite3 \
        php7-bz2 \
        php7-calendar \
        php7-ctype \
        php7-pcntl \
        php7-posix \
        php7-sockets \
        php7-sysvmsg \
        php7-sysvsem \
        php7-sysvshm \
        php7-xmlreader \
        php7-exif \
        php7-ftp \
        php7-gettext \
        php7-iconv \
        php7-zip \
        php7-zlib \
        php7-shmop \
        php7-wddx \
        sqlite \
        php7-xmlrpc \
        php7-xsl \
        geoip \
        php7-ldap \
        php7-redis \
        php7-pear \
        php7-phar \
        php7-openssl \
        php7-session \
        php7-opcache \
        php7-mbstring \
        php7-iconv \
        php7-apcu \
        php7-fileinfo \
        php7-simplexml \
        php7-tokenizer \
        php7-xmlwriter \
    && ln -s /usr/sbin/php-fpm7 /usr/sbin/php-fpm \
    && pecl channel-update pecl.php.net \
    && pear channel-update pear.php.net \
    && pear upgrade-all \
    && pear config-set auto_discover 1 \
    && curl -sS https://getcomposer.org/installer | php -- --install-dir=/usr/local/bin/ --filename=composer \
    && sed -i "s/ -n / /" $(which pecl) \

EXPOSE 9000

# Apache
RUN set -x \
    && apk-install \
        apache2 \
        apache2-ctl \
        apache2-utils \
        apache2-proxy \
        apache2-ssl \
    && sed -ri ' \
        s!^(\s*CustomLog)\s+\S+!\1 /proc/self/fd/1!g; \
        s!^(\s*ErrorLog)\s+\S+!\1 /proc/self/fd/2!g; \
        ' /etc/apache2/httpd.conf

EXPOSE 80 443