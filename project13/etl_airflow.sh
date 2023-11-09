# move the python task to DAGS list
cp ETL_Server_Access_Log_Processing.py $AIRFLOW_HOME/dags

# list out existing(submitted) dags
airflow dags list

# verify the my-first-dag is in the output list
irflow dag list | grep "ETL_Server_Access_Log_Processing"

# run the "my-first-dag"
airflow tasks list ETL_Server_Access_Log_Processing
