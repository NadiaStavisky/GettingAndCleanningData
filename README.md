## GettingAndCleaningData
# README
Purpose of the project - demonstrate your ability to collect, work with, and clean a data set
Goal of the project   - prepare tidy data that can be used for later analysis

This repository contains the following files:

* _README.md_, this file, which provides an overview of the data set and how it was created.
* _tidy_data.txt_, which contains the data set.
* _CodeBook.md_, the code book, which describes the contents of the data set (data, variables and transformations used to generate the data).
* _run_analysis.R_, the R script that was used to create the tidy data set (_tidy_data.txt_)
* _codebook.rmd_, which modifies and updates the available _CodeBook.md_ with the data to indicate all the variables and summaries calculated, along with units, and any other relevant information

The data linked to from the course website represent data collected from the accelerometers from the Samsung Galaxy S smartphone. Source data was obtained from [Human Activity Recognition Using Smartphones Data Set.](http://archive.ics.uci.edu/ml/datasets/Human+Activity+Recognition+Using+Smartphones)


# Steps to reproduce this project
* Run R script run_analysis.R to create the data set. It retrieves the source data set and transforms it to produce the final data set by implementing the following steps (see the Code book for details, as well as the comments in the script itself):

* Download and unzip source data if it doesn't exist.
* Read data.
* Merge the training and the test sets to create one data set.
* Extract only the measurements on the mean and standard deviation for each measurement.
* Use descriptive activity names to name the activities in the data set.
* Transform data lables intoh descriptive variable names.
* Create a second, independent tidy set with the average of each variable for each activity and each subject.
* Write the data set to the tidy_data.txt file.

The tidy_data.txt in this repository was created by running the run_analysis.R script using R version 3.5.2 (2018-12-20) on Mac OS X 10.12.6 (16G1815).

This script requires the dplyr package (version 0.8.0.1 was used).






