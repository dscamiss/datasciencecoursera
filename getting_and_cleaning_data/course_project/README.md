# Course project for "Getting and Cleaning Data"

This is a submission for the final project of the Coursera course "Getting and Cleaning Data."

The submission consists of:

* `README.md     :` This file
* `run_analysis.R:` An R script which performs certain operations on the "Human Activity Recognition Using Smartphones Dataset (Version 1.0)" (description below)
* `CodeBook.md   :` A "code book" describing the input-output behavior of `run_analysis.R`
* `tidy.txt      :` The output of `run_analysis.R`

The script `run_analysis.R` performs the following operations:
* Load feature names from `features.txt` and transform (via a series of text substitutions) into human-readable descriptions
* Reduce feature names to those pertaining to means or standard deviations (these feature names contain "mean()" and "std()", respectively)
* Load activity labels from `activity_labels.txt` and beautify (lowercase, no underscores)
* Load training data (subjects, inputs, and outputs) from `subject_train.txt`, `X_train.txt`, and `Y_train.txt`, respectively
* Load test data (subjects, inputs, and outputs) from `subject_test.txt`, `X_test.txt`, and `Y_test.txt`, respectively
* Merge training and test data together
* Add subject and activity columns to merged data
* For each (subject, activity) pair, compute the mean of each feature
* Write out the mean data to `tidy.txt`
