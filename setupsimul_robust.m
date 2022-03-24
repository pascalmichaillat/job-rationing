%%==============================================================================
%%                  Set up for simulation of log-linear model with job rationing for IRF and simulated moments
%%	Created by Pascal Michaillat, London School of Economics on 2010-07-26
%%	Rev. by Pascal Michaillat on 2011-01-08: Checks the robustness of various parameters from the calibration
%%==============================================================================


global  W_bar C_bar TH_bar  N_bar H_bar U_bar UC_bar UF_bar Y_bar 
global rho_a sigma_a nsample
global wpos cpos thpos npos hpos upos ypos apos  a_pos

%%==============================================================     Calibration

setup_robust;%model parameters
[W_bar,C_bar,TH_bar,N_bar,H_bar,U_bar,UC_bar,UF_bar,Y_bar]=STEADYLL(w,gamma);%steady states
nsample=182;
[rho_a,sigma_a,ax]=TECHNO(alpha,nsample);%technology process

%positions of variables
wpos	=2;	% wage
cpos   =  3;               % consumption
thpos   =  1;               % market tightness
npos   =  4;               % employment
hpos   =  5;               % hiring. rate
upos   =  6;               % unemp. rate
ypos  =  7;               % output
apos   =  8;               % techno 
a_pos   = 9;               % techno shock

%%===================================================     Solve log-linear model
[AMAT,BMAT,SS,xeq,xvari]=LIN_DSGE(w,gamma,alpha);% to compute and plot impulse response use reduced form solution: x_t=amat*x_{t-1}+b*shock