# Load Reshape2 package
library(reshape2)

# Load data into R
Xtest <- read.table("data/test/X_test.txt")
Xtrain <- read.table("data/train/X_train.txt")
Ytest <- read.table("data/test/Y_test.txt")
Ytrain <- read.table("data/train/Y_train.txt")
subjecttest <- read.table("data/test/subject_test.txt")
subjecttrain <- read.table("data/train/subject_train.txt")
names <- read.table("data/features.txt")
labels <- read.table("data/activity_labels.txt")

# Tidy activity labels
labels$V2 <- tolower(labels$V2)
labels$V2 <- gsub("_", "", labels$V2)

# Merge test and training sets
X <- rbind(Xtest, Xtrain)
y <- rbind(Ytest, Ytrain)
subject <- rbind(subjecttest, subjecttrain)

# Rename Columns
colnames(X) <- names$V2
colnames(subject) <- "subjectnumber"
colnames(y) <- "activity"

# Select only mean and standard deviation measurements
index <- grepl("-mean[^A-Z]", names$V2) | grepl("std()", names$V2, ignore.case =TRUE)
Xfinal <- X[,index]

# Convert subject number and activity to a factor variable
subject$subjectnumber <- as.factor(subject$subjectnumber)
y$activity <- as.factor(y$activity)
levels(y$activity) <- labels$V2

# Merge features and labels
final <- cbind(Xfinal, subject, y)

# Provide descriptive variable names using camel case due to length of variable names
colnames(final) <- gsub("tBodyAcc-mean\\(\\)", "meanBodyAccelerometerSignals", colnames(final))
colnames(final) <- gsub("tBodyAcc-std\\(\\)", "standardDeviationOfBodyAccelerometerSignals", colnames(final))
colnames(final) <- gsub("tGravityAcc-std\\(\\)", "standardDeviationOfGravityAccelerometerSignals", colnames(final))
colnames(final) <- gsub("tGravityAcc-mean\\(\\)", "meanGravityAccelerometerSignals", colnames(final))
colnames(final) <- gsub("tBodyAccJerk-mean\\(\\)", "meanBodyAccelerometerJerkSignals", colnames(final))
colnames(final) <- gsub("tBodyAccJerk-std\\(\\)", "standardDeviationOfBodyAccelerometerJerkSignals", colnames(final))
colnames(final) <- gsub("tBodyGyro-std\\(\\)", "standardDeviationOfBodyGyroscopeSignals", colnames(final))
colnames(final) <- gsub("tBodyGyro-mean\\(\\)", "meanBodyGyroscopeSignals", colnames(final))
colnames(final) <- gsub("tBodyAccMag-mean\\(\\)", "meanMagnitudeofBodyAccelerometerSignals", colnames(final))
colnames(final) <- gsub("tBodyAccMag-std\\(\\)", "standardDeviationOfMagnitudeofBodyAccelerometerSignals", colnames(final))
colnames(final) <- gsub("tGravityAccMag-std\\(\\)", "standardDeviationOfMagnitudeofGravityAccelerometerSignals", colnames(final))
colnames(final) <- gsub("tGravityAccMag-mean\\(\\)", "meanMagnitudeofGravityAccelerometerSignals", colnames(final))
colnames(final) <- gsub("tBodyAccJerkMag-mean\\(\\)", "meanMagnitudeofBodyAccelerometerJerkSignals", colnames(final))
colnames(final) <- gsub("tBodyAccJerkMag-std\\(\\)", "standardDeviationOfMagnitudeofBodyAccelerometerJerkSignals", colnames(final))
colnames(final) <- gsub("tBodyGyroMag-mean\\(\\)", "meanMagnitudeofBodyGyroscopeSignals", colnames(final))
colnames(final) <- gsub("tBodyGyroMag-std\\(\\)", "standardDeviationOfMagnitudeofBodyGyroscopeSignals", colnames(final))
colnames(final) <- gsub("tBodyGyroJerk-mean\\(\\)", "meanBodyGyroscopeJerkSignals", colnames(final))
colnames(final) <- gsub("tBodyGyroJerk-std\\(\\)", "standardDeviationOfBodyGyroscopeJerkSignals", colnames(final))
colnames(final) <- gsub("tBodyGyroJerkMag-std\\(\\)", "standardDeviationOfMagnitudeofBodyGyroscopeJerkSignals", colnames(final))
colnames(final) <- gsub("tBodyGyroJerkMag-mean\\(\\)", "meanMagnitudeofBodyGyroscopeJerkSignals", colnames(final))
colnames(final) <- gsub("fBodyAcc-mean\\(\\)", "meanBodyAccelerometerSignalFrequencies", colnames(final))
colnames(final) <- gsub("fBodyAcc-std\\(\\)", "standardDeviationOfBodyAccelerometerSignalFrequencies", colnames(final))
colnames(final) <- gsub("fBodyAccJerk-mean\\(\\)", "meanBodyAccelerometerJerkSignalFrequencies", colnames(final))
colnames(final) <- gsub("fBodyAccJerk-std\\(\\)", "standardDeviationOfBodyAccelerometerJerkSignalFrequencies", colnames(final))
colnames(final) <- gsub("fBodyGyro-std\\(\\)", "standardDeviationOfBodyGyroscopeSignalFrequencies", colnames(final))
colnames(final) <- gsub("fBodyGyro-mean\\(\\)", "meanBodyGyroscopeSignalFrequencies", colnames(final))
colnames(final) <- gsub("fBodyAccMag-mean\\(\\)", "meanMagnitudeofBodyAccelerometerSignalFrequencies", colnames(final))
colnames(final) <- gsub("fBodyAccMag-std\\(\\)", "standardDeviationOfMagnitudeofBodyAccelerometerSignalFrequencies", colnames(final))
colnames(final) <- gsub("fBodyBodyAccJerkMag-mean\\(\\)", "meanMagnitudeofBodyAccelerometerJerkSignalFrequencies", colnames(final))
colnames(final) <- gsub("fBodyBodyAccJerkMag-std\\(\\)", "standardDeviationOfMagnitudeofBodyAccelerometerJerkSignalFrequencies", colnames(final))
colnames(final) <- gsub("fBodyBodyGyroMag-mean\\(\\)", "meanMagnitudeofBodyGyroscopeSignalFrequencies", colnames(final))
colnames(final) <- gsub("fBodyBodyGyroMag-std\\(\\)", "standardDeviationOfMagnitudeofBodyGyroscopeSignalFrequencies", colnames(final))
colnames(final) <- gsub("fBodyBodyGyroJerkMag-std\\(\\)", "standardDeviationOfMagnitudeofBodyGyroscopeJerkSignalFrequencies", colnames(final))
colnames(final) <- gsub("fBodyBodyGyroJerkMag-mean\\(\\)", "meanMagnitudeofBodyGyroscopeJerkSignalFrequencies", colnames(final))
colnames(final) <- gsub("-X", "AlongTheXAxis", colnames(final))
colnames(final) <- gsub("-Y", "AlongTheYAxis", colnames(final))
colnames(final) <- gsub("-Z", "AlongTheZAxis", colnames(final))

# Reshape data to find the means
finalmelt <- melt(final, id.vars=c("subjectnumber", "activity"))
answer <- dcast(finalmelt, activity + subjectnumber ~ ..., mean)

# Write final data to file
write.table(answer,"project.txt", row.names=FALSE)