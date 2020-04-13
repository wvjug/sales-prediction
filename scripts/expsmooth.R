library(forecast)
library(reshape2)

# Prepare hobbies_1_008_CA_1 subset
stv <- read.csv("data/sales_train_validation.csv")
hobsub <- filter(sub, id == "HOBBIES_1_008_CA_1_validation")
hobsub_l <- melt(data=hobsub, id.vars = 'id')

# Train on test set
hobby <- ts(hobsub_l[1:1530,3], start = 1, frequency = 365)
hob.pred <- ses(hobby, h=383)

# Look at accuracy to test data
hobby_test <- hobsub_l[1531:1913,3]
accuracy(hob.pred, hobby_test)

exp_smooth <- function(data, nafter) {
  x <- ts(data, start = 1, frequency = 365)
  pred <- ses(x, h=nafter)
  return [pred]
}

