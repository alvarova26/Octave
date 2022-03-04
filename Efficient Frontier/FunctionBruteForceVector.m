function [ro,vo,io,thetax] = FunctionBruteForceVector(m,max_risk)
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

n=8; % Assets
h=9; % Historic data to calculate mean and volatility
m = 100; % Repetitions

X = zeros(n,h);

X(1,:) = [6.98; 0.64;	11.74;	-2.63;	-2.38;	1.63;	3.19;	4.13;	3.22];
X(2,:) = [2.26;	-1.85;	10.66;	-1.95;	-0.31;	0.84;	0.56;	3.92;	0.67];
X(3,:) = [3.96;	0.22;	9.25;	-3.47;	-4.82;	0.29;	2.24;	2.79;	3.62];
X(4,:) = [0.07;	1.29;	1.46;	0.47;	0.71;	1.03;	1.30;	1.65;	0.89];
X(5,:) = [1.44;	1.80;	6.51;	0.46;	0.36;	1.70;	5.10;	4.97;	1.41];
X(6,:) = [2.87;	-0.54;	10.03;	-1.96;	-1.08;	0.96;	0.72;	4.38;	2.22];
X(7,:) = [5.08;	3.01;	7.52;	-1.88;	-1.21;	1.39;	1.43;	6.41;	6.85];
X(8,:) = [1.18;	3.52;	4.05;	-0.19;	0.77;	0.91;	0.29;	3.47;	-0.42];



% initial values (m = tries | n = funds)
ro = 0; % initialize optimal fund's return
io = 1; % initialize optimal parameters of parameter's matrix
vo = 0; % initialize optimal fund's volatility
Rm = mean (X,2); % Vector of mean expected fund's return
Rm = Rm';
Vm = var (X',1); % Vector of fund's variance
n = size(Rm,2);
thetax = zeros(m,n); % initialize parameter's matrix
thetax(1,:) = [0.125 0.125 0.125 0.125 0.125 0.125 0.125 0.125]; % initial equally weighted parameters
Rp = zeros(m,1); % initialize fund's return vector
Vp = zeros(m,1); % initialize fund's volatility vector


%  Portfolio risk and return
Rp(1,:) = thetax(1,:)*Rm';
Vp(1,:) = thetax(1,:)*Vm';
figure(1);
plot(Vp(1,1), Rp(1,1), 'k+','LineWidth', 1, 'MarkerSize', 7);
hold on;

% Labels and Legend
ylabel('Expected return');
xlabel('Risk (volatility)');

for i=1:m
  thetax(i,:)= rand(1, n);
  thetax(i,:)= thetax(i,:) / sum (thetax(i,:));
end

Rp = thetax*Rm';
Vp = thetax*Vm';



thetax(io,:)'
