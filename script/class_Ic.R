####  Practice Exercises ####



#### Checking Cholesterol level using conditional logic ####
cholesterol <- 230
if(cholesterol>240){
  print("high cholesterol level detected!")
}


#### Blood Pressure Status ####
Systolic_bp <- 130
if(Systolic_bp<120){
  print("Blood pressure is normal")
}else{
  print("high blood pressure detected!")
}




#### Data type conversion using for loop ####
#loading datasets,storing in variables

patient_data<-read.csv(file.choose())
meta_data<-read.csv(file.choose())

#making copy of datasets to perform analysis without loosing the original data
patient_copy<-patient_data
meta_copy<-meta_data

#specfying columns that contain categorical data
patient_categorical_cols<-c("gender","diagnosis","smoker")
meta_categorical_cols<-c("height","gender")

for(col in patient_categorical_cols){
  patient_copy[[col]]<-as.factor(patient_copy[[col]])
}

for(col2 in meta_categorical_cols){
  meta_copy[[col2]]<-as.factor(meta_copy[[col2]])
}



#### factor to binary ####
binary_cols<-c("smoker","diagnosis")
 for(cols in binary_cols){
   if(cols=="smoker"){
   patient_copy[[cols]]<-ifelse(patient_copy[[cols]]=="Yes",1,0)}
   
   if(cols=="diagnosis"){
     patient_copy[[cols]]<-ifelse(patient_copy[[cols]]=="Cancer",1,0)
   }
 }



#### original vs modified datasets ####
#original patient data and modified data set
str(patient_data)
str(patient_copy)


#original meta data vs modified dataset
str(meta_data)
str(meta_copy)