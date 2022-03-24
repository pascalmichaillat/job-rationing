%=====================================================
%% construct TH -- stochastic equilibrium: u is jump variable, and RE
%% construct TH0 -- steady-state equilibrium: u is jump variable, no aggregate shocks
%% TH, TH0 are row vectors of the same size as A and PI 
%%	Created by Pascal Michaillat, London School of Economics on 2010-07-08
%%	Rev. by Pascal Michaillat on 2011-01-07: clean up old global parameters
%====================================================

function [TH,TH0]=MCSOLVE(PI,A)

global delta s q c u f rho alpha rho ns r w B gamma

%%%%%%%%%%%  Construct TH0, serves as initial guess   %%%%%%%%%%%%%%%%%%%%%%%%%%%

res0=10.^(-3);TH0=[];
OBJF=@(thx,ax)min(r.*c.*ax./q(thx.^2),(r.*c.*ax./q(thx.^2)-(B.*ax.*(1-u(thx.^2)).^(alpha-1) -w.*ax^(gamma))));
for i=1:size(A,2)
  [res,val,exitflag]=fsolve(@(thx)OBJF(thx,A(i)),res0,optimset('TolFun',10^(-17)));
  TH0=[TH0,res.^2];
  res0=res;
end

%%%%%%%%%%%  Determine TH, solution to dynamic system   %%%%%%%%%%%%%%%%%%%%%%%%%%%

OBJ=@(THX)((eye(size(PI))-(1-s).*delta.*PI)*(c.*A./q(THX.^2))'-(B.*A'.*(1-u(THX.^2)').^(alpha-1) -w.*(A.^(gamma))')).^2;
[res,val,exitflag]=fsolve(OBJ,TH0.^(0.5),optimset('TolFun',10^(-16),'MaxFunEvals',3.*10^4));
TH=res.^2;




