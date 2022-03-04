%% Initialization
clear ; close all; clc

%Stock_x => Vector of the montly returns of the Stock 'x' (1xNs dimensions)
%X       => Matrix of all stock's vectors (NpxNs dimensions)
%mu_s    => Vector of mean (average)of returns of each stock in X (Npx1 dimensions)
%var_s   => Vector of variance of returns of each stock in X (Npx1 dimensions)
%R       => Matrix of correlation of returns of stocks with each other (NpxNp dimensions)  
%S       => Matrix of covariance of returns of stock with each other (NpxNp dimensions)
%Np      => Number of stocks in the portfolio (#)
%Ns      => Number of samples of each stock (#)
%des_ret => Desired return of the porfolio optimized (% annualized)

% Load stock's data
%Stock_A = [ 0.1453 -0.1881 -0.0997 -0.0114 0.0000 0.0000 0.0894 0.0000 0.0068 -0.0927 -0.1621 0.0745 ]
%Stock_B = [ 0.0910 -0.0902 -0.1801 0.0416 0.0106 0.0000 0.0134 0.1545 0.1751 -0.1829 -0.1892 0.0072 ]
%Stock_C = [ 0.0000 0.1223 0.0892 0.0000 -0.0659 -0.0819 -0.0589 -0.0317 0.0000 0.0253 0.0000 -0.0397 ]
%Stock_D = [ 0.0215 0.0995 0.0787 -0.0471 -0.0697 0.0835 0.0458 0.0000 0.0000 -0.0710 0.1627 0.0901 ]

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

des_ret = 12

%S = [185 86.5 80 20; 86.5 196 76 13.5; 80 76 411 -19; 20 13.5 -19 25]
%mu_s = [14; 12; 15; 7]
%var_s = diag(S)

% If a target rate of return is specified. perform a perfolio optimization with
% this constraint. Otherwise. use the global minimum variance solution.
%
if(isnan(des_ret)) % global minimum variance Markowitz portfolio
  [w_p, mu_p, var_p] = M_P_Unconstrained(mu_s, Np, Ns, S)
else % Markowitz portfolio with specified rate of return
  [w_p, mu_p, var_p] = M_P_Constrained(mu_s, Np, Ns, S, des_ret);
end

% w_p    => portfolio's weights optimized
% mu_p   => portfolio's expected return optimized
% var_p  => portfolio's variance optimized
