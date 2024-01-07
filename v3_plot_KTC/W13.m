function W = W13(x)

load noiseParaKlvl.mat

x1 = (-mR*real(x)+mI*imag(x))/abs(m);
x2 = (-mI*real(x)-mR*imag(x))/abs(m);


s12 = sqrt(2)/sqrt(gammaH^2*abs(x)^2+sig_N)*( q - abs(m)*x1);

s22 = sqrt(2)/sqrt(gammaH^2*abs(x)^2+sig_N)*( q - abs(m)*x2);

W = (qfunc(s12))*(qfunc(s22));

