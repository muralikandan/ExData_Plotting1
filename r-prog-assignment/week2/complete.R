complete <- function(directory, id = 1:332) {
        ## 'directory' is a character vector of length 1 indicating
        ## the location of the CSV files\
        
        require(data.table)
        ##set working directory to files folder
        setwd(directory)
        file_list <- list.files(".")
        dataset = rbindlist(lapply( file_list, fread ))
        ##Change back work directory to parent folder
        setwd("../")
        complete_set <-data.frame()
        ## 'id' is an integer vector indicating the monitor ID numbers
        ## to be used
        
        for (i in id){
                ## 'pollutant' is a character vector of length 1 indicating
                ## the name of the pollutant for which we will calculate the
                ## mean; either "sulfate" or "nitrate".
                temp_subset <- subset(dataset,dataset$ID==i&!is.na(dataset$nitrate)&!is.na(dataset$sulfate),select=-Date)
                temp_complete_set <- data.frame(id=i,nobs=nrow(temp_subset))
                if(length(complete_set)>0){
                        complete_set<-rbind(complete_set, temp_complete_set)
                }
                else{
                        complete_set<- temp_complete_set
                        
                }
                rm(temp_subset)
                rm(temp_complete_set)
        }
        complete_set
        
        ## Return a data frame of the form:
        ## id nobs
        ## 1  117
        ## 2  1041
        ## ...
        ## where 'id' is the monitor ID number and 'nobs' is the
        ## number of complete cases
}
        