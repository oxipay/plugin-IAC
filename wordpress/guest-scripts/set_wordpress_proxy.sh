#!/bin/bash
#
#Set the file to use (Must exist)
file="/src/wordpress/wp-config.php"
#
#Check if file exists if not loop da loop
i=0
while [ ! -e $file ]; do
        i=$((i+1))
        sleep 15
        if [ $i -eq 8 ]; then
                exit
        fi
done
#
#Check if the proxy server is set
if [ -u $1 ]; then
        exit
else
	proxy=$1
	server="$(echo $proxy | cut -f1 -d':')"
	port="$(echo $proxy | cut -f2 -d':')"
fi
#
#If the file does not exist then exit
if [ ! -e $file ]; then
        exit
fi
#
#If the file is a regular file then write into it
if [ -f $file ]; then
       echo "" >> "$file";
       echo "/* Configure proxy Server */" >> "$file";
       echo "define('WP_PROXY_HOST', '$server');" >> "$file";
       echo "define('WP_PROXY_PORT', '$port');" >> "$file";
       echo "define('WP_PROXY_USERNAME', '');" >> "$file";
       echo "define('WP_PROXY_PASSWORD', '');" >> "$file";
       echo "define('WP_PROXY_BYPASS_HOSTS', 'localhost, 127.0.0.1');" >> "$file";
fi
#
#Job Done
