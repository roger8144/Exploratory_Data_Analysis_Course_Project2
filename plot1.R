# Set the working directory to the directory where the data is saved
setwd("/roger/Coursera//Exploratory_Analysis/Exploratory_Data_Analysis_Course_Project2/exdata-data-NEI_data/")

# Read in data
NEI <- readRDS("summarySCC_PM25.rds")
SCC <- readRDS("Source_Classification_Code.rds")

# Split Emissions data into groups by year and calculate the total Emissions for
# each year
totalEmission <- aggregate(Emissions ~ year, NEI, sum)

# Plotting the barplots to compare the total Emissions across years
png("plot1.png", height = 500, width = 600)
barplot(totalEmission$Emissions/10^3, names.arg = totalEmission$year, axis.lty = 1,
        col = c("Black", "Red", "Blue", "Green"), 
        main = "Total PM2.5 emission from all sources for four years",
        xlab = "Years", ylab = "Total PM2.5 Emissions (1000 tonnes)")
dev.off()