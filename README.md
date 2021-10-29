# CourseProjectHumanActivityRecognitionUsingSmartphone
Coursera  "Getting and Cleaning Data" course project

================================================================================
title: "Human Activity Recognition Using Smartphones Project""
author: "Ng Tian Chyr""
date:   "29/10/2021""
================================================================================

I am given data from an experiment that have been carried out with a group of 30 volunteers within an age bracket of 19-48 years. Each person performed six activities (WALKING, WALKING_UPSTAIRS, WALKING_DOWNSTAIRS, SITTING, STANDING, LAYING) wearing a smartphone (Samsung Galaxy S II) on the waist. Using its embedded accelerometer and gyroscope, 3-axial linear acceleration and 3-axial angular velocity are captured at a constant rate of 50Hz.

I am asked to read the HAR data. To complete the task, I need to understand the structure of the input data file.
The most simplest way to read the files is to use read.table(). The files that are read in are:
- X_train.txt
- X_test.txt
- y_train.txt
- y_test.txt
- subject_train.txt
- subject_test.txt
- activity_labels.txt
- features.txt

Firstly, training dataset and test dataset are combined together for X, y and subject respectively.
Then for the combined dataset X, I use grep() function to identify all the columns containing 'mean' or 'std'.

A few more steps are done to rename each column of newly created X (with selected columns), y and subject dataset.
Final step is to merge the three dataset together into one big dataset.

After tidy up the data, the data is grouped by subject followed by activity. 
The function summarize_each() is used to get the average of each variable by subject and activity.


The files related to the analysis are as followed:
================================================================================

- README.md: Documentation explaining the project and how to use files contained in the repository.
- run_analysis.R: R script from reading in the data to producing its result.
- Code book: Documentation of each variable.

