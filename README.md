# WordPress Boilerplate

Boilerplate for WordPress sites.

## 1) Installing the boilerplate

This boilerplate uses [Composer][1] to manage libraries, plugins and themes.

If you don't have Composer yet, download it following the instructions on http://getcomposer.org/ or just run the following command:

    curl -s http://getcomposer.org/installer | php

Then, use the `create-project` command to generate a new WordPress site:

    php composer.phar create-project --repository-url=http://packages.cristianhampus.se queensbridge/wordpress-boilerplate path/to/install

Composer will install WordPress and all its dependencies under the `path/to/install` directory.

[1]:  http://getcomposer.org/