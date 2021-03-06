%% Initialization
clear ; close all; clc

n=8; % Assets
h=9; % Historic data to calculate mean and volatility

X = zeros(n,h)

X(1,:) = [6.98;	0.64;	11.74;	-2.63;	-2.38;	1.63;	3.19;	4.13;	3.22]
X(2,:) = [2.26;	-1.85;	10.66;	-1.95;	-0.31;	0.84;	0.56;	3.92;	0.67]
X(3,:) = [3.96;	0.22;	9.25;	-3.47;	-4.82;	0.29;	2.24;	2.79;	3.62]
X(4,:) = [0.07;	1.29;	1.46;	0.47;	0.71;	1.03;	1.30;	1.65;	0.89]
X(5,:) = [1.44;	1.80;	6.51;	0.46;	0.36;	1.70;	5.10;	4.97;	1.41]
X(6,:) = [2.87;	-0.54;	10.03;	-1.96;	-1.08;	0.96;	0.72;	4.38;	2.22]
X(7,:) = [5.08;	3.01;	7.52;	-1.88;	-1.21;	1.39;	1.43;	6.41;	6.85]
X(8,:) = [1.18;	3.52;	4.05;	-0.19;	0.77;	0.91;	0.29;	3.47;	-0.42]

Rm = mean (X,2)

for i=1:n
  for j=1:n
    S (i,j) = cov (X(i,:),X(j,:))
  endfor
endfor

EfficientFrontier(S,Rm);




%a = [1.1; 1.7; 2.1; 1.4; 0.2 ]
%b = [3.0; 4.2; 4.9; 4.1; 2.5 ]
% cov(a,b)


