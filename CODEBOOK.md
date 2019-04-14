The run_analysis.R file contains a script that follows the instructions:

1. Merges the training and the test sets to create one data set.
Xdata - from training and test of X
Ydata - from training and test of Y
Subjectdata - from subject training and test data

2. Extracts only the measurements on the mean and standard deviation for each measurement.
using the select function to find the word "mean" and "std" inside the variable names

3. Uses descriptive activity names to name the activities in the data set
since current table of TidyData is in code form, changes the values to the actual activities it is referring to

4. Appropriately labels the data set with descriptive variable names.
since current variable names are not understandable, makes names more descriptive instead of abbreviated versions

5. From the data set in step 4, creates a second, independent tidy data set with the average of each variable for each activity and each subject.
final table is now grouped by subject and activity, and outputs the mean
also, writes a file for the FinalData


Note:
Pre-work includes loading library(dplyr), as well as reading the necessary tables
**assumes current working directory already has extracted files
