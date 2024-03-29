function [c,ceq] = constraint1BitKlvl(x)

load noiseParaKlvl.mat

%M = length(x)/3;

% x1R = x(1);
% x1I = x(2);
% x2R = x(3);
% x2I = x(4);
% x3R = x(5);
% x3I = x(6);
% x4R = x(7);
% x4I = x(8);
% x5R = x(9);
% x5I = x(10);
% x6R = x(11);
% x6I = x(12);
% x7R = x(13);
% x7I = x(14);
% x8R = x(15);
% x8I = x(16);
% x9R = x(17);
% x9I = x(18);
% px1 = x(19);
% px2 = x(20);
% px3 = x(21);
% px4 = x(22);
% px5 = x(23);
% px6 = x(24);
% px7 = x(25);
% px8 = x(26);
% px9 = x(27);

c = [ -x(19), -x(20) , -x(21), -x(22), -x(23), -x(24), -x(25), -x(26), -x(27)];
ceq = [ x(19) + x(20) + x(21) + x(22) + x(23) + x(24) + x(25) + x(26) + x(27) - 1, ...
    x(19)*(x(1)^2 + x(2)^2) + ...
    x(20)*(x(3)^2 + x(4)^2) + ...
    x(21)*(x(5)^2 + x(6)^2) + ...
    x(22)*(x(7)^2 + x(8)^2) + ...
    x(23)*(x(9)^2 + x(10)^2) + ...
    x(24)*(x(11)^2 + x(12)^2) + ...
    x(25)*(x(13)^2 + x(14)^2) + ...
    x(26)*(x(15)^2 + x(16)^2) + ...
    x(27)*(x(17)^2 + x(18)^2) - TotalPower];