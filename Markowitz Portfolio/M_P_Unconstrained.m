function [w_p, mu_p, var_p] = M_P_Unconstrained(mu_s, Np, Ns, S)

% WORKING AS EXPECTED - CHECKED!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!

% Markowitz Portfolio Optimization - Unconstrained
%
% minimize: var_p = w_p'*S*w_p
% subject to: w_p'*O = 1
%
% where
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
% A * x = b
%
% | 2S O | * |   w_p   | = | Z |
% | O' 0 |   | lambda2 |   | 1 |
%
% where
% S       => Matrix of covariance of returns of stock with each other (NpxNp dimensions)
% w_p     => portfolio's weights optimized
% O       => ones vector
% Z       => zeros vector
% lambda2 => Lagrange multiplier
%
%
% Markowitz linear equations
  A = [ 2*S ones(1,Np)' ; ones(1,Np) 0 ];
  b = [ zeros(1,Np) 1 ]';
  z = A\b;                                  % solve Ax=b
  w_p = z(1:Np);                            % portfolio's weights optimized
  mu_p = mu_s'*w_p;                         % portfolio's return optimized
  var_p = w_p'*S*w_p;                       % portfolio's variance optimized
  sd_opt = sqrt(var_p);                     % portfolio's standard deviation
end
