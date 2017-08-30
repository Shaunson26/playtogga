scalePoints <- function(data, cex_max = 3, cex_min = 0.5){
  ((cex_max-cex_min)*(data - min(data))/(max(data) - min(data)))+cex_min
}
