%=================================================================
%% Find theta in steady state for GE model, from FOC of firms
%%	Created by Pascal Michaillat, London School of Economics on 2010-07-08
%=================================================================

function res=FINDTH(w,gamma)
global r c q B alpha markup u a

res0=0.5;
OBJF=@(thx)(r.*c./q(thx)-(B./(1-u(thx)).^(1-alpha)-a.^(gamma-1).*w));
[res,val,exitflag]=fsolve(OBJF,res0,optimset('TolFun',10^(-13)));
