# load ggplot2 package
library(ggplot2)

# Set the working directory to the directory where the data is saved
setwd("/roger/Coursera//Exploratory_Analysis/Exploratory_Data_Analysis_Course_Project2/exdata-data-NEI_data/")

# Read in data
NEI <- readRDS("summarySCC_PM25.rds")
SCC <- readRDS("Source_Classification_Code.rds")

# Subsetting the data for Baltimore, split the data into groups by year and type
# of sources of emissions, and calcuate the total emissions for each type in
# each year
Baltimore <- subset(NEI, NEI$fips == "24510")
BaltimoreEmission <- aggregate(Emissions ~ year + type, Baltimore, sum)

# Plotting the barplots for total emissions from each type in Baltimore across 
# years
png("plot3.png", height = 500, width = 600)
ggplot(BaltimoreEmission, aes(x = factor(year), y = Emissions, fill = type)) +
    geom_bar(stat = "identity") + facet_grid(. ~ type) + xlab("Years") + 
    ylab("Total PM2.5 Emissions (Tonnes)") + 
    ggtitle("Total PM2.5 Emissions by Source Type, Baltimore, 1999-2008") + 
    scale_fill_discrete(name = "Emission\nSource Type")
dev.off()


