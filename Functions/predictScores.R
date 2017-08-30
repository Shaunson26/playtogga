mostLikelyStatistics <- function(myFit){
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
