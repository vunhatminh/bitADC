clc
clear all 

sig_N = 1;
gammaH = 1;
pB = 0.1;
m = 0.5;

TotalPower = 10;

M = 3; % mass point

save noisePara.mat TotalPower sig_N M m pB gammaH; 


%save noiseParaZ3ant.mat Pz H sig_N;

% Optimize on X
x = [0 0 0 0 0 0];

%x = sqrt(TotalPower/(4*Tx))*ones(1,6*M);

x(5) = sqrt(TotalPower/2);
x(6) = sqrt(TotalPower/2);
px = ones(1,M)/M;
 
x0(1:M) = px;
x0(M+1:3*M) = x;
         
lb = zeros(1,M);% - 0.000000000000001*ones(1,2*M);
 
gs = GlobalSearch;
opts = optimset('Display','iter','Algorithm','interior-point', 'TolFun',1e-8);
        problem = createOptimProblem('fmincon','x0',x0,...
        'objective',@mutualInformationBlock3,'lb',lb,'nonlcon',@constraint1Bit3,'options',opts);
        [x_max_f,fval] = run(gs,problem)

% p_z = x(1:M);
% z = x(M+1:2*M);
% C = -fval;
% 
% Capacity(iter) = C;
% 
% 
% 
% plot(Power,Capacity);
%{
        p_k = x_max_f(1:M);
        r_k1 = x_max_f(M+1:2:3*M);
        r_k2 = x_max_f(M+2:2:3*M);
        
        r_k =zeros(1,M);

        for i = 1:M
            r_k(i) = sqrt([r_k1(i) r_k2(i)]*H*[r_k1(i) r_k2(i)]');
        end
        
% Solve for gamma
C = - fval;


theRHS = RHS(r_k(1),r_k,p_k) + log(sig_N^2+r_k(1)^2)+C+1;
gamma = theRHS/(Pz - r_k(1)^2);

% theRHS1 = RHS(r_k(1),r_k,p_k) + log(sig_N^2+r_k(1)^2)+C+1;
% theRHS2 = RHS(r_k(2),r_k,p_k) + log(sig_N^2+r_k(2)^2)+C+1;
% theRHS3 = RHS(r_k(3),r_k,p_k) + log(sig_N^2+r_k(3)^2)+C+1;
% alpha = (r_k(1)^2 - r_k(3)^2)/(theRHS3-theRHS1);
% gamma = (theRHS1+r_k(1)^2/alpha)/2/P1;

r=0:1e-2:ceil(max(r_k))*2;

for i = 1:length(r);
            ktc(i) = RHS(r(i),r_k,p_k) + log(1+r(i)^2)- gamma*Pz + gamma*r(i)^2 + C+1; 
end

figure;
plot(r,ktc);
hold on;
plot(r,r-r,'r');
     
gamma1 = gamma*(H(1,1) + H(1,2)/sqrt(P1/P2));
gamma2 = gamma*(H(2,2) + H(1,2)/sqrt(P2/P1));

r=-ceil(max(r_k)):5*1e-2:ceil(max(r_k));

x1 = r;
x2 = r;
%x2 = r*exp(-1j*0.3*pi);

ktc2 = zeros(length(r));
rz = zeros(length(r));

for i = 1:length(r);
    for j =1:length(r);
        r_x = sqrt([x1(i) x2(j)]*H*[x1(i) x2(j)]');
        
        %r_x =sqrt( x1(i)^2+x2(j)^2);
        %rz(i,j) = r_x;
        
        %ktc2(i,j) = RHS(r_x,r_k,p_k) + log(1+r_x^2)- gamma1*P1 - gamma2*P2 + gamma1*x1(i)^2 + gamma2*x2(j)^2 + C+1;
        ktc2(i,j) = RHS(r_x,r_k,p_k) + log(1+r_x^2)- gamma1*P1 - gamma2*P2 + gamma1*x1(i)^2 + gamma2*abs(x2(j))^2 + C+1;
        %ktc2(i,j) = RHS(rz(i,j),r_k,p_k) + log(1+rz(i,j)^2)- gamma1*P1 - gamma2*P2 + gamma*rz(i,j)^2 + C+1;
                
    end
end

figure;
%surf(real(ktc2));
surf(x1,x2,ktc2,'FaceAlpha',0.8);



%}









        
