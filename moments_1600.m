%%==============================================================
%% moments of linear DSGE model (already in logs)
%%	Created by Pascal Michaillat, London School of Economics on 2010-07-26
%%	Rev. by Pascal Michaillat on 2011-01-06: HP-filter model-generated data
%%=============================================================

clear all;close all;
setupsimul_1600;
whp=1600;%weight on hp filter (quarterly frequencies)- shimer (2005): 10^5 - conventional: 1600
rep=50;%number samples - 10,000 in shimer(2005) - 100 in Michaillat (2010)
cut=100;
T=rep.*182*(3*4)+cut*(3*4)%samples of 182 quarters
Eps=sigma_a.*randn(1,T);%realization of errors

%%===================================================================    simulation of weekly time series
nvar=max(size(AMAT));
x_past=zeros(nvar,1); %start from steady state
shock=zeros(nvar,1);
X=[];
for i=1:T
  shock(a_pos)=Eps(i);
  x_past=AMAT*x_past+BMAT*shock;
  X=[X,x_past];
end

tht=X(thpos,cut*(3*4)+1:end);
ut=X(upos,cut*(3*4)+1:end);
vt=tht+ut;
yt=X(ypos,cut*(3*4)+1:end);
at=X(apos,cut*(3*4)+1:end);
wt=X(wpos,cut*(3*4)+1:end);

%%===================================================================    make quarterly values
tht=tht(1:4:end);
ut=ut(1:4:end);
vt=vt(1:4:end);

%quarterly averages
tht=1./3.*(tht(1:3:end-2)+tht(2:3:end-1)+tht(3:3:end));
ut=1./3.*(ut(1:3:end-2)+ut(2:3:end-1)+ut(3:3:end));
vt=1./3.*(vt(1:3:end-2)+vt(2:3:end-1)+vt(3:3:end));

at=at(1:12:end);
wt=wt(1:12:end);
yt=yt(1:12:end);




%%===================================================================     moments as averages of sample - sample periods of 182 quarters
ix=0;moy=[];dev=[];autoc=[];Q=[];

for i=1:rep
ran=[1+ix:182+ix];
D=[ut(ran)',vt(ran)',tht(ran)',wt(ran)',yt(ran)',at(ran)'];
%%HP-filter all samples of model-generated series
for j=1:6
	D(:,j)=hpfilter(D(:,j),whp);
end
[a1,a2,a3,a4]=SUMSTAT(D);
moy(:,i)=a1;dev(:,i)=a2;autoc(:,i)=a3;Q(:,:,i)=a4;
ix=ix+182;
end

dev1=mean(dev,2);dev2=std(dev,0,2);
autoc1=mean(autoc,2);autoc2=std(autoc,0,2);
Q1=mean(Q,3);Q2=std(Q,0,3);

TAB3=[dev1,autoc1,Q1];
fid = fopen('table/mean_1600.txt', 'wt');
fprintf(fid, '& %4.3f  & %4.3f & %4.3f & %4.3f  & %4.3f & %4.3f \\\\ \n', TAB3);
fclose(fid);


TAB3=[dev2,autoc2,Q2];
fid = fopen('table/variance_1600.txt', 'wt');
fprintf(fid, ' & (%4.3f) & (%4.3f) & (%4.3f) & (%4.3f)  & (%4.3f) & (%4.3f)\\\\ \n', TAB3);
fclose(fid);

