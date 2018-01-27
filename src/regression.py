##Import all needed modules
import numpy as np
import pandas as pd
#import matplotlib.pyplot as plt
from sklearn.linear_model import LinearRegression, Ridge, Lasso, ElasticNet, LogisticRegression
from sklearn.metrics import  mean_squared_error, SCORERS, make_scorer
from sklearn.svm import SVR, LinearSVR
from sklearn.model_selection import  GridSearchCV


##Import training data
grades = pd.read_csv("results/grades_train_num.csv")

##find and use shape
n = grades.shape[1]-1

##extract data
y = grades.iloc[:,n].values
X = grades.iloc[:,0:n].values

##Import Testing data
test_set = pd.read_csv("results/grades_test_num.csv")

##find and use shape
n = test_set.shape[1]-1

##extract data
ytest = test_set.iloc[:,n].values
Xtest = test_set.iloc[:,0:n].values

##Scoring functions

##create a scoring function, we'll use the Mean Square Error (MSE)
## I based this on the code given in lab 2
def MSE(y, yhat):
    mse = np.mean((y-yhat)**2)
    return(mse)

##create a scorer that uses the Mean Squared Error (MSE)
##This actually returns the NEGATIVE, so that bigger is better
mse_score = make_scorer(mean_squared_error, greater_is_better=True)



##Let's do some Support Vector Regression!

parameters = {'gamma':[0.000001,0.00001,0.0001,0.001,0.01,0.1,1],
              'C':[1,10,100,500,1000,5000,1000],}

kr = SVR(epsilon=0, kernel="rbf")

##we're going to use 10-fold cross validation
model =GridSearchCV(kr,parameters, cv =10, scoring = mse_score)
model.fit(X,y)

##check stuff
print("Using SVR with epsilon =0, kernel =rbf.")
print("Find the optimal values of gamma and C using a gridsearch with 10-fold cross validation")
print("Here, the scoring is the negative Mean Squared Error")
print(model.best_params_)
print("cross validation score for model: ",model.best_score_)
print("The MSE is", MSE(y, model.predict(X)))

##Create some predictions!
y_pred = model.predict(X)
y_pred_test = model.predict(Xtest)
print("The test MSE is", MSE(ytest, model.predict(Xtest)))
