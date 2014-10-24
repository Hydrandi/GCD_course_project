## Script for course project of class "Getting and cleaning data"
# 

## pre-processing
# load packages
library(dplyr)

# set work directory
setwd("/Users/Hydrandi/Documents/Studium/Coursera/R/GetCleanData_Project")

# check whether raw data already downloaded, if not download and unzip
if (!file.exists("UCI HAR Dataset")) {
        # download file from specified URL and unzip
        URL <- "https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip"
        download.file(URL, destfile="./project_data.zip", method="curl")
        unzip("project_data.zip", overwrite=TRUE)
}

# load separate text files with read.table
y_train <- read.table("UCI HAR Dataset/train/y_train.txt")
X_train <- read.table("UCI HAR Dataset/train/X_train.txt")
sub_train <- read.table("UCI HAR Dataset/train/subject_train.txt")
y_test <- read.table("UCI HAR Dataset/test/y_test.txt")
sub_test <- read.table("UCI HAR Dataset/test/subject_test.txt")
X_test <- read.table("UCI HAR Dataset/test/X_test.txt")
feat <- read.table("UCI HAR Dataset/features.txt")
actlab <- read.table("UCI HAR Dataset/activity_labels.txt")
feat1 <- as.character(feat$V2)

## cleaning and merging data
# merge datasets > bind test and train datasets by row
train <- cbind(sub_train, y_train, X_train)
test <- cbind(sub_test, y_test, X_test)
tot <- rbind(train, test)

# assign meaning full variable names to merged dataset
colnames(tot) <- c("subject", "act_label", feat1)

## subset dataset by selecting only mean and std variables
# create vector from names(tot) containing only mean and std variable names
vars <- grep("mean|std", names(tot), value=TRUE, ignore.case=TRUE)

# create new dataset "total" with mean&std, label and subjectID variables
total <- cbind(tot[,1:2], tot[, vars])

## assign descriptive label names to activity labels 1-6
total$act_label <- factor(total$act_label, levels=1:6, labels=actlab$V2)

## give meaningful names to variable names

# erase special characters and make all characters lower case
names(total) <- gsub("[[:punct:]]", "", names(total))
names(total) <- tolower(names(total))
names(total) <- gsub("acc", "acceleration", names(total))
names(total) <- gsub("gyro", "gyroscope", names(total))
names(total) <- gsub("bodybody", "body", names(total))
names(total) <- gsub("mag", "magnitude", names(total))

# make second dataset with average of each variable for each activity and each subject

final <- total %>% group_by(subject, actlabel) %>% summarise_each(funs(mean))
write.table(final, file ="final.txt", row.names=FALSE)
