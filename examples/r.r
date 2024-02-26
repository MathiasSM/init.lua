# Create a data frame
dataframe1 <- data.frame (
  Name = c("Juan", "Alcaraz", "Simantha"),
  Age = c(22, 15, 19),
  Vote = c(TRUE, FALSE, TRUE))

# write dataframe1 into file1 csv file
write.csv(dataframe1, "file1.csv")

# create another data frame
dataframe2 <- data.frame (
  Name = c("Yiruma", "Bach", "Ludovico"),
  Age = c(46, 89, 72)
)

# combine two data frames vertically 
updated <- rbind(dataframe1, dataframe2)
print(updated)
