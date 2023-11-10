# make new directory
# sudo mkdir -p /home/project/airflow/dags/finalassignment/staging

# download data and put through a destination indicated by -P 
# sudo wget -P /home/project/airflow/dags/finalassignment https://cf-courses-data.s3.us.cloud-object-storage.appdomain.cloud/IBM-DB0250EN-SkillsNetwork/labs/Final%20Assignment/tolldata.tgz

# assigning sudo rights to files
# sudo chown -R 100999 /home/project/airflow/dags/finalassignment
# sudo chmod -R g+rw /home/project/airflow/dags/finalassignment
# sudo chown -R 100999 /home/project/airflow/dags/finalassignment/staging
# sudo chmod -R g+rw /home/project/airflow/dags/finalassignment/staging

# move this Python file to the working directory
# sudo mv ETL_toll_data.py /home/project/airflow/dags/finalassignment/staging

# move to working directory
# cd /home/project/airflow/dags/finalassignment/staging

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
    'ETL_toll_data',
    default_args=default_args,
    description='Apache Airflow Final Assignment',
    schedule_interval=timedelta(days=1), # daily once
)

# define the tasks
# unzip task

unzip_data = BashOperator(
    task_id='unzip_data',
    bash_command='tar -xvzf ../tolldata.tgz -C\
         /home/project/airflow/dags/finalassignment/',
    dag=dag,
)

# extract_data_from_csv task
extract_data_from_csv = BashOperator(
    task_id='extract_data_from_csv',
    bash_command='cut -d"," -f1-4 \../vehicle-data.csv >\
        ../csv_data.csv',
    dag=dag,
)

# extract_data_from_tsv task
extract_data_from_tsv = BashOperator(
    task_id='extract_data_from_tsv',
    bash_command='cut -d"," -f5-7 ../tollplaza-data.tsv >\
         ../tsv_data.csv',
    dag=dag,
)

# extract_data_from_fixed_width task
extract_data_from_fixed_width = BashOperator(
    task_id='extract_data_from_fixed_width',
    bash_command='rev ../payment-data.txt | cut -d" "\
                 -f2,1 | rev > ../fixed_width_data.csv',
    dag=dag,
)

# consolidate_data task
consolidate_data = BashOperator(
    task_id='consolidate_data',
    bash_command="paste -d ',' ../csv_data.csv \
        ../tsv_data.csv ../fixed_width_data.csv \
            > ../extracted_data.csv",
    dag=dag,
)

# transform_data task
transform_data = BashOperator(
    task_id='transform_data',
    bash_command='tr [a-z] [A-Z] ../extracted_data.csv \
            > ../transformed_data.csv',
    dag=dag,
)

# task pipeline
unzip_data >> extract_data_from_csv >> \
    extract_data_from_tsv >> extract_data_from_fixed_width >> \
        consolidate_data >> transform_data

# submit task
# cp ETL_toll_data.py $AIRFLOW_HOME/dags
# list out task
# airflow dags list
# list errors
# airflow dags list-import-errors
# verify if specified dag existed
# airflow dag list | grep "ETL_toll_data"
# unpause the dag
# airflow dags unpause ETL_toll_data
# run it
# airflow tasks list ETL_toll_data