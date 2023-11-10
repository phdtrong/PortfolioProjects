# 1st terminal: install kafka
wget https://archive.apache.org/dist/kafka/2.8.0/kafka_2.12-2.8.0.tgz & tar -xzf kafka_2.12-2.8.0.tgz
start_mysql & mysql --host=127.0.0.1 --port=3306 --user=root --password=Mjk0NDQtcnNhbm5h #start_mysql will give you host, port, user,pwd
# this is for database & table creation to store streamer messages
create database tolldata;
use tolldata;
create table livetolldata(timestamp datetime,vehicle_id int,vehicle_type char(15),toll_plaza_id smallint);
exit; # exit my sql database

# 2nd terminal: install python, create broker, topic, and producer
python3 -m pip install kafka-python
python3 -m pip install mysql-connector-python==8.0.31
? # start zookeper
? # start kafka server
? # create a topic named toll
# download toll_traffic_simulator.py and start simulating toll messages, change TOPIC variable inside it to 'toll' as specific topic
wget https://cf-courses-data.s3.us.cloud-object-storage.appdomain.cloud/IBM-DB0250EN-SkillsNetwork/labs/Final%20Assignment/toll_traffic_generator.py & python3 toll_traffic_generator.py

# 3rd terminal: download streaming_data_reader.py and start listening to those toll messages, change TOPIC, DATABASE, USERNAME, PASSWORD variables inside it to 'toll', 'tolldata', username, pwd of start_mysql above
wget https://cf-courses-data.s3.us.cloud-object-storage.appdomain.cloud/IBM-DB0250EN-SkillsNetwork/labs/Final%20Assignment/streaming_data_reader.py & python3 streaming_data_reader.py

# 4th terminal: open the database, use database tolldata, and query 1st 10 rows of listening data then
start_mysql & mysql --host=127.0.0.1 --port=3306 --user=root --password=Mjk0NDQtcnNhbm5h #start_mysql will give you host, port, user,pwd
use tolldata
select * from livetolldata limit 10;
