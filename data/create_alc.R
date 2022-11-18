# Atte Koskivaara 17.11.2022
## Assignment 3. This time assignments are about logistic regression. This script is for data wrangling.

math <- read.table("student-mat.csv", sep = ";", header = TRUE)
por <- read.table("student-por.csv", sep = ";", header = TRUE)


## structure and dimension of data sets
dim(math)
str(math)
dim(por)
str(por)

# columns not to use as identifier
free_cols <- c("failures", "paid", "absences", "G1", "G2", "G3")

# set columns to be joined
join_cols <- setdiff(colnames(por), free_cols)

# join columns
math_por <- inner_join(math, por, by = join_cols, suffix = c(".math", ".por"))

dim(math_por)


alc <- select(math_por, all_of(join_cols))
dim(alc)
# remove dublicates
# for every column name not used for joining...
for(col_name in free_cols) {
  # select two columns from 'math_por' with the same original name
  two_cols <- select(math_por, starts_with(col_name))
  # select the first column vector of those two columns
  first_col <- select(two_cols, 1)[[1]]
  
  # then, enter the if-else structure!
  # if that first column vector is numeric...
  if(is.numeric(first_col)) {
    # take a rounded average of each row of the two columns and
    # add the resulting vector to the alc data frame
    alc[col_name] <- round(rowMeans(two_cols))
  } else { # else (if the first column vector was not numeric)...
    # add the first column vector to the alc data frame
    alc[col_name] <- first_col
  }
}


#dimensions of the data set
dim(alc)

# calculate weed day and weekend average alcohol consuption and add column
alc <- mutate(alc, alc_use = (Dalc + Walc) / 2)

# add a new column "high use" if consuption value is greater than 2
alc <- mutate(alc, high_use = alc_use > 2)

# glimpsing the data
glimpse(math_por)
glimpse(alc)


# write csv
write_csv(alc, 'alc.csv')
glimpse(alc)
