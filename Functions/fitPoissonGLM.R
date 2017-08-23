## Poisson many fitters
fitAllStatPoissonGLMs <- function(allPlayerList, varRange = 0:10){
  pWStat = lapply(allPlayerList, function(x) x[, -c(1:3)])
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