# Student Performance Prediction

### What factors are important in determining student outcomes?
What factors affect student success?  As a math instructor, I know that many elements shape student performance, and I'd love to be able to see how important various features are. In this project, I have used some feature selection techniques, not to be able to predict scores (this is quite hard!), but to understand some of the underlying factors that determine student success

### The Analysis
I chose to use Support Vector Regression with an rbf kernel.  I used cross validation to select appropriate hyperparameters (using 80% of the data as a training set), than tested it on my test set.  Unsurprisingly, using all 30 features created an overfit model, with a high approximation error.  I then used forward selection to select a smaller group of features, than refit the model.

### About the data
This data set is available from the UCI Machine Learning library [here](https://archive.ics.uci.edu/ml/datasets/student+performance).  This dataset consists of two CSV files, one for math scores and one for Portuguese language scores.  This data was all gathered in Portugal, and has several intermediate grade scores, along with 30 different features, showing demographics of the student and family.  I chose to focus exclusively on math scores.

### To run

#### With Make
To run the full analysis, clone the full repository, and from the root use the command:

```
make all
```

To delete all the files, use the command:

```
make clean
```

#### With Docker

To avoid any software dependency errors, feel free to download the docker image for this repo with

```
docker pull goldlist/student_performance_predictions
```

To run the full script, use
```
docker run --rm -it -v  C:\Path\to\cloned\repo:/home/student_performance_predictions goldlist/student_performance_predictions make -C 'home/student_performance_predictions' all
```

and to delete:

```
docker run --rm -it -v  C:\Path\to\cloned\repo:/home/student_performance_predictions goldlist/student_performance_predictions make -C 'home/student_performance_predictions' clean
```

Make sure to replace `C:\Path\to\cloned\repo` with the path to the cloned repo on your own computer.

### Software Dependencies
The analysis was performed with R and Python 3.xx.  

##### R packages used
* tidyverse
* cowplot

##### Python libraries used
* numpy
* pandas
* sklearn
* collections

##### Other tools
* make

### Citation:
P. Cortez and A. Silva. Using Data Mining to Predict Secondary School Student Performance. In A. Brito and J. Teixeira Eds., Proceedings of 5th FUture BUsiness TEChnology Conference (FUBUTEC 2008) pp. 5-12, Porto, Portugal, April, 2008, EUROSIS, ISBN 978-9077381-39-7.   [Online](http://www3.dsi.uminho.pt/pcortez/student.pdf) available.
