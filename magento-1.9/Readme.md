# magento-dev
## a vagrant environment for magento 1.9 development

### dependencies
- lamp.dev https://bitbucket.org/jimburger/lamp-dev

### 
once lamp.dev is included in your vagrant boxes you 
should be able to clone this repo into the folder that you intend to begin development from

```
git clone https://[username]@bitbucket.org/oxipay/magento-dev.git
cd magento-dev
vagrant up
```

#### ports
* host 8000 : guest 80 - apache2
* host 3306 : guest 3306 - mysql
* host 9001 : guest 9000 - xdebug

You should be able browse to http://localhost:8000/magento/ to begin configuring your instance

To begin plugin development

