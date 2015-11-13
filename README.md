# Magento Tools Docker Container

This docker container is designed to contain command line tools that would be needed to support a magento installation.  We decided to separate it from the core  [magento container](https://github.com/meanbee/docker-magento).

Tools included:

- [composer](https://getcomposer.org/)
- [n98-magerun](https://github.com/netz98/n98-magerun)
- [magedbm](https://github.com/meanbee/magedbm)
- [mageconfigsync](https://github.com/punkstar/mageconfigsync)

#Usage

Required environment variables for commands in this container include:

- MAGE_ROOT_DIR (magerun & magebm)
- AWS_ACCESS_KEY_ID (magedbm)
- AWS_SECRET_ACCESS_KEY (magedbm)
- AWS_REGION (magedbm)
- AWS_BUCKET (magedbm)

The container also requires access to your Magento files, and access to the MySQL container.

##Docker Compose

Assuming you have a data container called `data` which contains your files that you mount to `/var/www/html`, and your MySQL container is called `db` then your `docker-compose.yml` might look something like this:

    magento-tools:
      image: meanbee/magento-tools
      environment:
        MAGE_ROOT_DIR: /var/www/html
        AWS_ACCESS_KEY_ID: replaceme
        AWS_SECRET_ACCESS_KEY: replaceme
        AWS_REGION: eu-west-1
        AWS_BUCKET: magedbm
      links:
        - db
      volumes_from:
        - data

This image can then be used to easily perform any command, for example:

    docker-compose run magento-tools magerun sys:config:list
    docker-compose run magento-tools magedbm get clientname
