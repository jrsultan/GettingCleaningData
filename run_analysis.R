##PRE-WORK
#LOAD

library(dplyr)

#READ DATA -- assumes all files are as is in file directory, as extracted

features <- read.table("features.txt", col.names = c("n","functions"))
activities <- read.table("activity_labels.txt", col.names = c("code", "activity"))
subject_test <- read.table("test/subject_test.txt", col.names = "subject")
x_test <- read.table("test/X_test.txt", col.names = features$functions)
y_test <- read.table("test/y_test.txt", col.names = "code")
subject_train <- read.table("train/subject_train.txt", col.names = "subject")
x_train <- read.table("train/X_train.txt", col.names = features$functions)
y_train <- read.table("train/y_train.txt", col.names = "code")


##ACTUAL WORK

## 1. Merges the training and the test sets to create one data set.

Xdata <- rbind(x_train, x_test) #combine rows of X training and test data
Ydata <- rbind(y_train, y_test) #combine rows of Y training and test data
Subjectdata <- rbind(subject_train, subject_test) #combine rows of subject training and test data
Merged <- cbind(Subjectdata, Ydata, Xdata) #combine all together using columns

## 2. Extracts only the measurements on the mean and standard deviation for each measurement.

TidyData <- Merged %>% select(subject, code, contains("mean"), contains("std")) #only gets the mean and std measurements
View(TidyData) #to get initial view of data, as you can see code is still in number form

## 3. Uses descriptive activity names to name the activities in the data set

View(activities) #to see what activities are
TidyData$code <- activities[TidyData$code, 2] #to change the number code into its actual activity

## 4. Appropriately labels the data set with descriptive variable names.

names(TidyData)[2] = "activity" #since its not in code form anymore, change into activity
names(TidyData)<-gsub("Acc", "Accelerometer", names(TidyData))
names(TidyData)<-gsub("Gyro", "Gyroscope", names(TidyData))
names(TidyData)<-gsub("BodyBody", "Body", names(TidyData))
names(TidyData)<-gsub("Mag", "Magnitude", names(TidyData))
names(TidyData)<-gsub("^t", "Time", names(TidyData))
names(TidyData)<-gsub("^f", "Frequency", names(TidyData))
names(TidyData)<-gsub("tBody", "TimeBody", names(TidyData))
names(TidyData)<-gsub("-mean()", "Mean", names(TidyData), ignore.case = TRUE)
names(TidyData)<-gsub("-std()", "STD", names(TidyData), ignore.case = TRUE)
names(TidyData)<-gsub("-freq()", "Frequency", names(TidyData), ignore.case = TRUE)
names(TidyData)<-gsub("angle", "Angle", names(TidyData))
names(TidyData)<-gsub("gravity", "Gravity", names(TidyData))
#change abbreviations into actual name, for better understanding

## 5. From the data set in step 4, creates a second, independent tidy data set with the average of each variable for each activity and each subject.

FinalData <- TidyData %>%
  group_by(subject, activity) %>% ##group by subject and activity
  summarise_all(list(mean)) #gets mean of all variables

View(FinalData) #view final data

write.table(FinalData, "FinalData.txt", row.name=FALSE) #outputs data into FinalData text into directory
