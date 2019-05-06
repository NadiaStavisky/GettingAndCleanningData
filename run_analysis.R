#set working directory
getwd()
#setwd("C:/Users/nstavisky/OneDrive - Facebook/Study/R")
setwd("/Users/Nadya/Nanodegree/Data Science Specialization/Getting and Cleaning Data")

#checking for and creating directories
if(!file.exists("project4")){
  dir.create("project4")
}

#download file
# First install downloader from CRAN
install.packages("downloader")
library(downloader)
library(dplyr)

#load zip file from web
url <- "https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip"
download("https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip",
         dest = "./project4/Dataset.zip", mode = "wb")
unzip("./project4/Dataset.zip", exdir = "./project4")

#read and load featuresName, activityName & lables
list.files("./project4")
path <- ("./project4/UCI HAR Dataset")
activityLabels <- read.table(file.path(path, "activity_labels.txt"), col.names = c("activityLable","activityName"))
features <- read.table(file.path(path, "features.txt"), col.names = c("featureNum","featuresName"), as.is = TRUE)

#read and load training data
trainSubjects <- read.table(file.path(path, "train", "subject_train.txt"))
trainSet <- read.table(file.path(path, "train", "X_train.txt"))
trainLabels <- read.table(file.path(path, "train", "Y_train.txt"))
#read and load test data
testSubjects <- read.table(file.path(path, "test", "subject_test.txt"))
testSet <- read.table(file.path(path, "test", "X_test.txt"))
testLabels <- read.table(file.path(path, "test", "Y_test.txt"))
#merge training and test data
activityData <- rbind(cbind(testLabels, testSubjects, testSet),
                      cbind(trainLabels, trainSubjects, trainSet))
colnames(activityData) <- c("activity", "subject", features[,2])
#extract only mean and sdt for the measurments
#find columns to keep
colToKeep <- grepl("activity|subject|mean|std", colnames(activityData))
#update activity data set, with selected columns
activityData <- activityData[,colToKeep]
#Uses descriptive activity names to name the activities in the data set => replace activityLable with activityName
activityData$activity <- factor(activityData$activity, levels = activityLabels[,1], labels = activityLabels[,2])
#Appropriately labels the data set with descriptive variable names.
activityDataColumns <- colnames(activityData)
activityDataColumns <- gsub("^f", "frequency", activityDataColumns)
activityDataColumns <- gsub("^t", "time", activityDataColumns)
activityDataColumns <- gsub("Acc", "Acceleration", activityDataColumns)
activityDataColumns <- gsub("Gyro", "AngularVelocity", activityDataColumns)
activityDataColumns <- gsub("Mag", "Magnitude", activityDataColumns)
activityDataColumns <- gsub("Freq", "Frequency", activityDataColumns)
activityDataColumns <- gsub("mean", "Mean", activityDataColumns)
activityDataColumns <- gsub("std", "StandardDeviation", activityDataColumns)
#remove duplicated BodyBody
activityDataColumns <- gsub("BodyBody", "Body", activityDataColumns)
#remove ()
activityDataColumns <- gsub("\\()", "", activityDataColumns)

colnames(activityData) <- activityDataColumns

# group by subject and activity and summarise using mean
activityDataMeans <- activityData %>% 
  group_by(subject, activity) %>%
  summarise_each(list(mean))


# output to file "tidy_data.txt"
write.table(activityDataMeans, "./project4/tidy_data.txt")
