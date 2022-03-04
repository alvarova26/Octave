%% Initialization
clear ; close all; clc

%Expected return of the portfolio
mu_e = 10
%Risk free asset return
R = 3

Stock_A = [6.98 0.64 11.74 -2.63 -2.38 1.63 3.19 4.13 3.22];
Stock_B = [2.26 -1.85 10.66 -1.95 -0.31 0.84 0.56 3.92 0.67];
Stock_C = [3.96 0.22 9.25 -3.47 -4.82 0.29 2.24 2.79 3.62];
Stock_D = [0.07 1.29 1.46 0.47 0.71 1.03 1.30 1.65 0.89];
Stock_E = [1.44 1.80 6.51 0.46 0.36 1.70 5.10 4.97 1.41];
Stock_F = [2.87 -0.54 10.03 -1.96 -1.08 0.96 0.72 4.38 2.22];
Stock_G = [5.08 3.01 7.52 -1.88 -1.21 1.39 1.43 6.41 6.85];

X = [Stock_A; Stock_B; Stock_C; Stock_D; Stock_E; Stock_F; Stock_G]

mu_s = mean (X,2)
var_s = var (X,1,2)
R = corrcoef(X')
S = cov(X',1)
Np = size(X,1)
Ns = size(X,2)
O = ones(Np,1)

%S = [185 86.5 80 20; 86.5 196 76 13.5; 80 76 411 -19; 20 13.5 -19 25]
%mu_s = [14; 12; 15; 7]
%var_s = diag(S)
%Np = size(S,1)
%O = ones(Np,1)


% Efficient Frontier vectorized implementation
A = O'*S^-1*O
B = O'*S^-1*mu_s
C = mu_s'*S^-1*mu_s
D = A*C - B^2

mu_p = ((1:1100)/1000)*10;

var_p = (A*mu_p.^2 - 2*B*mu_p + C)/D;
std_p = sqrt(var_p);
plot(std_p, mu_p,'k+','LineWidth', 1, 'MarkerSize', 1,'Color', 'r');
title('Efficient Frontier','fontsize',18)
ylabel('Expected Return (%)','fontsize',15)
xlabel('Standard Deviation (%)','fontsize',15)
hold on

% Working for loop => it is better/faster the vectorized implementation
%for i=1:5000
%  mu_p = i/100;
%  var_p = (A*mu_p^2 - 2*B*mu_p + C)/D;
%  std_p = sqrt(var_p);
%  plot(std_p, mu_p, 'k+','LineWidth', 1, 'MarkerSize', 5,'Color', 'r');
%  hold on
%endfor

%Global Minimum Variance Portfolio

%Weights of the portfolio at global minimum variance
w_g = (S^-1*O)/A
mu_g = w_g'*mu_s
var_g = w_g'*S*w_g
std_g = sqrt(var_g)
plot(std_g, mu_g,'k+','LineWidth', 1, 'MarkerSize', 10,'Color', 'b');
text(0.1+std_g,mu_g,'Global Minimum Variance Portfolio','fontsize',10);

%Tangency Portfolio with R=0
w_d = (S^-1*mu_s)/B
mu_d = w_d'*mu_s
var_d = w_d'*S*w_d
std_d = sqrt(var_d)
plot(std_d, mu_d,'k+','LineWidth', 1, 'MarkerSize', 10,'Color', 'b');
text(0.1+std_d,mu_d,'Tangency Portfolio when R=0','fontsize',10);

%The Two-Fund Separation Theorem 
lambda = (C - mu_e*B)/D
gamma = (mu_e*A - B)/D
w_e = lambda*A*w_g + gamma*B*w_d
mu_e = w_e'*mu_s
var_e = w_e'*S*w_e
std_e = sqrt(var_e)
plot(std_e, mu_e,'k+','LineWidth', 1, 'MarkerSize', 10,'Color', 'b');
text(0.1+std_e,mu_e,'Portfolio with Target Desired Return','fontsize',10);

%Tangency Portfolio with a Risk-Free Asset w/return R
w_t = (S^-1*(mu_s - R*O))/(B - A*R)
z_t = w_t'*mu_s
var_t = w_t'*S^-1*w_t
std_t = sqrt(var_t)



