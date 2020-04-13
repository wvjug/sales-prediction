library(forecast)
library(reshape2)

hobby <- ts(hobsub_l[,3], start = 1, frequency = 365)
hob.pred <- ses(hobby, h=28)
autoplot(hob.pred)

exp_smooth <- function(data, nafter) {
  x <- ts(data, start = 1, frequency = 365)
  pred <- ses(x, h=nafter)
  return [pred]
}
