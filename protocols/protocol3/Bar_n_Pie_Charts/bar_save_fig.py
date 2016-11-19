# -*- coding: utf-8 -*-
"""
Created on Tue Nov  1 21:11:45 2016

@author: shravankumar
"""


# Import the required packages
import numpy as np
import plotly.plotly as py
import pandas as pd
import matplotlib.pyplot as plt
#get_ipython().magic(u'matplotlib inline')

# read-in the files of data
mr = pd.read_excel('/home/shravankumar/Documents//DeepLearning/viz_project/datasets/mizoram_rain.xlsx')
tr = pd.read_excel('/home/shravankumar/Documents//DeepLearning/viz_project/datasets/tn_rainfall.xlsx')
ar = pd.read_excel('/home/shravankumar/Documents//DeepLearning/viz_project/datasets/ap_rainfall.xlsx')
gr = pd.read_excel('/home/shravankumar/Documents//DeepLearning/viz_project/datasets/gujrt_rainfall.xlsx')

# assign lables for plots
labels = ('Jan-Feb','Mar-May','Jul-Sep','Oct-Dec')
color = ['brbb','rbbb','bbrb','bbbr','brbb','rbbb','bbrb','bbbr','brbb','rbbb','bbrb','bbbr']
# helper-function: removes unnecessary information and makes a numpy array of the data
def excel_process(fname):
    fd = fname.drop('NAME',axis=1)
    fd = fd.drop('Dist',axis=1)
    fa = np.asarray(fd.astype(float))
    return fa

a = excel_process(ar)
g = excel_process(gr)
t = excel_process(tr)
m = excel_process(mr)

print('||||||||||||||||||||||||||||||||||||||||||||||||||||')
print('Please Enter the starting letter of the state below')
print('a | g | t | m')
print('||||||||||||||||||||||||||||||||||||||||||||||||||||')

print('##########################################')
s = raw_input('Enter Char:')

# helper-function: to extract groups of Jan - Dec months and plotting the bar and pie charts
def bar_n_pie(mat,norm = True):
    '''mat: array resulted after axcel_preprocess
    norm is for to make sure data almost distributed uniformly
    norm: True(Default) change to False if you do not want to use normalization'''
    
    for i in range(len(labels)):
        x = mat[:,i+12]
        n_groups = len(x)
        if norm:
    ############################################################        
            # trying for normalization
            x = np.abs((x-x.mean())/x.std())
            x = (100*x)/2
            
    ############################################################
        else:
            x = x
        index = np.arange(n_groups)
        bar_width = 0.35
        
        print("image{:.2f}".format(i+1))
        name = "bar{:.2f}".format(i+1)
        name = s +name + '.png'
        print(name)
        plt.figure()
        plt.bar(range(len(x)),x,color = color[np.random.randint(1,len(color))])
#        plt.bar(range(len(x)),x,color = 'w')
#        plt.xlabel('Quarters')
#        plt.ylabel('Rain Fall in cm')
#        plt.title('Rain fall')
#        plt.xticks(index + bar_width, labels)
        plt.xticks([])
        plt.yticks([])
        plt.tight_layout()
#        plt.ylim(0,100)
        plt.savefig(name)
#        plt.show()

        


# In[12]:

bar_n_pie(a)

# In[13]:

bar_n_pie(g)
#
#
## In[14]:
#
bar_n_pie(t)
#
#
## In[15]:
#
bar_n_pie(m)

