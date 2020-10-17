library(dplyr)
## Get the data, but only if we haven't already!
if (!dir.exists(".data")) {dir.create(".data")}
setwd(".data")
if (!file.exists("dataset.zip")) {
download.file("https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip",
              "dataset.zip")}

## Unzip our data, but again we only want to do this if we haven't done it before:
if (!dir.exists("UCI HAR Dataset")) {unzip("dataset.zip")}

## Let's merge our testing and training data into one combo dataset

## First we load all the data:
feats <- read.table("UCI HAR Dataset/features.txt")
actlbls <- read.table("UCI HAR Dataset/activity_labels.txt")
tst.subject <- read.table("UCI HAR Dataset/test/subject_test.txt")
tst.x <- read.table("UCI HAR Dataset/test/X_test.txt")
tst.y <- read.table("UCI HAR Dataset/test/y_test.txt")
trn.subject <- read.table("UCI HAR Dataset/train/subject_train.txt")
trn.x <- read.table("UCI HAR Dataset/train/X_train.txt")
trn.y <- read.table("UCI HAR Dataset/train/y_train.txt")

## Then we merge test and train into single dataframes
subject <- rbind(tst.subject,trn.subject)
x <- rbind(tst.x,trn.x)
y <- rbind(tst.y,trn.y)

## Let's rename the columns in x with our feature names

## Get the feature names as a vector
xcolnames <- as.vector(feats[, 2])

## loop through each value and apply it as the column name for x
i <- 0
while (i < length(xcolnames)) {
  i <- i + 1
  colnames(x)[i] <- xcolnames[i]
}
## Now we'll replace the activity codes in y with the human-readable label

## Get the activity labels as a vector
labels <- as.vector(actlbls[,2])

## loop through each row of y replacing the activity code with its label
i <- 0
while (i < nrow(y)) {
  i <- i + 1
  k <- as.numeric(y[i,])
  y[i,] <- labels[k]
}

## Finally combine it all to one nicely-labeled dataset
ourdata <- cbind(subject,y,x)
colnames(ourdata)[1] <- "Subject"
colnames(ourdata)[2] <- "Activity"

## Drop everything that isn't a mean or sd
ourdata <- ourdata[,c(1,2,grep("mean|std", colnames(ourdata)))]

## Summarize our data by subject and activity, giving the mean of each measure
ourdata <- ourdata %>%
  group_by(Subject, Activity) %>%
  summarize_each(funs(mean))

## Output our summarized data
write.table(ourdata,file="../Analyzed_Data.txt")
