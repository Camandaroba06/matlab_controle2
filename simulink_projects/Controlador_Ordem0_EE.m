% clear;
% clc;
close all;
s = tf('s');
% Vin = 50;
% L=100*10^(-3);
% Cap=220*10^(-6);
% R=50;
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
controlab_vet = ctrb(A,B);
disp('Rank da matriz de controlabilidade:');
disp(rank(controlab_vet));


% Ordem 0


A_aum = [A [0;0]; -C 0]
B_aum = [B;0]
C_aum = [C 0]
% poles = [-12390.30540260398 + 22393.13891451005i 12390.30540260398 - 22393.13891451005i -471.91444731728];
% poles = [-8 + 10.91501083i -8 - 10.91501083i -100]
% poles = [-8 -100 -200]
poles = [-8000 + 8389.51512813j -8000 - 8389.51512813j -200000]
K_aum = acker(A_aum, B_aum, poles)

A_aum_mf = A_aum - (B_aum*K_aum)
B_aum_mf = [0;0;1]
% B_aum_mf = [B;1]
C_aum_mf = C_aum
D_aum_mf = 0
sys_aum = ss(A_aum,B_aum,C_aum,0)


sys_mf_aum = ss(A_aum_mf,B_aum_mf,C_aum_mf,D_aum_mf)

figure;
rlocus(sys_aum)
grid on;
title('Diagrama de Root Locus da Função de Transferência G aumentada');

figure;
rlocus(sys_mf_aum)
grid on;
title('Diagrama de Root Locus da Função de Transferência Aumentada aplicado controle ordem 0');
figure;
step(sys_mf_aum,7*(10^-4))
grid on;
title('Resposta ao Degrau aplicado Servossistema ordem 0 da Função de Transferência Aumentada');
display(K_aum)
% K= place(A_aum,B_aum,[-100 -400 -500])
% K= place(A_aum,B_aum,[-8 -100 -200])



sys_tf = tf(sys_mf_aum)
[y, t] = step(sys_tf,10);

% Erro de regime permanente para uma entrada de degrau unitário
erro = 1 - y(end); % O erro é 1 - o valor final da resposta ao degrau

disp(['Erro de regime permanente: ', num2str(erro)]);


setpoint = 1
figure();
t=(10^-3)*(0:0.0000006:1);                                 
opts = stepDataOptions('StepAmplitude',setpoint);            
[y,t]= step(sys_mf_aum, t,opts);                            
plot(t,y);                                          
grid on;                                              
xlabel('Tempo(segundos)', 'FontSize', 16)                                 
ylabel('Amplitude(V)', 'FontSize', 16)                                    
title('Resposta ao Degrau Malha Fechada EE com Integrador', 'FontSize', 20)
set(gca, 'FontSize', 12);   % Aumenta o tamanho da fonte dos ticks dos eixos x e y

sys_commintEE = sys_mf_aum