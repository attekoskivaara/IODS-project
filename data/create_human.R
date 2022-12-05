# Atte Koskivaara
# Load exercise set 5 (dimension reduction )
install.packages(c('readr', 'stringr', 'dplyr'))

library(readr)
library(stringr)
library(dplyr)

data <- read.table("https://raw.githubusercontent.com/KimmoVehkalahti/Helsinki-Open-Data-Science/master/datasets/human1.txt", sep = ",", header = TRUE)

write_csv(data, 'human.csv')


### Load dataset


human <- read.csv("human.csv")

# check column names

names(human)
dim(human)
str(human)


# The dataset has 19 variables. The variables are different indicators regarding countrywise development. The overall measurement represents human development index (HDI)

# manipulate GNI column data
str_replace(human$GNI, pattern=",", replace ="")


# columns to keep
keep <- c("Country", "Edu2.FM", "Labo.FM", "Life.Exp", "Edu.Exp", "GNI", "Mat.Mor", "Ado.Birth", "Parli.F")

human <- select(data, one_of(keep))

# filter missing values
human <- filter(human, complete.cases(human))

dim(human)

#deselect last seven rows (not countries)
last <- nrow(human) - 7

human_ <- human[1:last,]

#define rownames
rownames(human_) <- human_$Country

# save data
write_csv(human_, 'human.csv')
