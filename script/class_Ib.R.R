#saving the original file in variable "original_data"
original_data <- read.csv(file.choose())
View(original_data)

# str() function utilized to view structure/datatype of different columns in the dataframe
str(original_data)

#gender,smoking status,diagnosis being categorical data should be converted from character to factor
original_data$gender_fact    <- as.factor(original_data$gender)
original_data$diagnosis_fact <- as.factor(original_data$diagnosis)
original_data$smoker_fact <-as.factor(original_data$smoker)

#printing the newly created variables with categorical data
original_data$diagnosis_fact
original_data$gender_fact
original_data$smoker_fact

#adding binary smoking status yes=1,no=0
original_data$smoker_binary_variable <- ifelse(original_data$smoker == "Yes", 1, 0)

#final dataset
str(original_data)

#saving the dataset in csv format in clean_data sub-folder
write.csv(original_data, "clean_data/patient_info_clean.csv")
