# import the libraries
from datetime import timedelta
# The DAG object; we'll need this to instantiate a DAG
from airflow import DAG
# Operators; we need this to write tasks!
from airflow.operators.bash_operator import BashOperator
# This makes scheduling easy
from airflow.utils.dates import days_ago

#defining DAG arguments

# You can override them on a per-task basis during operator initialization
default_args = {
    'owner': 'Your name here',
    'start_date': days_ago(0),
    'email': ['your_email_here@somemail.com'], # demo purpose
    'email_on_failure': False,
    'email_on_retry': False,
    'retries': 1,
    'retry_delay': timedelta(minutes=5),
}

# defining the DAG

# define the DAG
dag = DAG(
    'my-first-dag',
    default_args=default_args,
    description='My first DAG',
    schedule_interval=timedelta(days=1), # dag is running daily
)

# define the tasks

# download task

download = BashOperator(
    task_id='download',
    bash_command='wget https://cf-courses-data.s3.us.cloud-object-storage.appdomain.cloud/IBM-DB0250EN-SkillsNetwork/labs/Apache%20Airflow/Build%20a%20DAG%20using%20Airflow/web-server-access-log.txt',
    dag=dag,
)

# extract task
# working file: web-server-access-log.txt
extract = BashOperator(
    task_id='extract',
    bash_command='cut -d":" -f1,4 /web-server-access-log.txt > /home/project/airflow/dags/extracted-data.txt',
    dag=dag,
)

# transform task
transform = BashOperator(
    task_id='transform',
    bash_command='tr "[a-z]" "[A-Z]" < /home/project/airflow/dags/extracted-data.txt > /home/project/airflow/dags/transformed-data.csv',
    dag=dag,
)

# zip and load task
load = BashOperator(
    task_id='load',
    bash_command='zip compress.zip /home/project/airflow/dags/transformed-data.csv',
    dag=dag,
)

# task pipeline
extract >> transform >> load




# move the python task to DAGS list
cp ETL_Server_Access_Log_Processing.py $AIRFLOW_HOME/dags

# list out existing(submitted) dags
airflow dags list

# verify the my-first-dag is in the output list
irflow dag list | grep "ETL_Server_Access_Log_Processing"

# run the "my-first-dag"
airflow tasks list ETL_Server_Access_Log_Processing