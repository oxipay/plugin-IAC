# plugin-dev PHP development environment configuration for working on php plugins

## What is this?

This is a repository that contains environment configuration for bringing up clean development environments for the following platforms:
- WooCommerce (Wordpress)
- Magento 1 & 2 
- Onestep

## Pre-requisites
- Requires a working installation of Vagrant
- Also requires the vagrant-triggers vagrant plugin to automate aspects of docker
- The shell being used to run Vagrant requires internet access. If you are behind a corporate proxy then you will need to ensure the shell you are working from is configured appropriately. If you have an environment variable 'HTTP_PROXY' set - the provisioning process will use this for all apt-get installs, docker pulls and git pulls/pushes.

##### Note: The first time provisioning process will download a fair bit of data and may take 30 minutes to complete in some cases. 

## Usage
1. Clone the plugin-dev environment repository, and choose the 'flavour' of platform your interested by checking out the relevant branch:

```bash
cd /path/to/src
git clone https://bitbucket.org/oxipay/plugin-dev
cd plugin-dev
git checkout wordpress
#git checkout magento_1 - Not start
#git checkout magento_2 - Not started
#git checkout onestep - Not started
```

2. The vagrant file depends on the following vagrant plugin: [https://github.com/emyl/vagrant-triggers]()

```bash
vagrant plugin install vagrant-triggers
```

3. Use vagrant to provision your development environment
```bash
vagrant up
```

4. On completion, you should have a virtualbox instance up and running, and it will have installed docker and a few other goodies to make development & troubleshooting a little easier. Now would be a good time to make a snapshot:
```bash
vagrant snapshot push
```

5. Optional: if you are working on a plugin, clone it into the 'www' directory structure in the appropriate location for the platform you have selected. For wordpress based development, this is typically in www/wp-content/plugins

6. You should now be able to open a browser on your machine, to http://localhost:8000 and start configuring your platform and testing out your plugin

## Debugging with PHPStorm

In order to take advantage of xdebug and set breakpoints in the code you will need:

* PHP Storm or an IDE capable of remote debugging an xdebug endpoint

This wordpress environment has xdebug installed and listening on port 9001 to your workstation (port 9000 internally to the vagrant box). In PHP Storm, you can configure your IDE to interact:

1. File Menu -> Settings -> Languages & Frameworks -> PHP -> Debug -> DBGp Proxy

* IDE key: phpstorm
* Host: localhost
* Port: 9001
* OK

2. Run Menu -> Edit Configurations... -> Hit the + button in top left of window

* Name: xdebug
* Add a server by clicking the ... button
* Hit the + button in top left of window
* Name: vagrant
* Host: localhost
* Port: 9001
* Debugger: Xdebug
* OK
* Servers: vagrant
* Ide key: phpstorm
* OK

You should now be able to use Run Menu -> Debug (Alt+F5) and set breakpoints etc.

### Other notes
This vagrant environment is pre-configured to mount the following folders in the same directory as the Vagrantfile:

* ./www (website content - mapped to /src/wordpress on vagrant box)

The vagrant box has the following mounts:

* /src/wordpress-environment (docker related configuration files)
* /src/scripts (guest scripts triggers on vagrant up/halt)
* /src/wordpress (website content - mapped to ./www on your machine*