# Coursera: Getting and Cleaning Data Project

## Introduction

This script obtains a wearable data from an Internet source and compute the average of the mean and standard deviation of the accelerometer and gyroscope data of each subject participated in the experiment and the activity they did.

## Requirement

This script makes use of `dplyr`

## Usage

Run run_analysis.R in R or RStudio 

    source("run_analysis.R")
    tidy_dataset <- run_analysis()

## What this script does?

The script will automatically download the wearable data from the [link](https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip) and perform the following processes:
1. Download the data and save it in `data` folder of the working directory. (The script will automatically detects a Windows OS or OS X or Linux and use the appropriate method to download the data)
2. Extract the data to the current working directory. If the data exist, it will use the existing data instead of downloading a new one.
3. Merge the training and test features data into one and extract only mean and standard deviation of each measurement.
4. Merge the training and test label data and convert the numeric labels to friendly string label based on the label mapping as provided.
5. Merge the training and test subject label data
6. Combine the features, label and subject data set into one combined data set
6. Calculate the mean of each mean and standard deviation of each measurement of each subject and activity

### Processing Methodology

The original data set is download and extracted in the working directory and the following files are used:
- ./UCI HAR Dataset/features.txt
- ./UCI HAR Dataset/activity_labels.txt
- ./UCI HAR Dataset/test/X_test.txt
- ./UCI HAR Dataset/train/X_train.txt
- ./UCI HAR Dataset/test/y_test.txt
- ./UCI HAR Dataset/train/y_train.txt
- ./UCI HAR Dataset/test/subject_test.txt
- ./UCI HAR Dataset/train/subject_train.txt

./UCI HAR Dataset/features.txt is used for the column indexing and naming

./UCI HAR Dataset/activity_labels.txt is used for activity label mapping from a numerical value to a string description of that activity. Activity labels are mapped as follows:
1. Walking
2. Walking Upstairs
3. Walking Downstairs
4. Sitting
5. Standing
6. Laying

./UCI HAR Dataset/test/X_test.txt and ./UCI HAR Dataset/train/X_train.txt are combined to form a consolidated features data set and then only the mean() and std() columns are selected. The "()" have been stripped off from the column naming for ease of use.

./UCI HAR Dataset/test/y_test.txt and ./UCI HAR Dataset/train/y_train.txt are combined to form a conslidated label data set that has its values mapped with the activity labels and combined with the features data set

./UCI HAR Dataset/test/subject_test.txt and ./UCI HAR Dataset/train/subject_train.txt are also combined and combined with the features data set