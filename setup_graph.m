%=================================================================
%setup the economic environment: real wage rigid, diminishing MPL, inelastic supply of labor; perfect competition; risk-neutral hh
%weekly frequency (1/12 of a quarter), 1/4 of a month
%07/02/2011
%PM
%=================================================================

clear all;close all;

global delta eta c a alpha sigma_a omega rho_a s z q f u B markup r varsigma finv qinv uinv u_target th_target sigma w gamma ns

%------------------------------------------------------------------
sigma= 0;%preference parameter (log utility) 
delta=(0.95).^(1./(12*4));      % discount factor
s=0.038./4;    % destruction rate
omega=0.933./4; 	%matching coeff
eta=0.5; 	%unemp-elast of matching function
c=.215;	 %recruiting costs -- .322 * wage
%steady-state
a=1; 		%LR technology

%------------------------------------------------------------------

%targets from JOLTS and CPS
u_target=0.058;% CPS -- 1964-2009

%epsi=9;% %product's elasticity
r=1-delta.*(1-s);
varsigma=s./(1-s);
q=@(x)omega.*x.^(-eta);
qinv=@(q)(q./omega).^(-1./eta);
finv=@(f)(f./omega).^(1./(1-eta));
f=@(x)omega.*x.^(1-eta);
uinv=@(ux)finv(varsigma*(1-ux)./ux);
u=@(th)varsigma./(varsigma+f(th));

%------------------------------------------------------------------------------
ft=omega.*(uinv(u_target)).^(1-eta);

%use labor share to find alpha
ls=0.66;%\can{GR07}
a0=.7;
OBJF=@(ax)((ax-((1-u_target)./(1-s)).^(1-ax).*r.*c./q(uinv(u_target)))-ls).^2;
[res,val,exitflag]=fsolve(OBJF,a0,optimset('TolFun',10^(-16)));
alpha=res;
B=alpha.*(1-s).^(1-alpha);

%use ratio of variances to pick gamma (var(ln(w))/var(ln(a)))
gamma=.7;%real wage rigidity 

%pick w to match steady-state unemployment rate
w=(B./(1-u_target).^(1-alpha)-r.*c./q(uinv(u_target)));	

%----------------------------------------------------------------
cMPS=.32;	 %recruiting costs -- .322 * wage
cMP=cMPS;
%pick w to match steady-state unemployment rate in MPS/MPSgamma
wMPS=(a-r.*cMPS./q(uinv(u_target)));
%pick beta to match steady-state unemployment rate in MPS/MPSgamma
th_target=uinv(u_target);
OBJ=@(betax)(cMP/q(th_target).*r+cMP.*betax.*(1-s).*delta.*th_target-(1-betax).*a).^2;
[res,val,exitflag]=fsolve(OBJ,.5,optimset('TolFun',10^(-16)));
betaMP=res;

%---------------------------------------------------------------------------
%use labor share to find alpha
ls=0.66;%\can{GR07}
nbar=(1-u_target)./(1-s)
kappa=(r.*0.32./q(th_target)+1).*ls
betaSZ=ls./(kappa+delta.*(1-s).*th_target.*0.32.*ls)
alphaSZ=(kappa-betaSZ.*kappa)./(1-betaSZ.*kappa)
wbar=ls.*nbar.^(alpha-1)
cSZ=0.32.*wbar





