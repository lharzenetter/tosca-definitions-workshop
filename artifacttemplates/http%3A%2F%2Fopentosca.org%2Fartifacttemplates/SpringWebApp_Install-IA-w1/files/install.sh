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

  # find the executable jar file
  if [[ "${PATH[1]}" == *.jar ]];
  then
    # copy the config file to
    /usr/bin/sudo /bin/mkdir -p /var/www/java/${AppName}
    /usr/bin/sudo /bin/cp $CSAR${PATH[1]} /var/www/java/${AppName}/${AppName}.jar
  fi
done
