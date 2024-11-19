clc;
close all;
s = tf('s');
Vin = 12;
L=0.001;
C=3.3*10^(-6);
R=12;
num = (Vin/(L*C));
den_1 = 1/(R*C);
den_2 = (1/(L*C));

G = num/(s^2 + s*den_1 + den_2)
% C = 0.08532899*((s+3)/s)
% malhafechada = feedback(G*C,1)
% step(malhafechada)
% margin(G)
Ts = 0.0005 % Sem controle o Ts costuma ser 0.000311 segundos.
mp = 65.8
% Ts = 0.0005 % Sem controle o Ts costuma ser 0.000311 segundos.
% mp = 65.8
% zeta = mp/100
zeta = 0.7
% wc = 4*(sqrt(1-2*zeta^2+sqrt(zeta^4 - 4*zeta^2 +2)))/Ts
wc = 4*(sqrt(1-2*zeta^2+sqrt(zeta^4 - 4*zeta^2 +2)))/(Ts*zeta)
% wc = bw/1.5
% wc = 30000
% mp = 65.8
% mp = 12
% wc = 300
[mag,fase]=bode(G,wc)
a = wc/(tand(-90+mp-fase))
C = ((s+a)/s)
figure;
grid on;
margin(G)
% hold on
% bode(C)
% bode(C*G)

[mag1,fase1]=bode(G*C,wc)
k = 1/mag1
C = (k*(s+a)/s)
figure;
grid on;
margin(G*C)
malhafechada = feedback(G*C,1)
figure;
grid on;
step(malhafechada)
pole(malhafechada)
display(C)
display(wc)

figure;
grid on;
nyquist(G*C)
figure;
grid on;
margin(G/s)


display("Controle Finalizado por Resp Freq utilizando aprox para segunda ordem:")
display(C)