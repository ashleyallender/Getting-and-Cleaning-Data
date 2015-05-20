# Getting and Cleaning Data | Code Book

## Data Set Information
The experiments have been carried out with a group of 30 volunteers within an age bracket of 19-48 years. Each person performed six activities (WALKING, WALKING_UPSTAIRS, WALKING_DOWNSTAIRS, SITTING, STANDING, LAYING) wearing a smartphone (Samsung Galaxy S II) on the waist. Using its embedded accelerometer and gyroscope, we captured 3-axial linear acceleration and 3-axial angular velocity at a constant rate of 50Hz. The experiments have been video-recorded to label the data manually. The obtained dataset has been randomly partitioned into two sets, where 70% of the volunteers was selected for generating the training data and 30% the test data. 


### Attribute Information:
The sensor signals (accelerometer and gyroscope) were pre-processed by applying noise filters and then sampled in fixed-width sliding windows of 2.56 sec and 50% overlap (128 readings/window). The sensor acceleration signal, which has gravitational and body motion components, was separated using a Butterworth low-pass filter into body acceleration and gravity. The gravitational force is assumed to have only low frequency components, therefore a filter with 0.3 Hz cutoff frequency was used. From each window, a vector of features was obtained by calculating variables from the time and frequency domain.

For each record in the dataset it is provided: 
- Triaxial acceleration from the accelerometer (total acceleration) and the estimated body acceleration
- Triaxial Angular velocity from the gyroscope
- A 561-feature vector with time and frequency domain variables
- Its activity label
- An identifier of the subject who carried out the experiment


## Data Set Variables
- xTrain, yTrain, xTest, yTest, subjectTrain and subjectTest contain data from UCI HAR Dataset files
- traindata, testData and tblData merge previous datasets to further analysis
- colNames stores column names for tblData
- logV stores logical vector to extract mean and standard deviation measurements from tblData
- tblData_xactivity subset of tblData without activity column
- tidyData subset of tblData with 


- A similar approach is taken with activity names through the activities variable.
- all_data merges x_data, y_data and subject_data in a big dataset.
- Finally, averages_data contains the relevant averages which will be later stored in a .txt file. ddply() from the 
