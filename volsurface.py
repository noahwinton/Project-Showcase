#install packages first (not sure why they dont install correctly inside the function)
import datetime
from datetime import datetime
pip install yahoo_fin
from yahoo_fin import options

def VolSurfaceCalls(a = 'NULL'):
#converts date into correct format      
    a = "PLBY"
    def DateConvert(date = 'NULL'):
        import datetime
        from datetime import datetime
        date = datetime.strptime(date, "%B %d, %Y")
        date = date.strftime('%m/%d/%Y')
        
#gets options data for each correct date and add to lists

    xlist = []
    ylist = []
    zlist = []

    def DataExtraction(a,p):
        dates = options.get_expiration_dates(a)
        date = dates[p]
        newdate = DateConvert(date)
        data_chain1 = options.get_options_chain(a, newdate) 
        for i in (data_chain1["calls"]["Contract Name"]):
                xlist.append("20"+i[4:10])
        for i in (data_chain1["calls"]["Implied Volatility"]):
                ylist.append(i)
        for i in (data_chain1["calls"]["Strike"]):
                zlist.append(i)
     
    DataExtraction(a,0)
    DataExtraction(a,1)
    DataExtraction(a,2)
    DataExtraction(a,3)
    DataExtraction(a,4)
    def days_between(d1, d2):
        d1 = datetime.strptime(d1, "%Y%m%d")
        d2 = datetime.strptime(d2, "%Y-%m-%d")
        return abs((d2 - d1).days)

#formats data into correct point form
    for i in range(len(xlist)):
        today = datetime.today().strftime('%Y-%m-%d')
        xlist[i] = days_between(str(xlist[i]),today)
    
    for i in range(0, len(ylist)):
        ylist[i] = ylist[i].rstrip('%')
    import pandas as pd    
    df = pd.DataFrame()
    df["x"] = xlist    
    df["y"] = ylist     
    df["z"] = zlist
    return df

VolSurfaceCalls('PLBY')

df

    x1 = np.linspace(df['xlist'].min(), df['xlist'].max(), len(df['xlist'].unique()))
    y1 = np.linspace(float(df['y'].min()), float(df['y'].max()), len(df['y'].unique()))

VolSurfaceCalls("AAPL")

import numpy as np
import matplotlib.pyplot as plt
from matplotlib import cm
from matplotlib.ticker import LinearLocator, FormatStrFormatter
from mpl_toolkits.mplot3d import Axes3D
df = pd.DataFrame()
x1 = np.linspace(df['xlist'].min(), df['xlist'].max(), len(df['xlist'].unique()))
y1 = np.linspace(float(df['y'].min()), float(df['y'].max()), len(df['y'].unique()))

"""
x, y via meshgrid for vectorized evaluation of
2 scalar/vector fields over 2-D grids, given
one-dimensional coordinate arrays x1, x2,..., xn.
"""

x2, y2 = np.meshgrid(x1, y1)

# Interpolate unstructured D-dimensional data.
pip install scipy
z2 = scipy.Interpolate.griddata((df['x'], df['y']), df['z'], (x2, y2), method='cubic')

# Ready to plot
fig = plt.figure()
ax = fig.gca(projection='3d')
surf = ax.plot_surface(x2, y2, z2, rstride=1, cstride=1, cmap=cm.coolwarm,
                       linewidth=0, antialiased=False)
ax.set_zlim(-1.01, 1.01)

ax.zaxis.set_major_locator(LinearLocator(10))
ax.zaxis.set_major_formatter(FormatStrFormatter('%.02f'))

fig.colorbar(surf, shrink=0.5, aspect=5)
plt.title('Meshgrid Created from 3 1D Arrays')

plt.show()
© 2021 GitHub, Inc.