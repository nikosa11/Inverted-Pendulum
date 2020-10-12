clear all 

M = 0.160;
m = 0.050;
b = 0.3;
I = 2.6880*10^(-5);
g = 9.8;
l = 0.08;
q = (M+m)*(I+m*l^2)-(m*l)^2;
s = tf('s');
p = I*(M+m)+M*m*l^2; 

A = [0      1              0           0;
     0 -(I+m*l^2)*b/p  (m^2*g*l^2)/p   0;
     0      0              0           1;
     0 -(m*l*b)/p       m*g*l*(M+m)/p  0];
B = [     0;
     (I+m*l^2)/p;
          0;
        m*l/p];
C = [1 0 0 0;
     0 0 1 0];
D = [0;
     0];

states = {'x' 'x_dot' 'phi' 'phi_dot'};
inputs = {'u'};
outputs = {'x'; 'phi'};

T = ss(A,B,C,D,'statename',states,'inputname',inputs,'outputname',outputs)
Kp = 100;
Ki = 100;
Kd = 100;
C = pid(Kp,Ki,Kd);
%%G = feedback(T(2),C);
t=0:0.01:10;
%K=200;
%C=((s+1.4229)*(s+15))/(s*(s+100)*(s+50))
G = feedback(T(2),C);
%pole(G)
