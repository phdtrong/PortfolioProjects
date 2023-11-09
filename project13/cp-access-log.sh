#Download source
wget https://cf-courses-data.s3.us.cloud-object-storage.appdomain.cloud/IBM-DB0250EN-SkillsNetwork/labs/Bash%20Scripting/ETL%20using%20shell%20scripting/web-server-access-log.txt.gz
#Unzip source
gunzip -f web-server-access-log.txt.gz
#Extract source to middle data storage
cut -d '#' -f1-4 web-server-access-log.txt > extracted-data.txt
#Transform data
tr '#' ',' < extracted-data.txt
#Load data to database/datawarehouse
#Connect through psql
#Add psql commands like select,.... before | psql connect command
echo "\c template1;\copy access_log from result.csv delimiters ',' csv;" | psql --user=posgres --host=localhost
