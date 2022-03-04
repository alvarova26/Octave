%% Initialization
clear ; close all; clc

%% Load Data
%  rx is the vector containing the return of the investment's fund
%  vx is the vector containing the risk (volatility) of the investment's fund
%  rp is the return of the portfolio
%  vp is the risk of the portfolio
%  ro is the optimal return of the portfolio
%  vo is the optimal risk of the portfolio
%  io is the index o thetax matrix for optimal portfolio
%  thetax is the vector containing the parameters with the weight assigned to
%  each fund - it will be randomly generated

n=12; % Assets
h=16; % Historic data to calculate mean and volatility

R = zeros(n,h);

R(1,:) = [0.58 0.79 0.54 -0.54 1.60 1.3500 0.1700 1.0000 2.0800 1.6800 0.5200 0.5000 0.2100 1.3000 1.4500 0.9100];
R(2,:) = [0.58 0.48 1.16 -0.35 1.57 1.6600 -0.0300 0.8900 1.6500 1.3000 1.0300 0.7100 0.4700 1.4600 1.2900 0.0700];
R(3,:) = [0.25 -0.05 2.52 -4.14 4.56 3.6400 -0.8500 1.4100 4.9700 5.1000 1.7000 0.3600 0.4600 6.5100 1.8000 1.4400];
R(4,:) = [-0.21 0.10 1.09 0.23 0.91 0.4600 0.4000 0.8200 1.1600 0.6200 0.5200 0.3900 -0.1200 1.3000 1.0700 0.5000];
R(5,:) = [-8.54 -1.80 6.77 0.82 2.19 3.4100 -0.8200 0.6700 3.9200 0.5600 0.8400 -0.3100 -1.9500 10.6600 -1.8500 2.2600];
R(6,:) = [-6.10 0.63 10.36 4.80 -0.57 2.0200 1.8400 3.6200 2.7900 2.2400 0.2900 -4.8200 -3.4700 9.2500 0.2200 3.9600];
R(7,:) = [-7.55 -3.01 9.63 0.73 0.54 1.5500 0.1700 3.2200 4.1300 3.1900 1.6300 -2.3800 -2.6300 11.7400 0.6400 6.9800];
R(8,:) = [-8.31 0.73 12.18 4.50 2.58 3.1500 1.6400 6.8500 6.4100 1.4300 1.3900 -1.2100 -1.8800 7.5200 3.0100 5.0800];
R(9,:) = [-8.26 0.83 7.53 1.04 2.60 2.0700 -0.1000 2.2200 4.3800 0.7200 0.9600 -1.0800 -1.9600 10.0300 -0.5400 2.8700];
R(10,:) = [-6.85 1.27 9.45 1.37 1.20 0.3400 0.9900 3.8400 4.7600 2.0500 1.0800 -0.7000 -1.5100 8.4600 2.3500 2.8400];
R(11,:) = [-2.82 6.6200 -2.5100 8.7400 -1.7200 2.8900 6.8000 0.1000 4.4900 -6.7200 4.5400 5.5900 6.3500 1.1100 -8.2700 5.7100];
R(12,:) = [5.18 6.7000 -4.8000 5.1800 -2.8700 0.7800 8.4600 -0.6300 -2.0200 0.2100 0.5000 4.5200 2.7300 -5.5900 0.3600 4.1200];

%  Assets risk and return
Rm = mean (R,2); % Vector of mean expected fund's return
Rm = Rm';
Vm = var (R',1); % Vector of fund's variance
Cr = corr(R');
Cv = cov(R',1);

% initial values (m = tries - n = fund)
m = 10000;
n = size(Rm,2);
thetax = zeros(m,n); % initialize parameter's matrix
for i=1:n
  thetax(1,i) = 1/n;% initial equally weighted parameters
endfor
Rp = zeros(m,1); % initialize fund's return vector
Vp = zeros(m,1); % initialize fund's volatility vector

ro = 0; % initialize optimal fund's return
io = 1; % initialize optimal parameters of parameter's matrix
vo = 0; % initialize optimal fund's volatility
Rp(1,:) = thetax(1,:)*Rm';
Vp(1,:) = thetax(1,:)*Vm';
plot(Vp(1,1), Rp(1,1), 'k+','LineWidth', 1, 'MarkerSize', 7);
hold on;

% Labels and Legend
ylabel('Expected return');
xlabel('Risk (volatility)');

for i=1:m
  thetax(i,:)= rand(1, n);
  thetax(i,:)= thetax(i,:) / sum (thetax(i,:));
  Rp(i,1) = thetax(i,:)*Rm';
  Vp(i,1) = thetax(i,:)*Vm';
  if ((Vp(i,1) >= 4) && (Vp(i,1) <= 5))
    if (Rp(i,1) > ro)
      ro = Rp(i,1);
      vo = Vp(i,1);
      io = i;
    end
    plot(Vp(i,1), Rp(i,1), 'k+','LineWidth', 1, 'MarkerSize', 5,'Color', 'r');
  else
    plot(Vp(i,1), Rp(i,1), 'k+','LineWidth', 1, 'MarkerSize', 5,'Color', 'b');
  end
end

thetax(io,:)'

