# Codebook for Getting and Cleaning Data Class Project

## Information about the data
From the source website (http://archive.ics.uci.edu/ml/datasets/Human+Activity+Recognition+Using+Smartphones):
>Data Set Information:
>
>The experiments have been carried out with a group of 30 volunteers within an age bracket of 19-48 years. Each person performed six activities (WALKING, WALKING_UPSTAIRS, WALKING_DOWNSTAIRS, SITTING, STANDING, LAYING) wearing a smartphone (Samsung Galaxy S II) on the waist. Using its embedded accelerometer and gyroscope, we captured 3-axial linear acceleration and 3-axial angular velocity at a constant rate of 50Hz. The experiments have been video-recorded to label the data manually. The obtained dataset has been randomly partitioned into two sets, where 70% of the volunteers was selected for generating the training data and 30% the test data.
>
>The sensor signals (accelerometer and gyroscope) were pre-processed by applying noise filters and then sampled in fixed-width sliding windows of 2.56 sec and 50% overlap (128 readings/window). The sensor acceleration signal, which has gravitational and body motion components, was separated using a Butterworth low-pass filter into body acceleration and gravity. The gravitational force is assumed to have only low frequency components, therefore a filter with 0.3 Hz cutoff frequency was used. From each window, a vector of features was obtained by calculating variables from the time and frequency domain.

## Information about variables
The initial data include 561 features related to the data gathered from the accelerometers and gyroscopes in the smartphones. Most features were metrics of the raw measurements, such as mean values, interquartile ranges, or standard deviations. From these 561 features, I extracted the mean values and standard deviations associated with each set of signals. The decision was made to only acquire the variables identified with the -mean() or -std() prefixes. While there were five variables related to the mean angle() variables, as these were treated differently by the data owners, they were excluded from the analysis.

In addition, each observation included the activity name and the subject number that was associated with the particular observation. Including these two variables to the mean() and std() variables, the working dataset looked at 68 variables.

## Transformation of the data
Initially, the data were seperated into training samples and test samples, and the subject identifiers and associated activities were in separate text files. Once each file was loaded into separate data frames in R using the read.table() function, the rbind() function was used to combine the test and training datasets. Finally, the cbind() function was used to combine the observations with the associated subject numbers and activities. At this stage, the variable names were replaced by more human-readable variable names using the gsub() function, although, due to the length of most variable names, camelCase was used to help with readability.

Finally, the melt() function was used to associate each subject and activity with the relevant measurements, and the dcast() function was used to summarize the data by calculating the means of each variable as grouped by subject and activity.

The resulting data frame from the dcast() function was then written to a text file using the write.table() function, with the row.names parameter set to FALSE.

## Requirements
The run_analysis.R script requires that it be run from the working directory and that the data files are placed in appropriate subdirectories. Due to the use of the melt() and dcast() functions, the reshape2 package should be installed.