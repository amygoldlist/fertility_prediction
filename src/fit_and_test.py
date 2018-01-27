
##Import all needed modules
import numpy as np
import pandas as pd
#import numpy.linalg as npla
#import matplotlib.pyplot as plt
from sklearn.linear_model import LinearRegression, Ridge, Lasso, ElasticNet, LogisticRegression
from sklearn.metrics import  mean_squared_error, SCORERS, make_scorer
from sklearn.svm import SVR, LinearSVR
from collections import deque
from sklearn.model_selection import  GridSearchCV, train_test_split

##Import training and test data
grades = pd.read_csv("results/grades_train_num.csv")
test_set = pd.read_csv("results/grades_test_num.csv")

##find and use shape
n = grades.shape[1]-1

##extract data
###new trainging set
print("Here are the features selected!")
print(grades.iloc[:,[14, 11, 12, 7, 15, 0, 4, 13, 1, 22]].head(0))

X = grades.iloc[:,[14, 11, 12, 7, 15, 0, 4, 13, 1, 22]].values
y = grades.iloc[:,n].values

ytest = test_set.iloc[:,n].values
Xtest = test_set.iloc[:,[14, 11, 12, 7, 15, 0, 4, 13, 1, 22]].values


##create a scoring function, we'll use the Mean Square Error (MSE)
## I based this on the code given in lab 2
def MSE(y, yhat):
    mse = np.mean((y-yhat)**2)
    return(mse)

##create a scorer that uses the Mean Squared Error (MSE)
##This actually returns the NEGATIVE, so that bigger is better
mse_score = make_scorer(mean_squared_error, greater_is_better=True)

##My new model
model = SVR(epsilon=0, kernel="rbf", C = 5000, gamma = 0.01)
model.fit(X,y)

##check stuff
print("Using SVR on our smaller set with epsilon =0, kernel =rbf.")
print("The MSE is", MSE(y, model.predict(X)))

##Create some predictions!
y_pred = model.predict(X)
y_pred_test = model.predict(Xtest)
print("The test MSE is", MSE(ytest, model.predict(Xtest)))

##Save predictions to use in a fancy R Rscript
np.savetxt("results/training_predictions.csv", y_pred, delimiter=",")
np.savetxt("results/test_predictions.csv", y_pred_test, delimiter=",")
