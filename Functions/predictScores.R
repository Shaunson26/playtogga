mostLikelyScores <- function(myFit){
  do.call(rbind,
          lapply(myFit, function(y) {
            do.call(c, 
                    lapply(y, function(x){
                      maxPcnts = which(x$outPcnt == max(x$outPcnt))
                      mean(as.numeric(names(x$outPcnt[maxPcnts])))
                    }))
          })
  )
}

quantitleScores <- function(myFit, quantileThreshold = 50){
  do.call(rbind,
          lapply(myFit, function(y) {
            do.call(c, 
                    lapply(y, function(x){
                      cumsumPcnts = cumsum(x$outPcnt)
                      as.numeric(names(x$outPcnt[cumsumPcnts > quantileThreshold][1]))
                    }))
          })
  )
}