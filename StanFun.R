### Fun with STAN! ###


basic.mod <- ' 

  data {
    int <lower = 0> N; // number of trials
    int <lower = 0, upper = 1> y[N]; // each y takes an integer value of 0 or 1
  }

  parameters {
    real <lower = 0, upper = 1> theta; // theta is a real number between 0 and 1
  }

  model {
    theta ~ beta(2, 2); // prior distribution of theta
    y ~ bernoulli(theta); // likelihood function
  }
'
basic.data <- list(N = 100,
                   y = c(rep(1, 90), rep(0, 10)))

basic.fit <- stan(model_code = basic.mod, data = basic.data, iter = 1000, chains = 3)
print(basic.fit) # lp__ is the cumulative log posterior. See Chapter 7 of BDA3


binom.model <- '
  
  data { 
    int <lower = 0> N; 
    int <lower = 0> z;
  }
  
  parameters { 
    real <lower=0, upper=1> theta; 
    real <lower=0, upper=1> mu;
    real <lower=0, upper=1000> kappa;
  } 
  
  model { 
    mu ~ beta(2, 2);
    kappa ~ gamma(10, 0.1);
    theta ~ beta(mu, kappa); 
    z ~ binomial(N, theta); 
  } 
'

bin.data = list(N = 100, 
                z = 50)

binom.fit <- stan(model_code = binom.model, data=bin.data, iter = 500, chains = 4)

binom.fit

### Hierarchical Binomial model

HLMbinom.mod <- '
  
  data {
    int <lower = 0> D; // number of categories (SaF and SaS)
    int <lower = 0> N[D]; //  
    int <lower = 0> z[D]; // ditto on SaF
  }

  parameters{
    real <lower = 0, upper = 1> theta[D];
    real <lower = 0, upper = 1> mu[D];
    real <lower = 0, upper = 1000> kappa[D];
  }

  model {
    theta[D] ~ beta(mu[D], kappa[D]);
    for (d in 1 : D){
      mu[D] ~ beta(2, 2);
      kappa[D] ~ gamma(10, 0.1);
      z[D] ~ binomial(N[d], theta[d]);
    }
  }
'

HLMfit <- stan(model_code = HLMbinom.mod, data=hothand.data, iter = 5000, chains = 4)
print(newfit)


### Stan bernoulli fit for hothand model

hotbern.mod <- '

  data {
    int <lower = 0> nSaS; // success after success
    int <lower = 0> nSaF; // success after failure
    int <lower = 0, upper=1> SaS[nSaS]; // SaS takes integer value of 0 or 1 
    int <lower = 0, upper=1> SaF[nSaF]; // ditto on SaF
  }

  parameters{
  real <lower = 0, upper = 1> SaStheta;
  real <lower = 0, upper = 1> SaFtheta;
  }

  model {
    SaStheta ~ beta(30,10);
    SaFtheta ~ beta(30,10);
    for (i in 1 : nSaS)
      SaS[nSaS] ~ bernoulli(SaStheta);
    for (j in 1 : nSaF)
      SaF[nSaF] ~ bernoulli(SaFtheta);
  }
'
hotbern.data<-list('SaS' = c(rep(1, 251), rep(0, 34)),
                   'nSaS' = 285,
                   'SaF' = c(rep(1, 48),rep(0, 5)),
                   'nSaF' = 53)

hotbern <- stan(model_code = hothand.mod, data = hotbern.data, iter = 5000, chains = 4)
print(hotbern)
plot(hotbern)
hotbern.df <- as.data.frame(hotbern)
head(hotbern.df)

ggplot(hotbern.df, aes(x = lp__)) + geom_density() + ggtitle('hotfit model log(probability)')

hotbern.mlt <- melt(hotbern.df[,1:2])

plot <- ggplot(hotbern.mlt, aes(x=value, fill=variable)) + geom_density() + facet_wrap( ~ variable)
plot


### Stan binomial fit for simple hothand data

hotbin.mod <-'
  data {
    int <lower = 0> D;
    int <lower = 0> N[D];
    int <lower = 0> z[D];
  }

  parameters{
    real <lower = 0, upper = 1> theta[D];
  }

  model{
    theta[D] ~ beta(30, 10);
    for (d in 1 : D){
      z[d] ~ binomial(N[d], theta[d]);
    }
  }
'
hotbin.data <- list(
  D = 2,
  N = c(285, 53),
  z = c(251, 48)
)

hotbin <- stan(model_code = hotbin.mod, data = hotbin.data, iter = 10000, chains=4)
print(hotbin)
plot(hotbin) # look at parameter estimates
traceplot(hotbin) # Check traceplot

hotbin.df <- as.data.frame(hotbin)

ggplot(hotbin.df, aes(x = hotbin.df[,1], y = hotbin.df[,2])) + geom_point(color = "#0000FF", size = 0.1) + geom_density2d(color = 'yellow') + geom_abline(intercept = 0, slope = 1, lty=2) + xlim(0,1) + ylim(0,1)

hotbin.mlt <- melt(hotbin.df[, 1:2])

hotbin.plot <- ggplot(hotbin.mlt, aes(x = value, fill = variable)) + geom_density( ) + facet_wrap( ~variable)
hotbin.plot
