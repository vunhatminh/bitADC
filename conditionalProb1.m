function condProb= conditionalProb1(x)

load noisePara.mat

mR = real(m);
mI = imag(m);

x1 = (-mR*real(x)+mI*imag(x))/abs(m);
x2 = (-mI*real(x)-mR*imag(x))/abs(m);
s1 = sqrt(2)*abs(m)*x1/sqrt(gammaH^2*abs(x)^2+sig_N);
s2 = sqrt(2)*abs(m)*x2/sqrt(gammaH^2*abs(x)^2+sig_N);

condProb = pB/4 + (1-pB)*qfunc(s1)*qfunc(s2);