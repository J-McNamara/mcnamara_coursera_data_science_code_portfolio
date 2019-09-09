folder <- "C:/Users/Josh/Desktop/rprog_data_specdata/specdata/"
file_list <- list.files(folder)
df <- read.csv(paste(folder, file_list[1], sep=''))
dim(df)
df <- rbind(df, read.csv(paste(folder, file_list[2], sep='')))
dim(df)