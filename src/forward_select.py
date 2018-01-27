
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

##Import training data
grades = pd.read_csv("results/grades_train_num.csv")

##find and use shape
n = grades.shape[1]-1

##extract data
y = grades.iloc[:,n].values
X = grades.iloc[:,0:n].values


##Using forward selection

##I have used the forward selection algorithm from lab 1 solutions
## It runs MUCH better than mine.


def fit_and_report(model, X, y, Xv, yv):
    model.fit(X,y)
    mean_squared_err = lambda y, yhat: np.mean((y-yhat)**2)
    errors = [mean_squared_err(y, model.predict(X)), mean_squared_err(yv, model.predict(Xv))]
    return errors



class ForwardSelection:
    def __init__(self, model, min_features=None, max_features=None,
                 scoring=None, cv=None):
        self.max_features = max_features
        if min_features is None:
            self.min_features = 1
        else:
            self.min_features = min_features

        self.model = model
        self.scoring = scoring
        self.cv = cv
        return

    def fit(self, X, y):
        if (self.max_features is None) or (self.max_features > X.shape[1]):
            self.max_features = X.shape[1]

        self.ftr_ = []
        idx = np.setdiff1d(range(X.shape[1]), self.ftr_)

        best_round_score = deque()
        best_round_score.append(np.inf)

        X_train, X_val, y_train, y_val = train_test_split(X, y)

        for j in range(self.max_features):
            round_scores = np.zeros(idx.size)
            for i, ii in enumerate(idx):
                X_train_s = X_train[:, self.ftr_ + [ii]]
                X_val_s = X_val[:, self.ftr_ + [ii]]
                round_scores[i] = fit_and_report(self.model, X_train_s, y_train,
                                                 X_val_s, y_val)[1] # val error only

            i_star = np.argmin(round_scores)
            ii_star = idx[i_star]
            best_round_score.append(round_scores[i_star])

            if (len(self.ftr_) > self.min_features) and (best_round_score[-1] >= best_round_score[-2]):
                print('found best subset.')
                self.best_round_scores_ = np.array(best_round_score)[1:-1]
                self.score_ = best_round_score[-2]
                return
            elif (len(self.ftr_) >= self.max_features):
                print('reached max features.')
                self.best_round_scores_ = np.array(best_round_score)[1:-1]
                self.score_ = best_round_score[-2]
                return
            else:
                self.ftr_ += [ii_star]
                idx = np.setdiff1d(range(X.shape[1]), self.ftr_)
        return

    def transform(self, X, y=None):
        return X[:, self.ftr_]

##fit my data
fsmodel = ForwardSelection(SVR(epsilon=0, kernel="rbf", C = 5000, gamma = 0.01))

fsmodel.fit(X,y)
print("using Forward selection, with the same SVM model above")
print('features: {}'.format(fsmodel.ftr_))
