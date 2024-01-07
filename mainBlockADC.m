clc
clear all 

sig_N = 1;
gammaH = 1;
pB = 0;
m = 1;

TotalPower = 1;

M = 2; % mass point

save noisePara.mat TotalPower sig_N M m pB gammaH; 


%save noiseParaZ3ant.mat Pz H sig_N;

% Optimize on X
x = zeros(1,2*M);

%x = sqrt(TotalPower/(4*Tx))*ones(1,6*M);

x(2*M-1) = sqrt(TotalPower/2);
x(2*M) = sqrt(TotalPower/2);
px = ones(1,M)/M;
 
x0(1:M) = px;
x0(M+1:3*M) = x;
         
lb = zeros(1,3*M);% - 0.000000000000001*ones(1,2*M);
 
gs = GlobalSearch;
opts = optimset('Display','iter','Algorithm','interior-point', 'TolFun',1e-8);
        problem = createOptimProblem('fmincon','x0',x0,...
        'objective',@mutualInformationBlock,'lb',lb,'nonlcon',@constraint1Bit,'options',opts);
        [x_max_f,fval] = run(gs,problem)
        
        
Capacity = -fval;

x1R = x_max_f(5);
x1I = x_max_f(6);
limitRatio = 1 + 0.0001;

x1c = limitRatio*(x1R + 1j*x1I);
W1 = conditionalProb1(x1c);
W2 = conditionalProb2(x1c);
W3 = conditionalProb3(x1c);
W4 = conditionalProb4(x1c);

lambda =  (W1*log(W1) +  W2*log(W2)+ W3*log(W3) + W4*log(W4) - Capacity + log(4))/(abs(x1c)^2-TotalPower);

r=-2:0.02:2;

a1 = r;
a2 = r;

ktc2 = zeros(length(r));

for i = 1:length(r);
    for k =1:length(r);

        ac = a1(i)+1j*a2(k);
        W1 = conditionalProb1(ac);
        W2 = conditionalProb2(ac);
        W3 = conditionalProb3(ac);
        W4 = conditionalProb4(ac);
        
        ktc2(i,k) = -(W1*log(W1) +  W2*log(W2)+ W3*log(W3) + W4*log(W4))...
            + Capacity - log(4) + lambda*(abs(ac)^2-TotalPower);

                
    end
end


figure;
%surf(real(ktc2));
surf(a1,a2,ktc2,'FaceAlpha',0.9);










        
