# python3.11 -m pip install -q requests datetime bs4 numpy pandas
import requests
from bs4 import BeautifulSoup
from datetime import datetime
import pandas as pd
import numpy as np
import sqlite3

url = 'https://web.archive.org/web/20230902185326/https://en.wikipedia.org/wiki/List_of_countries_by_GDP_%28nominal%29'
db_name  = 'World_Economies.db'
table_attribs = ['Country','GDP_USD_billion']
csv_path = 'Countries_by_GDP.csv'
log_file = 'etl_project_log.txt'

def extract(url, table_attribs):
    ''' This function extracts the required
    information from the website and saves it to a dataframe. The
    function returns the dataframe for further processing. '''
    df = pd.DataFrame(columns=table_attribs)
    raw_data = requests.get(url)
    soup = BeautifulSoup(raw_data.text, 'html.parser')
    html_data = soup.find_all('tbody')[2].find_all('tr')

    for row in html_data[3:]:
        row_data = row.find_all('td')
        if '—' not in row_data[2]:
            df = df._append({'Country':row_data[0].text.strip(), 
            'GDP_USD_billion':(float(row_data[2].text.replace(',','')))}, ignore_index=True)
    return df

def transform(df):
    ''' This function converts the GDP information from Currency
    format to float value, transforms the information of GDP from
    USD (Millions) to USD (Billions) rounding to 2 decimal places.
    The function returns the transformed dataframe.'''
    df['GDP_USD_billion'] = np.round(df['GDP_USD_billion']/1000,2)
    return df

def load_to_csv(df, csv_path):
    ''' This function saves the final dataframe as a `CSV` file 
    in the provided path. Function returns nothing.'''
    return df.to_csv(csv_path)

def load_to_db(df, table_name, sql_connection):
    ''' This function saves the final dataframe as a database table
    with the provided name. Function returns nothing.'''
    return df.to_sql(table_name, sql_connection, if_exists='replace', index=False)

def run_query(query_statement, sql_connection):
    ''' This function runs the stated query on the database table and
    prints the output on the terminal. Function returns nothing. '''
    print(pd.read_sql(query_statement,sql_connection))


def log_progress(message):
    f = open(log_file, 'a')
    f.write(str(datetime.now()) + ': ' +message + '\n')
    f.close()

log_progress('start extracting')
df = extract(url, table_attribs)

log_progress('start transofrming')
df = transform(df)

log_progress('start loading to csv file')
load_to_csv(df, csv_path)

table_name = 'Countries_by_GDP'

log_progress('start loading to database')
sql_connection = sqlite3.connect(db_name)

load_to_db(df, table_name, sql_connection)

query_statement = f"select * from {table_name} where GDP_USD_billion >= 100"
run_query(query_statement, sql_connection)

sql_connection.close()

log_progress('done')