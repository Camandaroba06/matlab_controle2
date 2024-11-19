clear;
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
% C = 0.64/s;
% C = (s*(-0.083263890659)+0.00064948742146)/s;
C = 0.1*((s+850)/s);
% C = (-0.0832222422594*s + 0.00127098212181)/s



% figure;
% step(G);
% title('Resposta ao Degrau da Função de Transferência em Malha Aberta');
% xlabel('t(segundos)')
% ylabel('Amplitude');
% grid on;
setpoint = 1
figure();
t=(10^-3)*(0:0.0000006:1);                                 
opts = stepDataOptions('StepAmplitude',setpoint);            
[y,t]= step(G, t,opts);                            
plot(t,y);                                          
grid on;                                              
xlabel('Tempo(segundos)', 'FontSize', 16)                                 
ylabel('Amplitude(V)', 'FontSize', 16)                                    
title('Resposta ao Degrau para Malha Aberta', 'FontSize', 20)
set(gca, 'FontSize', 12);   % Aumenta o tamanho da fonte dos ticks dos eixos x e y



figure();
rlocus(G);  % Gera o diagrama de lugar das raízes da função de transferência G
grid on;                                              
xlabel('Parte Real', 'FontSize', 14);  % Aumenta o tamanho da fonte do label do eixo x                                
ylabel('Parte Imaginária', 'FontSize', 14);  % Aumenta o tamanho da fonte do label do eixo y                                   
title('Lugar das Raízes de G(s)', 'FontSize', 16);  % Aumenta o tamanho da fonte do título
% Ajustando o tamanho da fonte dos ticks dos eixos
set(gca, 'FontSize', 12);  % Aumenta o tamanho da fonte dos ticks dos eixos x e y




figure();
[GM, PM, Wcg, Wcp] = margin(G);  % Calcula as margens de ganho (GM), fase (PM), e suas respectivas frequências de cruzamento
margin(G);  % Gera o diagrama de margem de ganho e fase da função de transferência G
grid on;

% Adiciona os valores de GM e PM ao título
title(sprintf('Margem de Ganho: %.2f dB, Margem de Fase: %.2f°', 20*log10(GM), PM), 'FontSize', 16);

% Ajusta o tamanho da fonte dos labels dos eixos
xlabel('Frequência', 'FontSize', 14);
ylabel('Fase', 'FontSize', 14);

% Ajusta o tamanho da fonte dos ticks dos eixos
set(gca, 'FontSize', 12);




figure;
sistemamalhafechada = feedback(G, 1)
step(sistemamalhafechada);
title('Resposta ao Degrau da Função de Transferência em Malha Fechada Sem Controlador');
xlabel('Tempo (s)');
ylabel('Amplitude');
grid on;

figure;
sistemamalhafechada_control = feedback(G*C, 1);
step(sistemamalhafechada_control);
title('Resposta ao Degrau da Função de Transferência em Malha Fechada Com Controlador');
xlabel('Tempo (s)');
ylabel('Amplitude');
grid on;


figure;
bode(G);
grid on;
title('Diagrama de Bode da Função de Transferência G');

% figure;
% rlocus(G);
% grid on;
% title('Diagrama de Root Locus da Função de Transferência G');



poles_G = pole(G);
zeros_G = zero(G);


disp('Polos de G:');
disp(poles_G);
disp('Zeros de G:');
disp(zeros_G);


sys_ss = ss(G)


eigenvalues_G = eig(sys_ss.A);


disp('Autovalores de G:');
disp(eigenvalues_G);

C_discret = c2d(C,0.0001,'tustin')


G_discret = c2d(G,0.0001,'tustin')
sistemamalhafechada_discret = feedback(G_discret*C_discret, 1);
figure;
step(sistemamalhafechada_discret);
title('Resposta ao Degrau da Função de Transferência em Malha Fechada Com Controlador Discreto');
xlabel('Tempo (s)');
ylabel('Amplitude');
grid on;



