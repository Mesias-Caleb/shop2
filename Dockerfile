FROM php:8.1-apache

# Instalar dependencias del sistema
RUN apt-get update && apt-get install -y --no-install-recommends \
    cron \
    g++ \
    gettext \
    libicu-dev \
    openssl \
    libc-client-dev \
    libkrb5-dev \
    libxml2-dev \
    libfreetype6-dev \
    libgd-dev \
    bzip2 \
    libbz2-dev \
    libtidy-dev \
    libcurl4-openssl-dev \
    libz-dev \
    libmemcached-dev \
    libxslt-dev \
    tzdata \
    && apt-get clean \
    && rm -rf /var/lib/apt/lists/*

# Configurar la zona horaria
ENV TZ=America/Lima
RUN ln -snf /usr/share/zoneinfo/$TZ /etc/localtime && echo $TZ > /etc/timezone

# Habilitar módulos de Apache
RUN a2enmod rewrite

# Instalar extensiones de PHP
RUN docker-php-ext-configure gd --with-freetype --with-jpeg \
    && docker-php-ext-install -j$(nproc) gd \
    && docker-php-ext-install mysqli \
    && docker-php-ext-install pdo_mysql \
    && docker-php-ext-install intl \
    && docker-php-ext-install bcmath \
    && docker-php-ext-install soap \
    && docker-php-ext-install zip \
    && docker-php-ext-install bz2 \
    && docker-php-ext-install calendar \
    && docker-php-ext-install exif \
    && docker-php-ext-install gettext \
    && docker-php-ext-install shmop \
    && docker-php-ext-install sockets \
    && docker-php-ext-install sysvmsg \
    && docker-php-ext-install sysvsem \
    && docker-php-ext-install sysvshm \
    && docker-php-ext-install tidy \
    && docker-php-ext-install xsl

# Copiar archivos de la aplicación al contenedor
COPY . /var/www/html/

# Establecer permisos para el directorio raíz web
RUN chown -R www-data:www-data /var/www/html \
    && chmod -R 755 /var/www/html

# Opcionalmente, establecer la configuración de PHP (php.ini) si es necesario
# COPY php.ini /usr/local/etc/php/

# Iniciar Apache
CMD ["apache2-foreground"]
