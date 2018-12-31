# Peer Assessment Project - Getting And Cleanning Data


The data set that this code book pertains to is located in the `SecT_Data.txt` file of this repository, containing space-separated values.

See the `README.md` file of this repository for background information on this data set.


# The original data was Tide by

1. Merging the training and the test sets to create one data set.
2. Extracting only the measurements on the mean and standard deviation for each measurement. 
3. Using descriptive activity names to name the activities in the data set.
4. Appropriately labeling the data set with descriptive activity names. 
5. Creating a second, independent tidy data set with the average of each variable for each activity and each subject.

# About variables in the run_analysis:   
   1. `train_x`,`train_y`,`tran_subject`and `test_x`,`test_y`,`test_subject` contains the data from
   the dowloaded files("./data/UCI HAR Dataset").
   2. `fullData` is the whole mess data that downloaded from the Website.
   3. `features` contains the correct names for the `x_data` dataset.
   4. `T_Data` is the tidy data before doing Step 5.
   5. `SecT_Data` is the tidy data after doing Step 5.