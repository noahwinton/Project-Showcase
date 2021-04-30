import pandas as pd

data = pd.read_csv("C:\\Users\\noark\\Dropbox\\My PC (DESKTOP-BCOC4T7)\\Downloads\\AMZN_2012-06-21_34200000_57600000_message_1.csv")
def DataInfo(df):
    x = len(data)
    y =len(data.columns)
    print('There are', x, 'rows of data and', y,'columns of data.')
    print(data.head(8))
    MaxPrice = max(data["Price"])
    print('The highest price is', MaxPrice)
    highestPrice = data.groupby(['Direction']).max()
    highestPrice2 = highestPrice.drop([-1])
    price = highestPrice.iloc[1]['Price']
    print('The highest price for a buy order is', price)
    print(highestPrice2)

DataInfo(data)
    
