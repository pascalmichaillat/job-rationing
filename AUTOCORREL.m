%%==============================================================================
%%  Compute first k empirical autocorrelations of time-series TS
%% TS and RES are column vectors
%%	Created by Pascal Michaillat, London School of Economics on 2010-07-26
%%==============================================================================

function [RES]=AUTOCORREL(TS,k)


n=size(TS,1);
mu=mean(TS,1);
V2=TS-mu;
Z=zeros(1,k);
T=toeplitz(V2,Z);
RES=V2'*T./[(n):(-1):(n-k+1)];%autocovariance
RES=RES'./RES(1); %divide by empirical standard deviation
	 