# -*- coding: utf-8 -*-
"""
Created on Sun Oct 30 20:14:38 2016

@author: shravankumar
"""

import numpy as np
import plotly.plotly as py
import pandas as pd
import matplotlib.pyplot as plt

tr = pd.read_excel('/home/shravankumar/Documents//DeepLearning/viz_project/datasets/tn_rainfall.xlsx')
ar = pd.read_excel('/home/shravankumar/Documents//DeepLearning/viz_project/datasets/ap_rainfall.xlsx')
gr = pd.read_excel('/home/shravankumar/Documents//DeepLearning/viz_project/datasets/gujrt_rainfall.xlsx')

labels = ('Jan-Feb','Mar-May','Jul-Sep','Oct-Dec')

def excel_process(fname):
    fd = fname.drop('NAME',axis=1)
    fd = fd.drop('Dist',axis=1)
    fa = np.asarray(fd.astype(float))
    return fa

a = excel_process(ar)
g = excel_process(gr)
t = excel_process(tr)

def bar_n_pie(mat):
    for i in range(len(labels)):
        x = mat[:,i+12]
        n_groups = len(x)
############################################################        
        # trying for normalization
        x = np.abs((x-x.mean())/x.std())
        
############################################################        
        index = np.arange(n_groups)
        bar_width = 0.35
        
    
        plt.bar(range(len(x)),x,color = 'bcrg')
        plt.xlabel('Quarters')
        plt.ylabel('Rain Fall in cm')
        plt.title('Rain fall in Mizoram')
        plt.xticks(index + bar_width, labels)
        plt.tight_layout()
        plt.show()
    
        plt.pie(x,labels=labels,startangle=90)
        #plt.pie(x,labels=labels,autopct='%1.1f%%',startangle=90) #to see percentages of sectors 
        plt.axis('equal')
        plt.show()
        
    
#bar_n_pie(a)
        
    