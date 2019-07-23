# ICMGP Workshop Part I
# Caitlin Eger

# Loading and Managing data

#where is your working directory?
getwd()

#setting the working directory manually:
#"Files" >> three dots >> navigate to folder >> "Open"
#encoding the working directory: (can copy line and paste to top of file)
setwd("E:/ICMGP2019")

#Reading in .csv data
#read.csv() in base R
Hon <- read.csv("data/All_Honnedaga_water_chemistry.csv")
head(Hon)
str(Hon) #this is a data.frame, note classes of each variable

# .xlsx
install.packages("readxl") #this package contains functions that reliably read excel files
library(readxl) #load the package into the workspace
#warning message ?
R.Version() #this is the version we are running

Hon_xl1 <- read_excel("data/All_Honnedaga_water_chemistry.xlsx")
head(Hon_xl1)
str(Hon_xl1) #this is a tibble "tbl", and a "data.frame"
dplyr::glimpse(Hon_xl1) #"tidyverse" version of str
#note that the NAs read in as CHARACTERS!!!

Hon_xl2 <- read_excel("data/All_Honnedaga_water_chemistry.xlsx",na = "NA")
head(Hon_xl2)
table(Hon_xl1$X)
str(Hon_xl2)
rm(Hon_xl1) #removes the object from the workspace

names(Hon) == names(Hon_xl)

#compare classes of objects
class1 <- lapply(Hon, class) %>% unlist
class2 <- lapply(Hon_xl, class) %>% unlist
which(class1 == class2)

#


# group of .csvs
#read in files into a data frame
files <- dir()[grep("csv$", dir())] #makes a list of .csv files in the working directory
stack <- lapply(files, read.csv, stringsAsFactors = F, skip = 1)
FLP2018 <- rbindlist(stack)

# Url or a group of urls
dat <- read.csv("CR1000XSeries_Master_Table20190708.csv", skip = 4, header = F, stringsAsFactors = F)
names <- read.csv("CR1000XSeries_Master_Table20190708.csv", skip = 1, header = F, nrow = 1, stringsAsFactors = F)
units <- read.csv("CR1000XSeries_Master_Table20190708.csv", skip = 2, header = F, nrow = 1, stringsAsFactors = F)


# API
# NWIS and RNOAA


# Cleaning and joining
shack <- read.csv("data/Fluoroprobe_Data_2018/Data_05_01_18.csv")
str(shack)


# Labelling dataframe
# Skipping rows, NAs, NANs etc
# Strings as factors = F
# Subsets (base)
# Filtering (dplayr)
# Arrange, summarize, mutate, select, filter (5 core functions)
# Merge or full, anti, semi, right, left join
# Selector vector, k <- which(logical)
