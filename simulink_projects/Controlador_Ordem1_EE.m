% clear;
% clc;
close all;
s = tf('s');
Vin = 12;
L = 0.001;
Cap = 3.3e-6;
R = 12;

A = [(-1/(R*Cap)) 1/Cap; -1/L 0];
B = [0; Vin/L];
C = [1 0];
D = [0];

sys = ss(A, B, C, D);


controlab_vet = ctrb(A,B);
disp('Rank da matriz de controlabilidade:');
disp(rank(controlab_vet));

% poles = [-8 + 10.91501083i -8 - 10.91501083i];
% poles = [-8000 + 10915.0108308i -8000 - 10915.0108308i];
% poles = [(-28.5714285714+81.61632i) (-28.5714285714-81.61632i)]
% poles = [-100 -400]
poles = [-8000 + 8389.51512813j -8000 - 8389.51512813j]
K = acker(A, B, poles)

A_k = A - B*K;


B_k = B

C_k = C;
D_k = 0;
sys_k = ss(A_k, B_k, C_k, D_k);
eig(A_k)




%Ganho CC para calculo do kr:
GanhoCC = dcgain(sys_k)
kr = 1/GanhoCC


Amfca = A-B*K
Bmfca = B*kr
Cmfca = C
Dmfca = D

sys_k_att = ss(Amfca,Bmfca,Cmfca,Dmfca)












figure;
rlocus(sys_k_att);
grid on;
title('Diagrama de Root Locus da Função de Transferência sys_k');


figure;
step(sys_k_att);
grid on;
title('Resposta ao Degrau da Função de Transferência sys_k');

sys_tf = tf(sys_k_att)
[y, t] = step(sys_tf);

% Erro de regime permanente para uma entrada de degrau unitário
erro = 1 - y(end); % O erro é 1 - o valor final da resposta ao degrau

disp(['Erro de regime permanente: ', num2str(erro)]);

setpoint = 1
figure();
t=(10^-3)*(0:0.0000006:1);                                 
opts = stepDataOptions('StepAmplitude',setpoint);            
[y,t]= step(sys_k_att, t,opts);                            
plot(t,y);                                          
grid on;                                              
xlabel('Tempo(segundos)', 'FontSize', 16)                                 
ylabel('Amplitude(V)', 'FontSize', 16)                                    
title('Resposta ao Degrau Malha Fechada EE sem Integrador', 'FontSize', 20)
set(gca, 'FontSize', 12);   % Aumenta o tamanho da fonte dos ticks dos eixos x e y
sys_semintEE = sys_k_att
