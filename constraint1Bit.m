function [c,ceq] = constraint1Bit(x)

load noisePara.mat

N = length(x)/3;

px = x(1:N);
x1 = x(N+1:2*N);
x2 = x(2*N+1:3*N);

c = [  ];
ceq = [ sum(px) - 1, px(1)*(x1(1)^2 + x1(2)^2) + px(2)*(x2(1)^2 + x2(2)^2) - TotalPower];