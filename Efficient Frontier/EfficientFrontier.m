function EfficientFrontier(S, Rm)

% Mean Variance Optimizer
 
% S is matrix of security covariances
%S = [185 86.5 80 20; 86.5 196 76 13.5; 80 76 411 -19; 20 13.5 -19 25]
 
% Vector of security expected returns
%rx = [14; 12; 15; 7]
 
% Unity vector..must have same length as zbar
unity = ones(length(Rm),1)
 
% Vector of security standard deviations
stdevs = sqrt(diag(S))
 
% Calculate Efficient Frontier
A = unity'*S^-1*unity
B = unity'*S^-1*Rm
C = Rm'*S^-1*Rm
D = A*C-B^2
 
% Efficient Frontier
mu = (1:1000)/100;
%mu = seq(0, 300, by=.1)
 
% Plot Efficient Frontier
minvar = ((A*mu.^2)-2*B*mu+C)/D;
minstd = sqrt(minvar);
 
plot(minstd,mu,stdevs,Rm,'*')
title('Efficient Frontier with Individual Securities','fontsize',18)
ylabel('Expected Return (%)','fontsize',18)
xlabel('Standard Deviation (%)','fontsize',18)
