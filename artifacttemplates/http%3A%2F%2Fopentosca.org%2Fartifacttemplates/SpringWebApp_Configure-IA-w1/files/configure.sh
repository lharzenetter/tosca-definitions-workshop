#!/bin/bash
IFS=';' read -ra NAMES <<< "$DAs";
for i in "${NAMES[@]}"; do
  echo "KeyValue-Pair: "
  echo $i
  IFS=',' read -ra PATH <<< "$i";
      echo "Key: "
      echo ${PATH[0]}
      echo "Value: "
      echo ${PATH[1]}

  # find the .properties file
  if [[ "${PATH[1]}" == *.properties ]];
  then
    # copy the config file to
    /usr/bin/sudo /bin/cp $CSAR${PATH[1]} /var/www/java/${AppName}/application.properties
  # else if a application .yml is provided, copy it
  elif [[ "${PATH[1]}" == *.yml ]]
  then
    /usr/bin/sudo /bin/cp $CSAR${PATH[1]} /var/www/java/${AppName}/application.yml
  fi
done

sudo iptables -A INPUT -p tcp -m tcp --dport $Port -j ACCEPT
