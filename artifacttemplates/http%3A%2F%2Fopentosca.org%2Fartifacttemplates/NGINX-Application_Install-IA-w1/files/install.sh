#!/bin/bash
sudo apt update -qq
sudo apt -qqy install unzip;

IFS=';' read -ra NAMES <<< "$DAs";
for i in "${NAMES[@]}"; do
    IFS=',' read -ra PATH <<< "$i";
  # find the zip file
    if [[ "${PATH[1]}" == *.zip ]];
    then
        # unzip the application to
        /usr/bin/sudo /bin/mkdir -p /var/www/html/${AppName}
        /usr/bin/sudo /usr/bin/unzip $CSAR${PATH[1]} -d /var/www/html/${AppName}
    fi
done

echo "installed website at /var/www/html/${AppName}"
