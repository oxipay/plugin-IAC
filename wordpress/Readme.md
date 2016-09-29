# Wordpress environment setup for plugin development

## Dependencies

This LAMP stack uses docker under the hood and requires a docker pull to:
- mysql:5.7
- jburger/wordpress-xdebug:latest

This is a repository that contains an environment configuration for bringing up a clean wordpress development environment.
It is built upon:

- Ubuntu Desktop
- Apache
- Wordpress
- MySQL
- PHP

## Pre-requisites
- Requires a working installation of Vagrant
- Also requires the vagrant-triggers vagrant plugin to automate aspects of docker
- The shell being used to run Vagrant requires internet access. If you are behind a corporate proxy then you will need to ensure the shell you are working from is configured appropriately. If you have an environment variable 'HTTP_PROXY' set - the provisioning process will use this for all apt-get installs, docker pulls and git pulls/pushes.

##### Note: The first time provisioning process will download a fair bit of data and may take 30 minutes to complete in some cases. 

## Usage
1. Clone the plugin-iac environment repository, and cd into the wordpress directory

```bash
cd wordpress
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

5. Optional: if you are working on a wordpress plugin, clone it into the www/wp-content/plugins

6. You should now be able to open a browser on your machine, to http://localhost:8000 and start configuring your platform and testing out your plugin

## Debugging with PHPStorm

In order to take advantage of xdebug and set breakpoints in the code you will need:

* PHP Storm or another IDE capable of remote debugging an xdebug endpoint

1. File Menu -> Settings -> Languages & Frameworks -> PHP -> Debug -> DBGp Proxy

* IDE key: phpstorm
* Host: localhost
* Port: 9000
* OK

2. Run Menu -> Edit Configurations... -> Hit the + button in top left of window

* Name: xdebug
* Add a server by clicking the ... button
* Hit the + button in top left of window
* Name: vagrant
* Host: localhost
* Port: 9000
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
