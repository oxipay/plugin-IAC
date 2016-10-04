#! /bin/bash
sudo -i;
if service --status-all | grep -Fq 'docker'; then
	echo 'vagrant: starting docker daemon';
	cd /src/wordpress-environment;
	docker-compose up -d;
	/src/scripts/set_wordpress_proxy.sh
	service docker restart;
fi
