%==============================================================
%% Simulate with shooting the path of unemployment and labor market tightness
%% Shocks to technology are actual shocks from US data -- Markov Chain (transition matrix PI) 
%% TH: solution of stochastic equilibrium
%% A: discrete technology process
%% PI: Markov transition matrix
%% TH: stochastic equilibrium (used for 1st guess)
%% T: length of simulation
%% amc: time series of states
%% n0: employment in past period
%% output: time series for unemployment ut, labor market tightness tht, technology at, measure of layoffs sigmat
%%	Created by Pascal Michaillat, London School of Economics on 2010-07-08
%%	Rev. by Pascal Michaillat on 2010-07-12: In shooting algorithm, always start type III iteration with an EP of fixed length k1, 
%% or an average of k1 and past value of kIII so that size of EP does not remain too long after bad iteration
%==============================================================

function [Yt]=SIMULFT(TH,A,wamc,n0,EY,YLR)

global delta eta c a alpha sigma_a omega rho_a s markup r varsigma  u_target th_target sigma w gamma
global q f u finv qinv uinv
global ns ynum
global apos thpos npos mplpos hpos wpos Rpos  upos


%%===========================================================     Key parameters

k0=25;%number of expectations to compute to have stable result
hori=1;
k1=k0+2.*hori+1;% total number of expectations to compute (including current period)

n=max(size(wamc))

%%===========================================================     Initialization

Yt=zeros(ynum,n+1);
Y0=zeros(ynum,1); % vector Y at t-1 -- only the value of employment matter
Y0(npos)=n0;
Yt(:,1)=Y0;
s1=wamc(1); %first state
kIII=k1+1;

%%==========================     Iteration over 1964-2009 period to slove model 

for i=1:n 
	si=wamc(i);
	grt=squeeze(EY(:,si,:));%includes guess for current period
%	if i>1
%			grt(:,1:kIII-2)=er;%include guess for (new) current period
%	end
  	[Yi,er,kIII,eII,eIII]=SHOOTING(grt,Yt(:,i),si,floor(0.5.*k1+0.5.*(kIII-1)));%must include type I, II, and III iteration
	Yt(:,i+1)=Yi;
	figure(4)
	scatter([i],[Yi(upos)],'red')
	eII
	eIII
	hold on
end

Yt=Yt(:,2:end);%get rid of initial value Y0
