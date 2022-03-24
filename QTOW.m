%%==============================================================================
%%                  Transform quarterly series to weekly series by interpolation
%%	Created by Pascal Michaillat, London School of Economics on 2011-01-20
%%==============================================================================

function [wax]=QTOW(ax)

del=ax(2:end)-ax(1:end-1);
del=del'./12;
DEL=[zeros(size(del));del; 2.*del; 3.*del; 4.*del; 5.*del; 6.*del; 7.*del; 8.*del; 9.*del ; 10.*del; 11.*del];%one week= 1/12 quarter
AX=repmat(ax(1:end-1)',12,1);
WAX=AX+DEL;
WAX=WAX(1:end);
wax=[WAX,ax(end)];
