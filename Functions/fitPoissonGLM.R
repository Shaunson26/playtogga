## Poisson many fitters
fitAllStatPoissonGLMs <- function(dataList){
  
  vars = c("G","A","CC","SCR","SOT","STO","AER","CLR","CS","INT","PS","SV","TW","DIS","GC","OG","YC","RC")

  playerStats.list = lapply(dataList, function(x) x[, vars])
  
  lapply(playerStats.list, function(ps) {
    playerFits = lapply(vars, function(x) fitPoissonGLM(ps[,x]))
    names(playerFits) = vars
    return(playerFits)}
  )
}


## Poisson fitter
fitPoissonGLM <- function(x){
  varRange = (ifelse((min(x) - 3) < 0, 0, min(x) - 3)):max(x + 3)
  glmOut = glm(x ~ 1, family = poisson)
  lamdaFit = coefficients(glmOut)
  outPcnt = dpois(varRange, exp(lamdaFit)) * 100
  names(outPcnt) = varRange
  return(list(glmOut = glmOut, lamdaFit = lamdaFit, outPcnt = outPcnt))
}