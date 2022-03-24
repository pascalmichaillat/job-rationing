%%=============================================
%% Compute summary stat of matrix X (each row is an observation and each column is a variable.)
%%	Created by Pascal Michaillat, London School of Economics on 2010-07-08
%%=============================================


function [moy,dev,autoc,M]=SUMSTAT(X)
	
moy=mean(X,1);
dev=std(X,1);
autoc=[];
for j=1:size(X,2)
autoc=[autoc,AUTOCORREL(X(:,j),2)];
end
autoc=autoc(2,:); %only keep serial correlation
M=corrcoef(X);
