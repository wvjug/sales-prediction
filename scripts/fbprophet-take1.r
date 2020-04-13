library(tidyverse)
library(prophet)

calendar <- read_csv("../data/calendar.csv")
sales <- read_csv("../data/sales_train_validation.csv")
sub <- read_csv("../data/sample_submission.csv")
my_sub_old <- read_csv("../data/my_submit.csv")

DATES <- calendar %>% select(d, date)
ITEM <- sales[1, 7:1919] %>% 
  gather 


get_item <- function(.row_n){
  item <- ITEM
  item$value <- as.numeric(sales[.row_n, 7:1919])
  item <- item %>%
    left_join(DATES, by = c("key" = "d")) %>% 
    select(ds = date, y = value)
  return(item)
}

get_item(5)

predict_item <- function(.row_n){
  item <- get_item(.row_n)
  m <- prophet(item)
  future <- make_future_dataframe(m, periods = 28)
  forecast <- predict(m, future)
  return(forecast[(n-27):n, "yhat"])
  
}
  
predict_item(5)

predict_items <- function(.row_ns){
  my_names <- sales$id[.row_ns]
  names(.row_ns) <- my_names
  # return(my_ids)
  predictions_28days <- map_dfc(.row_ns, predict_item) %>% 
    t %>% 
    as.data.frame %>%
    rownames_to_column("id")
  colnames(predictions_28days)[2:29] <- paste0("F", 1:28)
  return(predictions_28days)
}

predict_items(1:2)


pred_validation 
pred_evaluation <- pred_validation

sub$id[1:10]
sales$id[1:10]
sub$id[30491: 30500]
write_csv(my_sub, "../data/my_submit.csv")

