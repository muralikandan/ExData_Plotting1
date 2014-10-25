corr <- function(directory, threshold = 0) {
        source("complete.R")
        ## 'directory' is a character vector of length 1 indicating
        ## the location of the CSV files
        setwd(directory)
        file_list <- list.files(".")
        dataset = rbindlist(lapply( file_list, fread ))
        ##Change back work directory to parent folder
        setwd("../")
        ## 'threshold' is a numeric vector of length 1 indicating the
        ## number of completely observed observations (on all
        ## variables) required to compute the correlation between
        ## nitrate and sulfate; the default is 0
        complete_set<-complete("specdata")
        match_id <-complete_set$id[complete_set$nobs>threshold]
        corr_vect<-numeric()
        for (i in match_id){
                temp_subset <- subset(dataset,dataset$ID==i&!is.na(dataset$nitrate)&!is.na(dataset$sulfate),select=-Date)
                corr_vect<-c(corr_vect,cor(temp_subset$sulfate,temp_subset$nitrate))
        }
        ## Return a numeric vector of correlations
        corr_vect
}