                     ######    ****ASSIGNMENT-2****   ######

######  *****About the data set******  ######
#DEG mean differentialLY expressed genes
#The analysis produces two key measures for each gene:
# log2FoldChange (log2FC): 
# Indicates the magnitude and direction of change in gene expression. 
# Positive values suggest higher expression(up-regulated gene) in the experimental condition compared to control. 
# Negative values suggest lower expression (down-regulated gene). 
# The absolute value reflects the strength of the change.

# Adjusted p-value (padj): 
# Represents the statistical significance of the observed difference, corrected for multiple testing. 
# A smaller value indicates stronger evidence that the observed difference is not due to chance.




                   ###### Storing data in raw files folder ######
DEG_I_data<-read.csv(file.choose())
DEG_II_data<-read.csv(file.choose())
write.csv(DEG_I_data,"raw_data/DEGs_Data_1.csv")
write.csv(DEG_II_data,"raw_data/DEGs_Data_2.csv")

# Define input and output folders
input_dir <- "raw_data" 
output_dir <- "results"

# create output folder if not already exist
if(!dir.exists(output_dir)){dir.create(output_dir)}

# List which files to process
files_to_process <- c("DEGs_Data_1.csv","DEGs_Data_2.csv") 

# Prepare empty list to store results 
result_list <- list()

######  *Define function named classify_gene*  ######

classify_gene <- function(logFC, padj){           #passing two arguments to function classify_gene()
  if(logFC > 1 & padj < 0.05){                    
    return("Upregulated")                         #checking condition to find whether gene is up-regulated or not
  } else if(logFC < -1 & padj < 0.05){            # use of element-wise logical AND to check both conditions
    return("Downregulated")
  } else {
    return("Not Significant")
  }
}

###### *Applying for loop to process both datasets* ######
for (file_names in files_to_process) {
  cat("\nProcessing:", file_names, "\n")
  
  input_file_path <- file.path(input_dir, file_names)
  
  # Importing the dataset
  data <- read.csv(input_file_path, header = TRUE)          # header = TRUE : first row contain column names 
  cat("File imported. Checking for missing padj values...\n")
  
  ###### *Replacing missing padj values with 1* ######
  if("padj" %in% names(data)){                              #checking if padj column exists in data
    missing_count <- sum(is.na(data$padj))                  #calculating sum of all missing values in padj
    cat("Missing padj values:", missing_count, "\n")
    data$padj[is.na(data$padj)] <- 1                        #replacing all the NA values in padj by 1
  }
  
  ###### *Adding status column* ######
  # mapply :multivariate apply ;applies a function on a pair of values from two(in this case) vectors simultaneously
  data$status <- mapply(classify_gene, data$logFC, data$padj)  #new column "status" created 
  cat("Gene classification completed.\n")
  
  #Save results in R
  result_list[[file_names]] <- data 
  
  ###### *Saving results in Results folder in Rstudio* ######
  output_file_path <- file.path(output_dir, paste0("Processed_", file_names))
  write.csv(data, output_file_path, row.names = FALSE)
  cat("Results saved to:", output_file_path, "\n")
  
  ###### *Printing summary of status column* ######
  cat("Summary counts:\n")
  status_summary<- table(data$status)
  print(status_summary)
}

# Access processed results
results_1 <- result_list[[1]] 
results_2 <- result_list[[2]]
