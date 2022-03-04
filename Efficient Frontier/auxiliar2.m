%% Initialization
clear ; close all; clc

times = 100;

for i=1:times
  [ro,vo,io,thetao] = FunctionBruteForce(100000,5);
  Ro(i,:)=ro;
  Vo(i,:)=vo;
  Io(i,:)=io; 
  Thetao(i,:)=thetao;

  figure(2);
  plot(vo, ro, 'k+','LineWidth', 1, 'MarkerSize', 5,'Color', 'r');
  ylabel('Expected return');
  xlabel('Risk (volatility)');
  hold on;
endfor
