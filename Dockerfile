FROM debian:12

WORKDIR /root

# Install necessary tools and dependencies
RUN apt-get update && \
    apt-get install -y \
    lsb-release \
    apt-transport-https \
    ca-certificates \
    curl \
    gnupg \
    software-properties-common \
    wget \
    build-essential \
    libpng-dev \
    libjpeg-dev \
    libfreetype6-dev \
    libmcrypt-dev \
    libzip-dev \
    libxml2-dev \
    libonig-dev \
    libcurl4-openssl-dev \
    libssl-dev \
    libsqlite3-dev \
    libpq-dev \
    libbz2-dev \
    libicu-dev \
    libmagickwand-dev \
    unzip

# Install PHP 8.3 and extensions
RUN wget -q https://packages.sury.org/php/apt.gpg -O- | gpg --dearmor -o /usr/share/keyrings/sury-php.gpg && \
    echo "deb [signed-by=/usr/share/keyrings/sury-php.gpg] https://packages.sury.org/php/ $(lsb_release -sc) main" | tee /etc/apt/sources.list.d/php.list && \
    apt-get update && \
    apt-get install -y \
    php8.3 \
    php8.3-curl \
    php8.3-gd \
    php8.3-dev \
    php8.3-xml \
    php8.3-bcmath \
    php8.3-mysql \
    php8.3-pgsql \
    php8.3-mbstring \
    php8.3-zip \
    php8.3-bz2 \
    php8.3-sqlite3 \
    php8.3-soap \
    php8.3-intl \
    php8.3-imap \
    php8.3-imagick \
    php-memcached

# Install Composer
RUN curl -sS https://getcomposer.org/installer | php -- --install-dir=/usr/local/bin --filename=composer
ENV COMPOSER_ALLOW_SUPERUSER=1

# Install Node.js 22
RUN curl -sL https://deb.nodesource.com/setup_22.x | bash - && \
    apt-get install -y nodejs

# Install Docker
RUN curl -fsSL https://get.docker.com -o get-docker.sh && sh get-docker.sh && rm -rf get-docker.sh

# Install Bun
RUN curl -fsSL https://bun.sh/install | bash && \
    mv /root/.bun/bin/bun /usr/local/bin/bun && \
    rm -rf /root/.bun

# Cleanup
RUN apt-get clean && rm -rf /var/lib/apt/lists/*

# Save a version file
RUN echo "PHP: $(php -v | awk 'NR==1 {print $2}')" > versions.txt && \
    echo "Composer: $(composer --version --no-plugins | awk '{print $3}')" >> versions.txt && \
    echo "Node: $(node -v | sed 's/v//')" >> versions.txt && \
    echo "NPM: $(npm -v)" >> versions.txt && \
    echo "Docker: $(docker -v | awk '{print $3}' | sed 's/,//')" >> versions.txt && \
    echo "Bun: $(bun -v | sed 's/v//')" >> versions.txt

# Start with bash
CMD ["bash"]
