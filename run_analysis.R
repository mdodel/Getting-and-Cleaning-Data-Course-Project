#Instructions of the project:
##The purpose of this project is to demonstrate your ability to collect, work with, and clean a data set.
##The goal is to prepare tidy data that can be used for later analysis. You will be graded by your 
##peers on a series of yes/no questions related to the project. You will be required to submit: 
##1) a tidy data set as described below, 
##2) a link to a Github repository with your script for performing the analysis, and 
##3) a code book that describes the variables, the data, and any transformations or 
##work that you performed to clean up the data called CodeBook.md. 
##You should also include a README.md in the repo with your scripts. 
##This repo explains how all of the scripts work and how they are connected.  

##You should create one R script called run_analysis.R that does the following. 
##1)Merges the training and the test sets to create one data set.
##2)Extracts only the measurements on the mean and standard deviation for each measurement. 
##3)Uses descriptive activity names to name the activities in the data set
##4)Appropriately labels the data set with descriptive variable names. 
##5)From the data set in step 4, creates a second, independent tidy data set 
##with the average of each variable for each activity and each subject.

#General guidelines taken from: https://class.coursera.org/getdata-016/forum/thread?thread_id=50 & https://class.coursera.org/getdata-016/forum/thread?thread_id=100

#Step1: Merges the training and the test sets to create one data set.

setwd ("C:/Users/Mati Dodel/Dropbox/Coursera/Data Science Specialization/Getting and Cleaning Data")
getwd ()


fileUrl <- "https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip"
download.file(fileUrl, destfile="./samsungaxisdata.zip")
dateDownloaded <- date()

unzip("./samsungaxisdata.zip")

install.packages("reshape") ##To change variable names
library(reshape)

train <- read.table("./UCI HAR Dataset/train/X_train.txt")
dim(train) # Rows=7352,Col=561
names(train)

trainlabel <- read.table("./UCI HAR Dataset/train/y_train.txt")
names(trainlabel)
table(trainlabel$V1)
trainlabel <- rename(trainlabel, c(V1="activities")) ##To dont have 2 variables named the same
table(trainlabel$activities)
dim(trainlabel) # Rows=7352,Col=1


trainsubject <- read.table("./UCI HAR Dataset/train/subject_train.txt")
names(trainsubject)
table(trainsubject$V1)
trainsubject <- rename(trainsubject, c(V1="subject")) ##To dont have 2 variables named the same
table(trainsubject$subject)
dim(trainsubject) # Rows=7352,Col=1

trainfull <- cbind(train, trainlabel, trainsubject) #bind all train tables
dim(trainfull) # Rows=7352,Col=563
names(trainfull)

test <- read.table("./UCI HAR Dataset/test/X_test.txt")
dim(test) # Rows=2947,Col=561
names(test)

testlabel <- read.table("./UCI HAR Dataset/test/y_test.txt")
names(testlabel)
table(testlabel$V1)
testlabel <- rename(testlabel, c(V1="activities")) ##To dont have 2 variables named the same
table(testlabel$activities)
dim(testlabel) # Rows=2947,Col=1


testsubject <- read.table("./UCI HAR Dataset/test/subject_test.txt")
names(testsubject)
table(testsubject$V1)
testsubject <- rename(testsubject, c(V1="subject")) ##To dont have 2 variables named the same
table(testsubject$subject)
dim(testsubject) # Rows=2947,Col=1

testfull <- cbind(test, testlabel, testsubject) #bind all train tables
dim(testfull) # Rows=2947,Col=563
names(testfull)


fulldata <- rbind(trainfull, testfull)
dim(fulldata) # Rows=10299, Col=563



#Step2: Extracts only the measurements on the mean and standard deviation for each measurement.

variables <- read.table("./UCI HAR Dataset/features.txt")
dim(variables)  # Rows=561, Col=2
names(variables)
str(variables)
head(variables)
tail(variables$V2)
levels(variables$V2)

#to preserve subject and activities variables in the subsetting vector
variables$V2 <- factor(variables$V2, levels = c(levels(variables$V2), "activities"))
variables$V2 <- factor(variables$V2, levels = c(levels(variables$V2), "subject"))
variables2 <-rbind(variables, c(562,"activities"))
variables2 <-rbind(variables2, c(563,"subject"))
str(variables2)


fulldatared <- fulldata [, grepl('mean\\(|std\\(|subject|activities', variables2$V2)]
dim(fulldatared) # 10299*68
names(fulldatared)
names(fulldata)


#Step3: Uses descriptive activity names to name the activities in the data set

library(plyr)

str(fulldatared$activities)

fulldatared$activities<- as.factor(fulldatared$activities)

fulldatared$activities<-mapvalues(fulldatared$activities, from = c("1", "2", "3","4","5","6"), to = c("walking", "walkingupstairs", "walkingdownstairs", "sitting", "standing", "laying"))

table(fulldatared$activities)



#Step4: Appropriately labels the data set with descriptive variable names. 

names(fulldatared)<-grep('mean\\(|std\\(|subject|activities', variables2$V2, value=T) #Put the proper variable names



names(fulldatared) <- gsub("\\(\\)|-", "", names(fulldatared)) # remove "()" and "-"
names(fulldatared) <- gsub("mean", "Mean", names(fulldatared)) # # Even if it is not advisible to use caps in variable labels, as naming is to confuse, capitalize M
names(fulldatared) <- gsub("std", "StD", names(fulldatared)) # Even if it is not advisible to use caps in variable labels, as naming is to confuse, capitalize S&D

##The variable labels are complex and most of the Info is in the Codebook!

names(fulldatared)

write.table(fulldatared, "fulldatared.txt")

#Step5: From the data set in step 4, creates a second, independent tidy data set 
##with the average of each variable for each activity and each subject.

#Source: http://stackoverflow.com/questions/24151602/calculating-multiple-aggregations-with-lapply-sd-in-data-table-r-package
#and http://stackoverflow.com/questions/8508482/what-does-sd-stand-for-in-data-table-in-r, plus ?data.table

library(data.table)
fulldatared1 <- data.table(fulldatared)
finalfulldata<- fulldatared1[, lapply(.SD, mean), by=c("activities", "subject")]

str(fulldatared)
str(finalfulldata) #Rows=180, Columns=68; dont trust the .SD method as its new for me, but 30 subjects*6 activities=180, so its seems reasonable

write.table(finalfulldata, "tidy_data_set.txt", row.name=FALSE )

##Read the file

TidyDataSet<-read.table("./tidy_data_set.txt")
