## Load packages needed
library(dplyr)
library(tidyr)

## read in text file format data using read.table()
X_test<-read.table("./UCI HAR Dataset/test/X_test.txt")
y_test<-read.table("./UCI HAR Dataset/test/y_test.txt")
X_train<-read.table("./UCI HAR Dataset/train/X_train.txt")
y_train<-read.table("./UCI HAR Dataset/train/y_train.txt")
subjectTest<-read.table("./UCI HAR Dataset/test/subject_test.txt")
subjectTrain<-read.table("./UCI HAR Dataset/train/subject_train.txt")
activityLabels<-read.table("./UCI HAR Dataset/activity_labels.txt")
header<-read.table("./UCI HAR Dataset/features.txt")

## combine X_test with X_train, y_test with y_train, and subjectTest with subjectTrain
X_all<-rbind(X_train,X_test)
y_all<-rbind(y_train,y_test)
subject_all<-rbind(subjectTrain,subjectTest)

## create a dataset for X with selected columns (measurements with mean and std)
X_all_selected<-select(X_all,grep("[Mm]ean|[Ss]td",header$V2))
#X_all_selected<-select(X_all,c(1:6,41:46,81:86,121:126,161:166,201:202,214:215,227:228,240:241,253:254,266:271,294:296,345:350,373:375,424:429,452:454,503:504,513,516:517,526,529:530,539,542:543,552,555:561))

## filter header dataset with word 'mean' or 'std' and give header name to the new dataset
header_selected<-filter(header,grepl("[Mm]ean|[Ss]td",header$V2))
header_selected<- header_selected %>%
        select(V2) %>%
        rename(headernames=V2)
header_selected<-data.frame(headernames=gsub("[-|(|)|,]",".",header_selected$headernames))
header_selected<-data.frame(headernames=gsub("^t","time",header_selected$headernames))
header_selected<-data.frame(headernames=gsub("\\.t",".time",header_selected$headernames))
header_selected<-gsub("^f","freq",header_selected$headernames)

## Rename headers for each dataset
y_all<-rename(y_all,activitycode=V1)
subject_all<-rename(subject_all,subject=V1)
colnames(X_all_selected)<-header_selected
activityLabels<-rename(activityLabels,activitycode=V1,activity=V2)

## combined 3 different datasets (subject, X & y dataset) into a dataset
combined<-cbind(subject_all,y_all,X_all_selected)

## label activity names
combined<-merge(activityLabels,combined,by.x="activitycode",by.y="activitycode",all=TRUE)
combined<-select(combined,-activitycode)

## create a new dataset from 'combined' data which is group by subject and activity
combined_group<-group_by(combined,subject,activity)

## Average of each variables group by subject and activity
result<-summarize_each(combined_group,mean)
#result2<-summarise_all(combined_group,mean)

## Export result in txt format
write.table(result,file="./HARresult.txt",row.names = FALSE)
