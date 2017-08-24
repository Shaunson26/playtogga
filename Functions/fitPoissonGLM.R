## Poisson many fitters
fitAllStatPoissonGLMs <- function(allPlayerList, varRange = 0:10){
  vars = c("G","A","CC","SCR","SOT","STO","AER","CLR","CS","INT","PS","SV","TW","DIS","GC","OG","YC","RC")
  pWStat = lapply(allPlayerList, function(x) x[, vars])
  lapply(pWStat, function(x) lapply(x, function(y) fitPoissonGLM(y, varRange)))
}


## Poisson fitter
fitPoissonGLM <- function(x, varRange = 0:5){
  glmOut = glm(x ~ 1, family = poisson)
  lamdaFit = coefficients(glmOut)
  outPcnt = dpois(varRange, exp(lamdaFit)) * 100
  names(outPcnt) = varRange
  return(list(glmOut = glmOut, lamdaFit = lamdaFit, outPcnt = outPcnt))
}