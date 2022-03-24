%%=================================================================
%% Setup the economic environment: real wage rigid, diminishing MPL, inelastic supply of labor; perfect competition; risk-neutral hh
%% Weekly frequency (1/12 of a quarter), 1/4 of a month
%%	Created by Pascal Michaillat, London School of Economics on 2010-07-08
%%	Rev. by Pascal Michaillat on 2010-07-23: Move the estimation and discretization of technology process to data script (eg TFP_1964_2009)
%%	Rev. by Pascal Michaillat on 2011-01-07: cleanup file and keep only relevant parameters
%%=================================================================

global delta eta c a alpha omega s  B r varsigma  u_target th_target w0 gamma
global q f u finv qinv uinv ur
global ns

%%==================================================       Estimated parameters 

delta=(0.95).^(1./(12*4));      % discount factor
s=0.038./4;    % destruction rate
omega=0.933./4; 	%matching coeff
eta=0.5; 	%unemp-elast of matching function
%steady-state
a=1; 		%LR technology
u_target=0.058;% CPS -- 1964-2009 (also average of HP trend)
r=1-delta.*(1-s);
varsigma=s./(1-s);
gamma=.7;%real wage rigidity, from microdata 

%%================================================================     Functions

%use Cobb-Douglas matching function
q=@(x)omega.*x.^(-eta);
qinv=@(q)(q./omega).^(-1./eta);
finv=@(f)(f./omega).^(1./(1-eta));
f=@(x)omega.*x.^(1-eta);
uinv=@(ux)finv(varsigma*(1-ux)./ux);
u=@(th)varsigma./(varsigma+f(th));
th_target=uinv(u_target);
n_target=(1-u_target)./(1-s);

%%===========================================================     Calibration   

%%%%%%%%%%  use labor share to find alpha   %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
ls=0.66;%\can{GR07}

ccoeff=0.32;

alpha=ls.*(1+r.*ccoeff./q(th_target));
B=alpha.*(1-s).^(1-alpha);%useful parameter
w0=ls./n_target^(1-alpha);
c=ccoeff.*w0;


ur=@(ax) max(1-((alpha./w0).^(1./(1-alpha)).*ax.^((1-gamma)./(1-alpha))),0);





