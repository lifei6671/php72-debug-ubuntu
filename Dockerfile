FROM ubuntu:16.10
MAINTAINER Minho <longfei6671@163.com>

RUN apt-get update && apt-get install -y  --no-install-recommends  g++  \
	libfreetype6-dev \
    libjpeg62-turbo-dev \
    libmcrypt-dev \
    libpng12-dev \
	libpcre3-dev \
    libargon2-0-dev \
	libcurl4-openssl-dev \
	libedit-dev \
	libsodium-dev \
	libsqlite3-dev \
	libssl-dev \
	libxml2-dev \
	zlib1g-dev \
	gcc \
	make \
    bzip2 \
	libbz2-dev \
	libmemcached-dev \
    dpkg-dev \
	file \
	g++ \
	libc-dev \
	pkg-config \
	re2c \
    ca-certificates \ 
    xz-utils \
    curl \
    wget \
    libtool \
    openssl \
    libbz2-dev \
    libjpeg-dev \
    libpng12-dev \
    libfreetype6-dev \
    libldap2-dev \
    libmysqlclient-dev \
    libxslt1-dev \
    libxt-dev \
    libpcre3-dev \
    libxpm-dev \
    libt1-dev \
    libgmp-dev \
    libpspell-dev \
    librecode-dev \
    libreadline6-dev \
    bison \
    ibtidy-dev  \
	rm -r /var/lib/apt/lists/*

ENV PHP_INI_DIR /usr/local/etc/php
RUN mkdir -p $PHP_INI_DIR/conf.d

ENV PHP_VERSION 7.2.7
ENV PHP_URL="https://secure.php.net/get/php-7.2.7.tar.xz/from/this/mirror" PHP_ASC_URL="https://secure.php.net/get/php-7.2.7.tar.xz.asc/from/this/mirror"
ENV PHP_SHA256="eb01c0153b3baf1f64b8b044013ce414b52fede222df3f509e8ff209478f31f0" PHP_MD5=""

RUN set -xe; \
    mkdir -p /usr/src; \
	cd /usr/src; \
	wget -O php.tar.xz "$PHP_URL"; \
	if [ -n "$PHP_SHA256" ]; then \
		echo "$PHP_SHA256 *php.tar.xz" | sha256sum -c -; \
	fi; \
	if [ -n "$PHP_MD5" ]; then \
		echo "$PHP_MD5 *php.tar.xz" | md5sum -c -; \
	fi; \
    tar zxf php-7.2.7 && ./buildconf  \
    ./configure --prefix=/usr/local/php7 \
    --enable-debug \
    --exec-prefix=/usr/local/php7 \
    --bindir=/usr/local/php7/bin \
    --sbindir=/usr/local/php7/sbin \
    --includedir=/usr/local/php7/include \
    --libdir=/usr/local/php7/lib/php \
    --mandir=/usr/local/php7/php/man \
    --with-config-file-path=/usr/local/php7/etc \
    --with-mysql-sock=/var/run/mysql/mysql.sock \
    --enable-opcache \
    --enable-ctype \
    --enable-fpm \
    --enable-tokenizer \
    --enable-fileinfo \
    --enable-pdo \
    --enable-sockets \
    --enable-exif \
    --enable-soap -\
    -enable-ftp \
    --enable-wddx \
    --enable-pcntl \
    --enable-soap \
    --enable-bcmath \
    --enable-mbstring \
    --enable-dba  \
    --enable-gd-jis-conv \
    --enable-zip \
    --enable-calendar \
    --enable-shmop \
    --enable-sysvmsg \
    --enable-sysvsem \
    --enable-sysvshm \
    --with-mysqli \
    --with-pdo-mysql \
    --with-pdo-sqlite \
    --with-iconv \
    --with-gmp \
    --with-pspell \
    --with-gettext \
    --with-xmlrpc \
    --with-openssl \
    --with-mhash \
    --with-xsl \
    --with-curl \
    --with-pcre-regex \
    --with-gd \
    --with-jpeg-dir=/usr \
    --with-png-dir=/usr \
    --with-zlib-dir=/usr \
    --with-xpm-dir=/usr \
    --with-freetype-dir=/usr  \
    --with-gettext=/usr \
    --with-zlib=/usr \
    --with-bz2=/usr \
    --with-recode=/usr \
    --with-ldap \
    --with-pear \
    --with-readline \
    make && make install

CMD ["php", "-a"]
