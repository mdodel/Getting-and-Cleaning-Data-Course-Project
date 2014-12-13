Getting-and-Cleaning-Data-Course-Project
========================================

Course Project for Getting and Cleaning Data (getdata-016)

This files contains information on the Course Project task and how to use run_analysis.R script to succesfully crete a Tidy Data from the  data collected from the accelerometers from the Samsung Galaxy S smartphone: https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip  (data provider by instructors).

The run_analysis.R file includes all the code to download, read, data wrangling and data writing through any computer with RStudio Version 0.98.1087 & R Version 3.1.2 for Windows 8.1

Before sourcing run_analysis.R, beware that the Script uses reshape, plyr & data.table library that you should install before running it.

Finally, two output files are generated: 
1-"fulldatared.txt" (a pre-tidy version of the database, that includes all the Mean and SD variables, with proper labeling of the activities variable, and an attempt to improve general variable labels.
2-"tidy_data_set.txt" A tidy dataset based in the previous one (but independent) with the average of each variable for each activity and each subject

The instruction to read this dataset is in the last line of the run_analysis.R script.
