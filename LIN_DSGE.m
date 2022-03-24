%%==============================================================================
%%                      Solve linear DSGE model calibrated at weekly frequency
%%	Created by Pascal Michaillat, London School of Economics on 2010-07-26
%%	Rev. by Pascal Michaillat on 2011-01-06: Limit amount of information displayed (cof, etc.)
%%	Rev. by Pascal Michaillat on 2011-01-07: suppress as global var. (old notation)
%%==============================================================================


function [AMAT,BMAT,SS,xeq,xvari,s3]=LIN_DSGE(w,gamma,alpha)

global delta eta c a sigma_a omega rho_a s z q f u varsigma uinv 
global W_bar C_bar TH_bar  N_bar H_bar U_bar UC_bar UF_bar Y_bar   
global wpos cpos thpos npos hpos upos ucpos ufpos ypos apos  a_pos

%%%%%%%%%%%  set up positions of variables   %%%%%%%%%%%%%%%%%%%%%%%%%%%

xlead = 1;     % Number of leads in system (recruiting)
xlag  = 1 ;     % Number of lags in system  (employment)
xnames = ['TH';'W ';'C ';'N ';'H ';'U ';'Y ';'A ';'A_'];
xnum = size(xnames,1); % Number of variables in system 
xeq = xnum ;              % Number of equations (same)
xvari=xnum-1;

colzero = 0+xlag*xnum;   % Position counter for start of contemp. coefs 
collead = 0+xlag*xnum+xnum; % Position counter for start of lead coefs 
collag  = 0  ;% Position counter for start of lag coefs  

wzero   = colzero+wpos;
czero   = colzero+cpos;
thzero   = colzero+thpos;
nzero   = colzero+npos;
hzero   = colzero+hpos;
uzero   = colzero+upos;
yzero   = colzero+ypos;
azero  = colzero+apos;
a_zero   = colzero+a_pos;

wlead   = collead+wpos;
clead   = collead+cpos;
thlead   = collead+thpos;
nlead   = collead+npos;
hlead   = collead+hpos;
ulead   = collead+upos;
ylead   = collead+ypos;
alead  = collead+apos;
a_lead   = collead+a_pos;

wlag   = collag+wpos;
clag   = collag+cpos;
thlag   = collag+thpos;
nlag   = collag+npos;
hlag   = collag+hpos;
ulag   = collag+upos;
ylag   = collag+ypos;
alag  = collag+apos;
a_lag   = collag+a_pos;

% Now we have one vector with all of the leads, contemporaneous and 
% lags stacked in one column
% Determine number of total posible coefficients per equation: 
xcoef = xeq*(xlag+xlead+1);
% Initialize the coeffienct matrix, where each 
% row is an equation of the model
cof = zeros(xeq,xcoef)  ;   % Coef matrix --- Each row is an equation

%%%%%%%%%%%  steady-state shares   %%%%%%%%%%%%%%%%%%%%%%%%%%%

xx=alpha.*N_bar.^alpha;
sa= w./xx  ;
sb= (c.*a./q(TH_bar))./xx;
sc=c.*a./q(TH_bar).*(1-s).*delta./xx ;
s2=(c.*a.*s)./(q(TH_bar).*N_bar.^(alpha-1));
s3=1./((1-s).*N_bar)-1;
s4=UC_bar./(1-UC_bar);
s5=UC_bar./U_bar;


%%%%%%%%%%%  equilibrium conditions:  Setup coefficients vectors for each equation   %%%%%%%%%%%%%%%%%%%%%%%%%%%


% euler equation
cof(1,azero)    =  1-gamma.*sa-sb;
cof(1,nzero)    =  (alpha-1);
cof(1,thlead)    = sc.*eta;
cof(1,thzero)    =-eta.*sb;
cof(1,alead)    = sc;


% unemployment def.
cof(2,uzero)   = s3;
cof(2,nlag)   =  1;

% theta def.
cof(3,thzero)   =  1-eta;
cof(3,hzero)    =  -1;
cof(3,uzero)   =  1;

%employment fluctuations
cof(4,nzero)   =  1;
cof(4,nlag)    =  -(1-s);
cof(4,hzero)    =  -s;

%resource constraint
cof(5,yzero)   =  1;
cof(5,azero)    =  -s2;
cof(5,czero)   =  s2-1;
cof(5,thzero)   = -s2*eta;
cof(5,hzero)   = -s2;

%output
cof(6,yzero)	=1;
cof(6,azero)	=-1;
cof(6,nzero)	=-alpha;

%wage
cof(7,wzero)=1;
cof(7,azero)=-gamma;


% correlated error term: technology
cof(8,azero)  =  -1;
cof(8,alag)   =  rho_a;
cof(8,a_zero) =  1;

% 0 = SHOCKS
cof(9,a_zero) =  1;

%%%%%%%%%%%   Use AIM procedure to solve model  %%%%%%%%%%%%%%%%%%%%%%%%%%%

uprbnd = 1+1e-8;    % Tolerance values for AIM program 
condn = 1e-8;
[cofb,rts,ia,nex,nnum,lgrts,mcode] =  aim_eig(cof,xeq,xlag,xlead,condn,uprbnd);

scof = obstruct(cof,cofb,xeq,xlag,xlead);
s0 = scof(:,(xeq*xlag+1):xeq*(xlag+1)); %Contemp. coefs from obs.
                                        %structure
amat=zeros(xeq*xlag,xeq*xlag);   		% Initialize A matrix 
bmat=cofb(1:xeq,((xlag-1)*xeq+1):xlag*xeq); % Lag 1 coefficients 
i=2;
while i<=xlag;
  bmat=[bmat cofb(1:xeq,((xlag-i)*xeq+1):(xlag-i+1)*xeq)]; % Lag i coefs 
  i=i+1;
end;
amat(1:xeq,:)=bmat;  				% Coefs for equations 
if xlag>1;
 amat((length(cofb(:,1))+1):length(amat(:,1)),...
     1:xeq*(xlag-1))=eye(xeq*(xlag-1));
end;
b = zeros(length(amat(:,1)),length(s0(1,:)));
b(1:length(s0(:,1)),1:length(s0(1,:))) = inv(s0);  % Store coefs 


% check unique/stable REE: mcode = 1
if mcode ~=1
'ERROR: NON_UNIQUE REE'
disp(['mcode = ' num2str(mcode)]) % unstable? non-unique?
end

AMAT=amat;
BMAT=b;
% to compute and plot impulse response use reduced form solution: x_t=amat*x_{t-1}+b*shock
SS=[];
SS(wpos,1)= W_bar;
SS(cpos,1)=C_bar;
SS(thpos,1)=TH_bar;
SS(npos,1)=N_bar;
SS(hpos,1)=H_bar;
SS(upos,1)=U_bar;
SS(ypos,1)=Y_bar;
SS(apos,1)=a;
SS(a_pos,1)=0;
