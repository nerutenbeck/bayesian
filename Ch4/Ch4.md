Doing Bayesian Data Analysis
Chapter 4 Homework
========================================================

## Nathan E. Rutenbeck
### September 18, 2013
[GitHub repository for all courswork] (http://github.com/nerutenbeck/bayesian)

--------------------------------------------------------

### 4.3) Natural Frequency and Markov representations

#### 4.3.A) Calculate table frequencies

 |$\theta=1$  |$\theta=0$ |$freq(D)$   
-----|------|-----|-----  
$D=1$ |$freq(D=1,\theta=1)=99$ |$freq(D=1,\theta=0)=94950$  |$freq(D=1)=95049$  
$D=0$ |$freq(D=0,\theta=1)=1$ |$freq(D=0,\theta=0)=4950$ |$freq(D=0)=4951$  
$freq(\theta)$|$freq(\theta=1)=100$ |$freq(\theta=0)=99900$ |$N=100000$  

#### 4.3.B) Calculate conditional probability of having the disease given positive test results.

$P(\theta=1|D=1)=\frac{99}{95049}=0.001$ 

#### 4.3.C) Of those who tested positive on the first test, how many will be expected to test positive in the second test?


$p(D=1|\theta=1)= \frac{9900}{10000} = 0.99$  
$p(D=0|\theta=1)= \frac{100}{10000} = 0.01$  
$p(D=1|\theta=0)= \frac{499500}{9990000} = 0.05$  
$p(D=0|\theta=0)= \frac{9490500}{9990000} = 0.95$  

$N=$  |$10000000$  
------|----------|  
$10000000 * p(\theta=1)=freq(\theta=1)=10000$ |$10000000*p(\theta=0)=freq(\theta=0)=9990000$  
$10000*p(D=1|\theta=1)=9900$  |$9990000*p(D=1|\theta=0)=499500$  
$9900*p(D=0|\theta=1)=99$  |$499500*p(D=0|\theta=0)=474525$

Assuming that the test and retest are independent, the total number of people who tested positive = 5.094 &times; 10<sup>5</sup>, $p(D=0|\theta=1)=0.01$, and $p(D=0|\theta=0)=0.95$, the total number of people expected to show negative results upon retesting is 4.7462 &times; 10<sup>5</sup>. 

#### 4.3.D) What is the proportion of those who first test positive then retest negative actually have the disease?

 $\frac{99}{474620}=0.00021$. This makes sense given the very low prior probability of having the disease in the first place.

#### 4.4) What is the probability that a random person has the disease given a negative test. Given a negative test and positive retest?

Probability that the person has the disease with a negative initial test:  
  
$\frac{p(\theta=1|D=0)=p(D=0|\theta=1)p(\theta=1)}{p(D=0)} = \frac{0.01*0.001}{0.94906}=0.00001$  

Probability that the person has the disease with negative initial test and positive retest:  

$\frac{p(\theta=1|D=1)=p(D=1|\theta=1)p(\theta=1)}{p(\theta=1)}=\frac{0.99*0.001}{0.05094}=0.01943$  
