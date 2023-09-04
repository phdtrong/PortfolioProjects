# This project is reading the data file before indexing by country field, 
# filtering and then ordering those records accordingly
import pandas as pd
df = pd.read_csv("world_population.csv")
# FILTERING=============================

print('show data frame')
print(df)

print('show top 10 countries')
print(df[df['Rank']<=10])

df2 = df.set_index('Country')

print('set index as country items')
print(df2)

print('filter df2 as continent and CCA3') # horizontal axis
print(df2.filter(items = ['Continent','CCA3'], axis = 1))

print('filter df2 as country item is Zimbabwe') # vertical axis
print(df2.filter(items = ['Zimbabwe'], axis = 0))
print(df2.filter(like = 'Zimbabwe', axis = 0))

print('Row record of index as United States') 
print(df2.loc['United States'])

print('Row record of integer index as # 8')
print(df2.iloc[8])

# ORDER BY===================
print('Sorting by rank (aascending) and then country(descending) columns')
df3 = df2[df2['Rank']<10]
print(df3.sort_values(by=['Rank','Country'], ascending=[True,False]))
