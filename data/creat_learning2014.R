# Atte Koskivaara, 10.11.2022
#Second exercise week

# Lataa datasetti
lrn14 <- read.table("http://www.helsinki.fi/~kvehkala/JYTmooc/JYTOPKYS3-data.txt", sep="\t", header=TRUE)
 
# Rakenne ja dimensiot
str(lrn14)
dim(lrn14)

colnames(lrn14)
# create analysis dataset
# combine deep, stra and surf
deep_questions <- c("D03", "D11", "D19", "D27", "D07", "D14", "D22", "D30","D06",  "D15", "D23", "D31")
lrn14$deep <- rowMeans(lrn14[, deep_questions])
surface_questions <- c("SU02","SU10","SU18","SU26", "SU05","SU13","SU21","SU29","SU08","SU16","SU24","SU32")
lrn14$surf <- rowMeans(lrn14[, surface_questions])
strategic_questions <- c("ST01","ST09","ST17","ST25","ST04","ST12","ST20","ST28")
lrn14$stra <- rowMeans(lrn14[, strategic_questions])

# create selection and analysis dataset
selection <- c("gender", "Age", "Attitude", "deep", "stra", "surf", "Points")
analysis <- select(lrn14, one_of(selection))

# filter out if Points is 0
analysis <- filter(analysis, analysis$Points > 0)
dim(analysis)

# save csv to folder data
write_csv(analysis, "Learning2014.csv")


