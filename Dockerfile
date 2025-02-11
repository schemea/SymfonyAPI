FROM php

RUN php -r "copy('https://getcomposer.org/installer', 'composer-setup.php');" && \
    php -r "if (hash_file('sha384', 'composer-setup.php') === '756890a4488ce9024fc62c56153228907f1545c228516cbf63f885e036d37e9a59d27d63f46af1d4d07ee0f76181c7d3') { echo 'Installer verified'; } else { echo 'Installer corrupt'; unlink('composer-setup.php'); } echo PHP_EOL;" && \
    php composer-setup.php && \
    php -r "unlink('composer-setup.php');" && \
    install composer.phar /usr/local/bin/composer

ADD https://get.symfony.com/cli/installer /tmp/installer

RUN chmod +x /tmp/installer && /tmp/installer --install-dir=/usr/local/bin && rm /tmp/installer

WORKDIR /app

ENTRYPOINT [ "symfony", "server:start" ]