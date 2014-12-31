# load ggplot2 package
library(ggplot2)

# Set the working directory to the directory where the data is saved
setwd("/roger/Coursera//Exploratory_Analysis/Exploratory_Data_Analysis_Course_Project2/exdata-data-NEI_data/")

# Read in data
NEI <- readRDS("summarySCC_PM25.rds")
SCC <- readRDS("Source_Classification_Code.rds")

# Subsetting SCC for Emissions Source from Motor Vehicle 
MV_SCC <- SCC$SCC[grep("Motor", SCC$SCC.Level.Three)]

# Subsetting all Emissions data in Baltimore related to Motor Vehicles 
Baltimore_MV <- subset(NEI, NEI$fips == "24510" & NEI$SCC %in% MV_SCC)
Baltimore_EMV <- aggregate(Emissions ~ year, Baltimore_MV, sum)

# Plotting the total emissions from Motor Vehicle-related Sources in Baltimore
# in four years
png("plot5.png", height = 500, width = 600)
ggplot(Baltimore_EMV, aes(x = factor(year), y = Emissions)) + 
    geom_bar(stat = "identity", fill = c("Black", "Red", "Blue", "Green")) + xlab("Years") + 
    ylab("Total PM2.5 Emissions (Tonnes)") + 
    ggtitle("Total PM2.5 Emissions by \n Motor Vehicle-realted Sources in Baltimore, 1999-2008") + 
    theme(axis.title.x = element_text(face = "bold", size = 16), 
          axis.title.y = element_text(face = "bold", size = 16),
          plot.title = element_text(face = "bold", size = 16),
          axis.text.x = element_text(face = "bold", size = 12),
          axis.text.y = element_text(face = "bold", size = 12))
dev.off()



