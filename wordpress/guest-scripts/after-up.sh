#!/bin/bash
sudo -i;
if service --status-all | grep -Fq 'docker'; then
	echo 'vagrant: starting docker daemon';
	cd /src/wordpress-environment;
	docker-compose up -d;
	service docker restart;
fi
