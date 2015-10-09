
# original source "https://archive.ics.uci.edu/ml/datasets/Individual+household+electric+power+consumption"


## logical test to see if data frame exists, if not creates one
if(!exists("Data_date.time")) { 
  #  import .txt file contaning 2,075,259 observations & 9 variables
  new_data <- read.table("household_power_consumption.txt", header = TRUE, sep = ";", colClasses = "character" )
  
  #  Subset data frame by date, recomdind, & create date_time column
  require(dplyr)
  Dates_1 <- filter(new_data, new_data$Date == "1/2/2007")
  Dates_2 <- filter(new_data, new_data$Date == "2/2/2007")
  selected.Dates <- rbind(Dates_1, Dates_2)
  selected.Dates$Date<- as.Date(selected.Dates$Date, "%d/%m/%Y") 
  date_time <- strptime(paste(selected.Dates$Date, selected.Dates$Time),"%Y-%m-%d %H:%M:%S")
  
  # Create new data frame with date_time column
  par(bg = NA) 
  Data_date.time <<- data.frame(date_time, selected.Dates)
  for(i in 4:10){
    Data_date.time[, i] <- as.numeric(Data_date.time[, i])
  }
  
  rm(new_data, Dates_1, Dates_2, date_time, selected.Dates, i)
}




## saves plot to  png file
par(bg = NA) 
png(filename="plot2.png", width = 480, height = 480) 
plot(Data_date.time$date_time, Data_date.time$Global_active_power, 
     type="l", 
     xlab = "", 
     ylab ="Global Active Power (kilowatts)")

dev.off() 

