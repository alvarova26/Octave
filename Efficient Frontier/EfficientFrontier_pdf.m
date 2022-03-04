
return_opt = 4;
%R = corrcoef(X); % correlation matrix of daily returns
%S = cov(X,1); % covariance matrix of daily returns
S = [185 86.5 80 20; 86.5 196 76 13.5; 80 76 411 -19; 20 13.5 -19 25]; % example
%mu = mean(X); % average daily rate of return
mu = [14; 12; 15; 7]; % example
vx = sqrt(diag(S))'; % variance of daily return

Np = size(mu); % number of stocks in portfolio
%
% If a target rate of return is specified, perform a perfolio optimization with
% this constraint. Otherwise, use the global minimum variance solution.
%
if(isnan(return_opt)) % global minimum?variance Markowitz portfolio
  [w, mu_opt, v_opt] = MPglobalMinimumVariance(mu, Np, S);
else % Markowitz portfolio with specified rate of return
  [w, mu_opt, v_opt] = MPconstrainedReturn(mu, S, Np, T, return_opt);
end


function [w, mu_opt, v_opt] = MPglobalMinimumVariance(mu, Np, S)
A = [ 2*S ones(1,Np)' ; ones(1,Np) 0 ];
b = [ zeros(1,Np) 1 ]';
z = A\b; % solve Ax=b
w = z(1:Np); % assign portfolio weights
mu_opt = mu*w; % mean portfolio return
v_opt = w'*S*w; % portfolio variance
sd_opt = sqrt(v_opt); % portfolio standard deviation
