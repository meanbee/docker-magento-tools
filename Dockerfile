FROM meanbee/magento:5.6-cli

MAINTAINER Tom Robertshaw <tom.robertshaw@meanbee.com>

RUN apt-get update && apt-get install -y mysql-client

RUN curl -sS https://getcomposer.org/installer | php -- --install-dir=/ --filename=composer

# Download composer, magedbm, magerun and mageconfigsync
RUN curl https://getcomposer.org/composer.phar -o /composer.phar & \
    curl https://s3-eu-west-1.amazonaws.com/magedbm-releases/magedbm.phar -o /magedbm.phar & \
    curl http://files.magerun.net/n98-magerun-latest.phar -o /n98-magerun.phar & \
    curl -L https://github.com/punkstar/mageconfigsync/releases/download/0.4.0/mageconfigsync-0.4.0.phar -o /mageconfigsync.phar & \
    wait

RUN chmod +x /composer.phar
RUN chmod +x /magedbm.phar
RUN chmod +x /n98-magerun.phar
RUN chmod +x /mageconfigsync.phar

# Copy wrappers commands
COPY composer /usr/local/bin/
COPY magerun /usr/local/bin/
COPY magedbm /usr/local/bin/
COPY mageconfigsync /usr/local/bin/

RUN chmod +x /usr/local/bin/composer
RUN chmod +x /usr/local/bin/magerun
RUN chmod +x /usr/local/bin/magedbm
RUN chmod +x /usr/local/bin/mageconfigsync

## Frontend Tools
RUN curl --silent --location https://deb.nodesource.com/setup_0.12 | bash -
RUN apt-get install --yes nodejs

RUN npm install -g grunt-cli
RUN npm install -g gulp
