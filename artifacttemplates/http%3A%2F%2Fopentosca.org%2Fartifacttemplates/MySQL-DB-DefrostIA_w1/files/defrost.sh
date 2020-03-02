#!/bin/bash
databaseuser=$DBUser
databasepw=$DBPassword
databasename=$DBName
dbmsroot=$DBMSUser
dbmspw=$DBMSPassword

#create database
mysql -u$dbmsroot -p$dbmspw -e "use mysql; create database $databasename;"

#create user and set access rights
mysql -u$dbmsroot -p$dbmspw -e "use mysql; create user '$databaseuser'@'%' identified by '$databasepw'; grant all privileges on $databasename.* to '$databaseuser'@'%'; flush privileges;"

#find csar root
csarRoot=$(find ~ -maxdepth 1 -path "*.csar");

# iterate over map of DAs
IFS=';' read -ra NAMES <<< "$DAs";
for i in "${NAMES[@]}"; do
	echo "KeyValue-Pair: "
    echo $i
    IFS=',' read -ra PATH <<< "$i";
    	echo "Key: "
    	echo ${PATH[0]}
    	echo "Value: "
    	echo ${PATH[1]}

	# is it a state file ? at least the ending
	if [[ "${PATH[1]}" == *.state ]];
	then
		# connect to database and dump in the statements
		/usr/bin/mysql -u$databaseuser -p$databasepw -D$databasename < $csarRoot${PATH[1]};
	fi
done

echo "Done."
