# magento-dev
## a vagrant environment for magento 1.9 development

### dependencies
- lamp.dev

Once lamp.dev is included in your vagrant boxes you should be cd into this folder and provision the vagrant box.

```
cd magento-1.9
vagrant up
```
Once up, you should be able browse to http://localhost:8000/magento/ to begin configuring your instance.

#### ports
* host 8000 : guest 80 - apache2
* host 3306 : guest 3307 - mysql

#### drive mappings
Vagrant will map the following drives:

./magento to [guest]:/var/www/html/magento

### Plugin development
Once provisioned you should be able to browse to ./magento/app/code on your host and begin adding plugin related code files. You may need to either turn off magento's cache, or periodically flush it in order to see changes occur, but for the most part you can simply trust development done on the host will be picked up by the magento instance on the guest.





