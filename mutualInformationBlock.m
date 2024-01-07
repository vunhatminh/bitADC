 function obj= mutualInformationBlock(x)

load noisePara.mat
load GL.mat;

N = length(x)/3;

px = x(1:N);
x1 = x(N+1:2*N);
x2 = x(2*N+1:3*N);

x1c = x1(1) + 1j*x1(2);
x2c = x2(1) + 1j*x2(2);

hy = log(4);

W1 = zeros(1,M);
W1 = [conditionalProb1(x1c),conditionalProb1(x2c)];
W2 = zeros(1,M);
W2 = [conditionalProb2(x1c),conditionalProb2(x2c)];
W3 = zeros(1,M);
W3 = [conditionalProb3(x1c),conditionalProb3(x2c)];
W4 = zeros(1,M);
W4 = [conditionalProb4(x1c),conditionalProb4(x2c)];

hyx = - px(1)*( W1(1)*log(W1(1)) +  W2(1)*log(W2(1))+ W3(1)*log(W3(1)) + W4(1)*log(W4(1)) ) ...
    - px(2)*( W1(2)*log(W1(2)) +  W2(2)*log(W2(2))+ W3(2)*log(W3(2)) + W4(2)*log(W4(2)) );



obj1 = hy - hyx;
obj = -obj1;