# original source "https://archive.ics.uci.edu/ml/datasets/Individual+household+electric+power+consumption"


#  import .txt file contaning 2,075,259 observations & 9 variables
new_data <- read.table("household_power_consumption.txt", header = TRUE, sep = ";", colClasses = "character" )


split.Date <- split(new_data, new_data$Date) #  Split data frame by date & 
selected.Dates <- rbind(split.Date$`1/2/2007`, split.Date$`2/2/2007`)
selected.Dates$Date<- as.Date(selected.Dates$Date, "%d/%m/%Y") # convert column to date format & create date_tin column
date_time <- strptime(paste(selected.Dates$Date, selected.Dates$Time),"%Y-%m-%d %H:%M:%S")
Data_date.time <<- data.frame(date_time, selected.Dates) # create new data frame with date_time column

for(i in 4:10){
  Data_date.time[, i] <- as.numeric(Data_date.time[, i])
}

rm(new_data, split.Date, date_time, selected.Dates, i)

# Createfile
png(filename="plot3.png", width = 480, height = 480) 

# Save plot to file
plot(Data_date.time$date_time, Data_date.time$Sub_metering_1, 
     type="l", 
     xlab = "", 
     ylab = "Energy sub metering")
lines(Data_date.time$date_time, Data_date.time$Sub_metering_2, 
      type="l",
      col = "red")
lines(Data_date.time$date_time, Data_date.time$Sub_metering_3, 
      type="l", 
      col = "blue")
legend("topright", 
       legend = c("Sub_metering_1", "Sub_metering_2", "Sub_metering_3"), 
       col = c("black", "red", "blue"), 
       lty = "solid") 


# Close conection to png
dev.off() 