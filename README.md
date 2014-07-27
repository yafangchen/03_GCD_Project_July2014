# Steps to generate the scripts

## Step 1: Prepare test data
   * Read all measurement data, subject data and activity_type data into R seperately
   * Select only the measurement data for mean and std (total 18 columns)
   * Combine the subject data, activity_type data and the selected measurement data to create the test dataset (total 20 columns)

## Step 2: Prepare train data
   * Similar as the above step

## Step 3: Merge test and train datasets
   * Rename the first two columns for both datasets (1st col is subject data, 2nd col is activity_type data), so that I can use rbind() function later
   * Use rbind() function to combine the test and train datasets

## Step 4: Replace the activity label with descriptive activity names
   * Subset the dataset based on the activity_type, and add a new variable $Activity to the subset with value corresponding to the activity_type (ie. if activity_type == 1, the value of activity is "Walking")
   * Combine the six subsets to generate an updated dataset, which has 21 columns now
   * Replace the 2nd column (for activity_type) with the last column (new added, for activity), and delete the redundant last column, so that the updated dataset will only have 20 columns now.

## Step 5: Label the column names of the updated dataset with descriptive variable names

## Step 6: Create a tidy dataset to show the average of each measurement for each activity within each subject
   * Melt the dataset using the melt() function. Need to install the "reshape2" package, and load the "reshape2" library
   * Calculate the average of each measurement for each activity within each subject using the dcast() function, and store it in a dataframe "tidyData"
   * Write the dataframe "tidyData" into a text file using the write.table() function