#Read data from rows 65000 to 70000, which encompass 2007-02-01 and 2007-02-02, no Headers
df <- read.table("household_power_consumption.txt", skip = 65000, nrows = 5000, header = FALSE, sep = ";")
df <- df[df[,1] %in% c("1/2/2007","2/2/2007"),]

#Add headers from the file
vars <- unlist(strsplit(readLines("household_power_consumption.txt", n = 1), ";"))
names(df) <- vars

#Create column, datetime, that combines Date and Time
df$Date <- as.character(df$Date)
df$Time <- as.character(df$Time)
df$Datetime <- strptime(paste(df$Date,df$Time), format = "%d/%m/%Y %H:%M:%S")

#Create column, Weekday, column for week day
df$Weekday <- as.factor(weekdays(as.Date(df$Datetime)))


###########
# Plot 4  #
###########

#Export plots directly to plot4.png, script must end with dev.off()
png(filename = "plot4.png", width = 480, height = 480)

#Two-by-two grid of plots
par(mfrow =c(2,2))

#### Top-left ####

plot(df$Datetime, df$Global_active_power, type = "l",
     xlab = "",
     ylab = "Global Active Power",
     bg = "transparent")


#### Top-right ####

plot(df$Datetime, df$Voltage, type = "l",
     xlab = "datetime",
     ylab = "Voltage",
     bg = "transparent")

#### Bottom-left ####

#Sub metering 1
plot(df$Datetime, df$Sub_metering_1, type = "l", ylim = c(0, 38),
     xlab = "",
     ylab = "Energy sub metering")

#Sub metering 2
par(new = T)
plot(df$Datetime, df$Sub_metering_2, type = "l", ylim = c(0, 38), col = "red",
     xlab = "",
     ylab = "")

#Sub metering 3
par(new = T)
plot(df$Datetime, df$Sub_metering_3, type = "l", ylim = c(0, 38), col = "blue",
     xlab = "",
     ylab = "")

#Legend
legend("topright", lty = 1, y.intersp = 0.95, col = c("black", "red", "blue"), bty = "n", legend = c("Sub_metering_1", "Sub_metering_2", "Sub_metering_3"))


#### Bottom-right ####

plot(df$Datetime, df$Global_reactive_power, type = "l",
     xlab = "datetime",
     ylab = "Global_reactive_power",
     bg = "transparent")


#### Save as PNG ####
#dev.copy(png, file = "plot4.png", width = 480, height = 480)
dev.off()

