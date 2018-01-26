##Makefile

##Amy Goldlist, January 2017

### this completes my anaylsis, by taking the raw data, cleaning it
### splitting it into a test set and training set,
### visualizing the training
### Does more

##run top to bottom
all: results/test_predictions.csv results/training_predictions.csv results/images/grid.png results/parameters.txt results/foward_select_param.txt results/final_fit.txt

## clean data, create training file
results/grades_train.csv: data/student-mat.csv src/clean_data.R
	Rscript src/clean_data.R

##clean data, create test file
results/grades_test.csv: data/student-mat.csv src/clean_data.R
	Rscript src/clean_data.R

##recode training data
results/grades_train_num.csv: results/grades_train.csv src/recode_data.R
	Rscript src/recode_data.R results/grades_train.csv results/grades_train_num.csv

##recode test data
results/grades_test_num.csv: results/grades_test.csv src/recode_data.R
	Rscript src/recode_data.R results/grades_test.csv results/grades_test_num.csv

results/images/grid.png: results/grades_train.csv src/data_viz.R
	Rscript src/data_viz.R

##run SVR with python, save output
results/training_predictions.csv: results/grades_train_num.csv results/grades_test_num.csv src/fit_and_test.py
	python src/fit_and_test.py > results/parameters.txt

results/test_predictions.csv: results/grades_train_num.csv results/grades_test_num.csv src/fit_and_test.py
	python src/fit_and_test.py > results/parameters.txt

results/parameters.txt: results results/grades_train_num.csv results/grades_test_num.csv src/regression.py
	python src/regression.py > results/parameters.txt

results/foward_select_param.txt: results results/grades_train_num.csv src/forward_select.py
	python src/forward_select.py > results/foward_select_param.txt

results/final_fit.txt: src/fit_and_test.py results results/grades_train_num.csv results/grades_test_num.csv
	python src/fit_and_test.py > results/final_fit.txt


##create report
#doc/baby_report.md: src/baby_report.Rmd results/summary_stats.csv results/test_values.txt #results/images/baby_histogram.png
#	Rscript -e "ezknitr::ezknit('src/baby_report.Rmd', out_dir = 'doc')"

##create make_graph
#results/images/make_graph.png: Makefile
	#make -Bnd | make2graph | dot -Tpng -o results/images/make_graph.png


##clean up intermediate files.
clean:
	rm -f results/grades_train.csv
	rm -f results/grades_test.csv
	rm -f results/grades_train_num.csv
	rm -f results/grades_test_num.csv
	rm -f results/images/make_graph.png
	rm -f results/images/grid.png
	rm -f results/test_predictions.csv
	rm -f results/training_predictions.csv
