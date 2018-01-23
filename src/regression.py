import os
import pickle
import numpy as np
import pandas as pd
import numpy.linalg as npla
import matplotlib.pyplot as plt
from sklearn.linear_model import LinearRegression, Ridge, Lasso, ElasticNet, LogisticRegression
from sklearn.metrics import accuracy_score, log_loss

from sklearn.model_selection import train_test_split, GridSearchCV, RandomizedSearchCV, cross_val_score


## get data
grades = pd.read_csv("results/math_grades.csv")

##find grade shape
#grades.shape()

##extract data
y = grades.iloc[:,30].values
X = grades.iloc[:,0:30].values

###Separate into a test set and training set
Xtrain, Xtest, ytrain, ytest = train_test_split(X, y, test_size=0.20, random_state=1980)


