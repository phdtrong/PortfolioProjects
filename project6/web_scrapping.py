# Get into real data of the global largest companies (revenue) from Wikipedia source
# and extract data from it to transform and export to a csv file
# Result should show in a file named companies.csv for later usage 
# Step   Description
# 1      get the web link
# 2      connect data link
# 3      target table/data/record
# 4      extract data
# 5      save to data frame in Python
# 6      transform and load to Excel, CSV or other format for later loading purposes
# (*)    problem with Beautifulsoup parsing, 
#        --> solution is using the html.parser mark in Beautifulsoup instructor

from bs4 import BeautifulSoup
import requests

url = 'https://en.wikipedia.org/wiki/List_of_largest_companies_in_the_United_States_by_revenue'
page = requests.get(url) # get the url content as a link
soup = BeautifulSoup(page.text, 'html.parser') # get html content of the link
# print(soup)
world_table = soup.find_all('table')[1]
world_table_title = world_table.find_all('th')
world_table_title = [title.text.strip() for title in world_table_title]
# print(world_table_title)

import pandas as pd
# save the title to a data frame
df = pd.DataFrame(columns = world_table_title)
# extract data
column_data = world_table.find_all('tr')

# saving data to data frame
for row in column_data[1:]:
  row_data = row.find_all('td')
  individual_row_data = [data.text.strip() for data in row_data]
  
  # now, fun part, put data into the table
  length = len(df) 
  df.loc[length] = individual_row_data

#now, export data to a csv file
df.to_csv('companies.csv', index=False)
