%%=================================================================
%% Production function with decreasing MPL
%%	Created by Pascal Michaillat, London School of Economics on 2010-07-08
%%=================================================================

function res=PROD(a,n)
	
global alpha
res=a.*n^alpha;