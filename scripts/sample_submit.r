library(tidyverse)


calendar <- read_csv("../data/calendar.csv")
sales <- read_csv("../data/sales_train_validation.csv")
sub <- read_csv("../data/sample_submission.csv")

calendar %>% 
  filter(!is.na(event_name_1)) %>% 
  View

my_sub %>% 
  as_tibble %>% 
  filter(str_detect(id, "evaluation"))

last28 <- sales %>%
  select(1892:1919) %>% 
  mutate(ave = rowMeans(.))

sales %>% 
  count(item_id)

# my_sub 
my_sub <- data.frame(id = as.character(sub$id))
my_cols <- paste0("F", 1:28)

for(i in 1:length(my_cols)){
  my_sub[, i + 1] <- rep(last28$ave, 2)
  colnames(my_sub)[i + 1] <- my_cols[i]
}
  

write_csv(my_sub, "../data/my_submit.csv")
