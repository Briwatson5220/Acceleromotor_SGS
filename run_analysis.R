#### do you need some sort of library call here?
library(reshape2)
library(dplyr)

# Download data
        ###setwd("E:/Users/Brian/Documents/My Data/Acceleromotor/Acceleromotor_SGS/data")
        # if(!file.exists("./data")){dir.create("./data")}
        # url <- "https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip"
        # download.file(url, "./data/dataset.zip", mode="wb", method="curl")
        # unzip("./data/dataset.zip", exdir = "./data")
        # unlink(url)

# Merge the training and the test sets to create one data set.
        
        # Measurements
        Measurement_train <- read.table("./UCI HAR Dataset/train/X_train.txt", header=F,sep="")
        Measurement_test <- read.table("./UCI HAR Dataset/test/X_test.txt", header=F,sep="")
        Measurement <- rbind(Measurement_train, Measurement_test)
        
        # Activity information
        Type_train <- read.table("./UCI HAR Dataset/train/Y_train.txt", header=F,sep="")
        Type_test <- read.table("./UCI HAR Dataset/test/Y_test.txt", header=F,sep="")
        Type <- rbind(Type_train, Type_test)
        # Load actual Activity names
        Activity_Labels <- read.table("./UCI HAR Dataset/activity_labels.txt", header=F,sep="")
        Type <- merge(Type, Activity_Labels)
        colnames(Type) <- c("ActivityID", "Activity")
        
        # Subjects
        Subject_train <- read.table("./UCI HAR Dataset/train/subject_train.txt", header=F,sep="")
        Subject_test <- read.table("./UCI HAR Dataset/test/subject_test.txt", header=F,sep="")
        Subject <- rbind(Subject_train, Subject_test)
        colnames(Subject) <- "SubjectID"

# Extract only the measurements on the mean and standard deviation for each measurement. 
        Features <- read.table("./UCI HAR Dataset/features.txt", header=F,sep="")
        Columns_std <- grep("[.]std[.]", make.names(Features[, 2]))
        Columns_mean <- grep("[.]mean[.]", make.names(Features[, 2]))
        Features_Columns <- c(Columns_mean, Columns_std) #list of all columns to include
        DataTemp <- Measurement[, Features_Columns] #just the std and mean 
        colnames(DataTemp) <- make.names(Features[Features_Columns, 2]) #correct the column names
        DataTemp <- cbind(Subject, Type, DataTemp) 
        
        # cleanup the data into 1 table with just the SujectID, Activity, Variable and Value columns
        Data <- melt(DataTemp, id=c("SubjectID", "Activity"), measure.vars=make.names(Features[Features_Columns, 2]))
        dat <- data.frame() # this is just an empty data frame for the rbind to add it to        
        for (i in 1:length(Features[Columns_std, 2])){
                dat[i, 1] <- make.names(Features[Columns_std, 2][i])
                tempDat <- unlist(strsplit(make.names(Features[Features_Columns, 2][i]), "\\."))
                dat[i, 2] <- tempDat[1]
                dat[i, 3] <- tempDat[2]
                dat[i, 4] <- tempDat[length(tempDat)]
        }
        names(dat)<-c("variable", "metric", "measure", "dimension")
        Data <- merge(Data, dat)       

# create a second, independent tidy data set with the average of each variable for each 
        # activity and each subject.
        Data_Tidy <- summarise(group_by(Data, SubjectID, Activity, variable), mean(value))