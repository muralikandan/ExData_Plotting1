pollutantmean <- function(directory, pollutant, id = 1:332) {
        ## 'directory' is a character vector of length 1 indicating
        ## the location of the CSV files
        require(data.table)
        parent_folder<-getwd()
        change_folder <-parent_folder %in% grep(directory, parent_folder, value = TRUE)
        if(!change_folder)
                setwd(directory)
        file_list <- list.files(".")
        dataset = rbindlist(lapply( file_list, fread ))
        pollutant_set <-data.frame()
        ## 'id' is an integer vector indicating the monitor ID numbers
        ## to be used        
        for (i in id){
                ## 'pollutant' is a character vector of length 1 indicating
                ## the name of the pollutant for which we will calculate the
                ## mean; either "sulfate" or "nitrate".
                temp_subset <- subset(dataset,dataset$ID==i,select=pollutant)
                if(length(pollutant_set)>0)
                        pollutant_set<-rbind(pollutant_set, temp_subset)
                else
                        pollutant_set<- temp_subset 
                rm(temp_subset)
        }
        ## Return the mean of the pollutant across all monitors list
        ## in the 'id' vector (ignoring NA values)
        pollutant_mean <- colMeans(pollutant_set,na.rm=TRUE,dims=1)
        pollutant_vect<-as.vector(pollutant_mean)
        pollutant_vect
}

