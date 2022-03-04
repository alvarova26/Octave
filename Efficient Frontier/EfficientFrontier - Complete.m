%clear all;
%close all;
function EfficientFrontier_C(S,Rm) 
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% Mean Variance Optimizer Inputs
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
 
% S is matrix of security covariances
%S = [185 86.5 80 20; 86.5 196 76 13.5; 80 76 411 -19; 20 13.5 -19 25]
 
% Vector of security expected returns
%Rm = [14; 12; 15; 7]
 
% Risk Free Asset Return
R = 3
 
% Target Return
mu_tar = 14
 
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% Calculating Variables
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
 
% Unity vector..must have same length as Rm
unity = ones(length(Rm),1)
 
% Vector of security standard deviations
stdevs = sqrt(diag(S))
 
A = unity'*S^-1*unity
B = unity'*S^-1*Rm
C = Rm'*S^-1*Rm
D = A*C-B^2
 
% Calculate Lambda and Gamma
lambda_target = (C - mu_tar*B)/D;
gamma_target =  (mu_tar*A-B)/D;
 
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% Efficient Frontier
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
mu = 1:5000;
mu = mu/100;
 
minvar = ((A*mu.^2)-2*B*mu+C)/D;
minstd = sqrt(minvar);
 
plot(minstd,mu,stdevs,Rm,'*')
title('Efficient Frontier with Individual Securities','fontsize',18)
ylabel('Expected Return (%)','fontsize',18)
xlabel('Standard Deviation (%)','fontsize',18)
 
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% Global Minimum Variance Portfolio
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
 
% Mean and Variance of Global Minimum Variance Portfolio
mu_g = B/A
var_g = 1/A
std_g = sqrt(var_g)
 
% Minimum Variance Portfolio Weights
w_g = (S^-1*unity)/A
 
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% Tangency Portfolio with a Risk Free Asset
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
 
% Expected Return of Tangency Portfolio
ztan = (C-B*R)/(B-A*R);
 
% Variance and Standard Deviation of Tangency Portfolio
vartan = (C-2*R*B + R^2*A)/((B-A*R)^2);
stdtan = sqrt(vartan);
 
% Weights for Tangency Portfolio
w_tan = (S^-1*(Rm - R*unity))/(B-A*R)
 
% Tangency Line
mu_tan = mu(mu >= R);
minvar_rf = (mu_tan-R).^2/(C-2*R*B+A*R^2);
minstd_rf = sqrt(minvar_rf);
 
% Weights for w_d (tangency when R=0)
w_d = (S^-1*Rm)/B;
 
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% Target Return Portfolio w/and w/o Risk Free Asset
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
 
% Weights for portfolio with target return = 14%, w/o risk-free asset
 
w_s = (lambda_target*A)*w_g + (gamma_target*B)*w_d;
 
% Expected Return of Target Portfolio (should match target)
mu_s = w_s'*Rm;
 
% Variance and Standard Deviation of target portfolio
var_s = w_s'*S*w_s;
std_s = sqrt(var_s);
 
% Weights for portfolio with target return = 14%, w/risk free asset
 
y = (mu_tar - R)/(ztan-R);
stdtar = stdtan*y;
 
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% Tangency Plot
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
 
figure
plot(minstd_rf,'linewidth',2,mu_tan,minstd,'linewidth',2,mu,stdtan,ztan,'*','linewidth',2,std_g,mu_g,'x','linewidth',2,std_s,mu_s,'x','linewidth',2,stdtar,mu_tar,'*','linewidth',2)
text(0.5,R,'RF','fontsize',12);
text(0.5+std_g,mu_g,'Global Minimum Variance Portfolio','fontsize',12);
text(0.5+stdtan,ztan,'Tangency Portfolio','fontsize',12);
text(0.5+std_s,mu_s,'Target Return of 14% w/o Risk-Free Asset','fontsize',12);
text(stdtar-8,mu_tar+0.5,'Target Return of 14% w/Risk-Free Asset','fontsize',12);
title('Efficient Frontier with Tangency Portfolio','fontsize',18)
ylabel('Expected Return (%)','fontsize',18)
xlabel('Standard Deviation (%)','fontsize',18)

