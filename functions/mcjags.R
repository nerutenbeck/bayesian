mcjags<-function(jags.fit){
  require(reshape2)
  out<-melt(jags.fit$BUGSoutput$sims.array,varnames=c('sample','chain','parameter'))
  out$chain<-as.factor(out$chain)
  return(out)
}

mcjagsplot<-function(mcjags,parameter){ # Requires a dataframe in the mcjags format (as above)
  require(ggplot2)
  plot<-ggplot(mcjags[mcjags$parameter==parameter,],
               aes(x=value,color=chain,group=chain))+
    geom_density()+
    xlab(parameter)
  return(plot)
}
