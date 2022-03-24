%==============================================
%OLS with intercept
%Returns Beta and standard errors for Beta
%PM
%09/29
%==============================================
function [Beta,Std,R2,t_stat,t_prob]=OLS(Y,X,ttest1)

%Run a Classical Normal LS regression
n=size(X,2);
T=size(Y,1);
X=[ones(T,1),X];
XX_inv=(X'*X)^(-1);
Beta=XX_inv*X'*Y;%estimated beta
Eps=(Y-X*Beta);%residuals
s2=(Eps'*Eps)./(T-n);%estimator s^2
VAR=s2.*XX_inv; %estimated variance matrix of beta
Std=sqrt(diag(VAR));%standard deviations of the fitted coefficients
R2=1-(Eps'*Eps)/(T.*var(Y,1)); %constant-adjusted R^2
t_stat=Beta./Std; %t-statistics to test whether beta is different from zero
t_prob=tcdf(t_stat,T-n);

%  %t-test to compare beta(2) with ttest (one or two-sided test)
%  if nargin==3
%  R=[0,1];
%  theta_hat=R*Beta;
%  t_stat2=(theta_hat-ttest)./(s2*R*XX_inv*R')^(.5);
%  t_prob2=tcdf(t_stat2,T-n);% if >0.975, one-sided reject it is as big. if <0.025, one-sided reject it is as small. can do two sided too.
%  end
