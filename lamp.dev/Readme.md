# lamp.dev

A barebones vagrant based LAMP stack on ubuntu desktop. For development and debugging.

Installed: 
* apache2
* mysql
* xdebug
* git
* curl

### Tips

- Xdebug is configured to listen to 10.0.2.2:9000 (this IP is a default set by vagrant)
- If you need to work from behind a company proxy, this vagrant file will attempt to use the proxy set in the HTTP_PROXY environment variable. *Please ensure this is set before using vagrant up!*

### MySQL
username: root
password: password

### apache2
directory root is /var/www/html
mod rewrite is enabled
