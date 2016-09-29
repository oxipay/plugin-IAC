#! /bin/bash
sudo -i;
if service --status-all | grep -Fq 'docker'; then
	cd /src/wordpress-environment;
	docker-compose down;
	service docker stop;
fi