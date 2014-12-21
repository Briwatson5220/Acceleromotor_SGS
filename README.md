Acceleromotor_SGS
=================

Acceleromotor data from a [Samsung Galaxy S smartphone](https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip) 
Collected by  [Jorge L. Reyes-Ortiz, Davide Anguita, Alessandro Ghio, Luca Oneto](http://archive.ics.uci.edu/ml/datasets/Human+Activity+Recognition+Using+Smartphones)

From the study description... "The experiments have been carried out with a group of 30 volunteers within an age bracket of 19-48 years. 
Each person performed six activities (WALKING, WALKING_UPSTAIRS, WALKING_DOWNSTAIRS, SITTING, STANDING, LAYING) wearing a smartphone 
(Samsung Galaxy S II) on the waist. Using its embedded accelerometer and gyroscope, we captured 3-axial linear acceleration and 3-axial 
angular velocity at a constant rate of 50Hz."

Raw data inlcudes 561 time and frequency domain variables for each measurement. The attached script extracts just the Mean and Standard Deviation 
information and summarizes that for each Subject and Activity. Extract [Acceleromotor data](https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip) to working directory

This script loads the Measurement, Activity and Subject information. Activity labels are added to give descriptive names. Each measure name is reviewed
and only ones including "mean" or "std" are included in the final data set. 

You can read the summary data set into R using the following code... (Thanks [David Hood](https://class.coursera.org/getdata-016/forum/thread?thread_id=50)!)

    data <- read.table(file_path, header = TRUE) 
    View(data)


