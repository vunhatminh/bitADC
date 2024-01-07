function [c,ceq] = constraint1Bit3(x)

load noisePara.mat

N = length(x)/3;

px = x(1:N);
x1 = x(N+1:N+2);
x2 = x(N+3:N+4);
x3 = x(N+5:N+6);


c = [  ];
ceq = [ sum(px) - 1, px(1)*(x1(1)^2 + x1(2)^2) + px(2)*(x2(1)^2 + x2(2)^2) + px(3)*(x3(1)^2 + x3(2)^2)- TotalPower];