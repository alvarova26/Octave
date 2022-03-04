function [w_p, mu_p, var_p] = M_P_Constrained(mu_s, Np, Ns, S, des_ret)

% WORKING AS EXPECTED - CHECKED!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!

% Markowitz Portfolio Optimization - Constrained to desired return
%
% minimize: var_p = w_p'*S*w_p
% subject to: des_ret = w_p'*mu_s
% subject to: w_p'*O = 1
%
% where
% des_ret=> portfolio's desired return (% annualized)
% w_p    => portfolio's weights optimized
% mu_p   => portfolio's expected return optimized
% var_p  => portfolio's variance optimized

% mu_s   => Vector of mean (average)of returns of each stock in X (Npx1 dimensions)
% Np     => Number of stocks in the portfolio (#)
% Ns     => Number of samples of each stock (#)
% S      => Matrix of covariance of returns of stock with each other (NpxNp dimensions)
% O      => ones vector
% Z      => zeros vector
%
%
%
% Matrix equations
%
% A * x = b
%
% |  2S  mu_s O |   |   w_p   |   |    O    |
% | mu_s' 0   0 | * | lambda1 | = | des_ret |
% |  O'   0   0 |   | lambda2 |   |    1    |
%
% where
% S       => Matrix of covariance of returns of stock with each other (NpxNp dimensions)
% w_p     => portfolio's weights optimized
% O       => ones vector
% Z       => zeros vector
% lambda1 => Lagrange multiplier for target return
% lambda2 => Lagrange multiplier for normalized weight constraint
%
%
% Markowitz linear equations
  des_mu = des_ret/Ns
  A = [ 2*S mu_s ones(1,Np)' ; mu_s' 0 0 ; ones(1,Np) 0 0 ];
  b = [ zeros(1,Np) des_mu 1 ]';
  z = A\b;                                  % solve Ax=b
  w_p = z(1:Np);                            % portfolio's weights optimized
  mu_p = mu_s'*w_p;                         % portfolio's return optimized
  var_p = w_p'*S*w_p;                       % portfolio's variance optimized
  sd_opt = sqrt(var_p);                     % portfolio's standard deviation
end