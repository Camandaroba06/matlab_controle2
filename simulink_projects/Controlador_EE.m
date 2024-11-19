clear;
clc;
close all;
s = tf('s');
Vin = 12;
L=0.001;
Cap=3.3*10^(-6);
R=12;

% Regulador (n faz sentido na minha head)


A = [(-1/(R*Cap)) 1/Cap; -1/L 0]
B = [0; Vin/L]
C = [1 0]
D = [0]

sys = ss(A, B, C, D)
controlab_vet = [B A*B];
disp('Rank da matriz de controlabilidade:');
disp(rank(controlab_vet));

% poles = [-12390.30540260398 + 22393.13891451005i 12390.30540260398 - 22393.13891451005i]; %só colocar polos desejados aqui
poles = [-8 + 10.91501083i -8 - 10.91501083i];
K = acker(A, B, poles)
A_k = A - (B*K)
% B_k = B*K(1)
B_k = [0;1]
% B_aum_mf = [B;1]
C_k = C
D_k = 0
sys_k = ss(A_k,B_k,C_k,0)


figure;
rlocus(sys_k)
grid on;
title('Diagrama de Root Locus da Função de Transferência sys_k');
figure;
step(sys_k)
grid on;
title('Resp ao degrau da Função de Transferência sys_k');




% Ordem 0


A_aum = [A [0;0]; -C 0]
B_aum = [B;0]
C_aum = [C 0]
% poles = [-12390.30540260398 + 22393.13891451005i 12390.30540260398 - 22393.13891451005i -471.91444731728];
poles = [-8 + 10.91501083i -8 - 10.91501083i -100]
K_aum = acker(A_aum, B_aum, poles)

A_aum_mf = A_aum - (B_aum*K_aum)
B_aum_mf = [0;0;1]
% B_aum_mf = [B;1]
C_aum_mf = C_aum
D_aum_mf = 0
sys_aum = ss(A_aum,B_aum,C_aum,0)

figure;
rlocus(sys_aum)
grid on;
title('Diagrama de Root Locus da Função de Transferência G aumentada');
sys_mf_aum = ss(A_aum_mf,B_aum_mf,C_aum_mf,D_aum_mf)
figure;
rlocus(sys_mf_aum)
grid on;
title('Diagrama de Root Locus da Função de Transferência Aumentada aplicado controle ordem 0');
figure;
step(sys_mf_aum)
grid on;
title('Resposta ao Degrau aplicado Servossistema ordem 0 da Função de Transferência Aumentada');