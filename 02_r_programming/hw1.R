# directory <- "C:/Users/Josh/Desktop/rprog_data_specdata/specdata/"
# df <- data.frame()
# files <- list.files(directory)
# for (i in files) {
#   a <- read.csv(paste(directory, '/', i, sep = ''))
#   df <- rbind(df, a)
# #df <- na.omit(df)
# }

#################################

pollutantmean <- function(directory, pollutant, id = 1:332) {
  df <- df[complete.cases(df),]
  mean(df[df$ID %in% id,][,pollutant])
}

complete <- function(directory, id = 1:332) { 
  obs_list <- vector()
  for (i in id) {
    print(i)
    obs_list <- c(obs_list, (sum(complete.cases(df[df$ID %in% i,]))))
  }
  df_nobs <- data.frame('id' = id, "nobs" = obs_list)
  head(df_nobs)
}


corr <- function(directory, threshold = 0) {
  corlist <- vector()
  for (id in 1:332) {
    #print(id)
    sub <- df[df$ID == id,]
    #print(sum(complete.cases(sub)))
    if (sum(complete.cases(sub)) > threshold) {
      sub <- sub[complete.cases(sub),]
      #print('winner')
      corlist <- c(corlist, cor(sub['nitrate'], sub['sulfate']))
    }
#corList <- c(corList, cor(df$['sulfate'], df$ID == id['sulfate']))
  }
  return(corlist)
}

#################################

#complete("C:/Users/Josh/Desktop/rprog_data_specdata/specdata/", 1:4)
# print(corr("C:/Users/Josh/Desktop/rprog_data_specdata/specdata/", 188))
# cr <- corr("C:/Users/Josh/Desktop/rprog_data_specdata/specdata/", 150)
# head(cr)
# pollutantmean("C:/Users/Josh/Desktop/rprog_data_specdata/specdata/", "sulfate", 1:10)
# pollutantmean("C:/Users/Josh/Desktop/rprog_data_specdata/specdata/", "nitrate", 70:72)
# pollutantmean("C:/Users/Josh/Desktop/rprog_data_specdata/specdata/", "sulfate", 34)
# pollutantmean("C:/Users/Josh/Desktop/rprog_data_specdata/specdata/", "nitrate")
# cc <- complete("C:/Users/Josh/Desktop/rprog_data_specdata/specdata/", c(6, 10, 20, 34, 100, 200, 310))
# print(cc$nobs)
# cc <- complete("specdata", 54)
# print(cc$nobs)
# 



