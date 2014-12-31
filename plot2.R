# Set the working directory to the directory where the data is saved
setwd("/roger/Coursera//Exploratory_Analysis/Exploratory_Data_Analysis_Course_Project2/exdata-data-NEI_data/")

# Read in data
NEI <- readRDS("summarySCC_PM25.rds")
SCC <- readRDS("Source_Classification_Code.rds")

# Subsetting the data for Baltimore and split the data into groups by year as
# well as calculating the total emissions
Baltimore <- subset(NEI, NEI$fips == "24510")
BaltimoreEmission <- aggregate(Emissions ~ year, Baltimore, sum)

# Plotting the barplots to compare the total Emissions in Baltimore across years
png("plot2.png", height = 500, width = 600)
barplot(BaltimoreEmission$Emissions/10^3, names.arg = BaltimoreEmission$year, axis.lty = 1,
        col = c("Black", "Red", "Blue", "Green"), 
        main = "Total PM2.5 emission from all sources in Baltimore",
        xlab = "Years", ylab = "Total PM2.5 Emissions (1000 tonnes)")
dev.off()