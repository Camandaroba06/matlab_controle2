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

OS = 0.1
% Ts = 0.5;


% Not filter
G = (num/(s^2 + s*den_1 + den_2))
wn = sqrt(den_2)
zeta_not = (den_1)/(2*wn)
wo_not = wn

not_filter = (s^2 + 2*zeta_not*wo_not*s + wo_not^2)/((s+wo_not)^2)

open_loop = G*not_filter % N * G * Vin (aqui o ganho K entrou), logo é meu open loop NGK (perfeito isso)


% PI controller
% open_loop = ftma_notchada 
zeta = sqrt(((log(OS))^2)/((log(OS))^2+ pi^2)) % Calculo o zeta desejado
% PM = atan((2*zeta)/(sqrt(sqrt(1+4*zeta^4)-2*zeta^2)))
PM = rad2deg(atan((2*zeta) / sqrt(-2*zeta^2 + sqrt(1 + 4*zeta^4)))); %Calculo a PM desejada a partir desse zeta

% wc = (4/(Ts*zeta))*(sqrt(1-2*zeta^2+sqrt(zeta^4 - 4*zeta^2 +2)))



PI = (s+wo_not)/s % Utilizo da estrutura do PI SEM O KP (o KP irá vir dps com o objetivo de subir ou descer meu bode e obter o PM)
open_loop_PI = PI*open_loop % Sem Kp

p = PM-180; % Calculo a fase onde terei a PM desejada
[mag,phase,wout] = bode(open_loop_PI);

mag_p = interp1( squeeze(phase), squeeze(mag), p)
w_p   = interp1( squeeze(phase), wout, p)


% [mag,fase]=bode(open_loop_PI,wc)
Kp = 1/mag_p

figure;
grid on;
margin(open_loop_PI)
legend("Bode para open_loop_PI SEM KP")



figure();
[GM, PM_plot, Wcg, Wcp] = margin(open_loop_PI);  % Calcula as margens de ganho (GM), fase (PM), e suas respectivas frequências de cruzamento
margin(open_loop_PI);  % Gera o diagrama de margem de ganho e fase da função de transferência G
grid on;

% Adiciona os valores de GM e PM ao título
title(sprintf('Margem de Ganho: %.2f dB, Margem de Fase: %.2f°, Wc: %.2f', 20*log10(GM), PM_plot, Wcp), 'FontSize', 16);

% Ajusta o tamanho da fonte dos labels dos eixos
xlabel('Frequência', 'FontSize', 14);
ylabel('Fase', 'FontSize', 14);

% Ajusta o tamanho da fonte dos ticks dos eixos
set(gca, 'FontSize', 12);



% Kp = 0.0048172367584
% figure;
% grid on;
% step(feedback(Kp*open_loop_PI,1))

figure();
[GM, PM_plot, Wcg, Wcp] = margin(Kp*open_loop_PI);  % Calcula as margens de ganho (GM), fase (PM), e suas respectivas frequências de cruzamento
margin(Kp*open_loop_PI);  % Gera o diagrama de margem de ganho e fase da função de transferência G
grid on;

% Adiciona os valores de GM e PM ao título
title(sprintf('Margem de Ganho: %.2f dB, Margem de Fase: %.2f°, Wc: %.2f', 20*log10(GM), PM_plot, Wcp), 'FontSize', 16);

% Ajusta o tamanho da fonte dos labels dos eixos
xlabel('Frequência', 'FontSize', 14);
ylabel('Fase', 'FontSize', 14);

% Ajusta o tamanho da fonte dos ticks dos eixos
set(gca, 'FontSize', 12);


% title("Resposta ao Degrau para open_loop_PI com KP")

% figure;
% grid on;
% margin((open_loop_PI))


figure;
grid on;
margin((Kp*open_loop_PI))
% legend("Bode para open_loop_PI COM KP")

display("Controle Finalizado por Filtro Notch:")
display(Kp*PI)

PI_final = Kp*PI % Adiciono o Kp obtido no PI e agr sim tenho um PI completinho


PI_N = Kp*((s^2 + s*den_1 + den_2)/(s*(s+wo_not)))
% step(feedback(PI_N*G,1))
T = 1/100000
PI_discreto = c2d(PI_final,T,'tustin')




figure();
t=(10^-3)*(0:0.0000006:1);                                 
opts = stepDataOptions('StepAmplitude',setpoint);            
[y,t]= step(feedback(G*PI_final,1), t,opts);                            
plot(t,y);                                          
grid on;                                              
xlabel('Tempo(segundos)', 'FontSize', 16)                                 
ylabel('Amplitude(V)', 'FontSize', 16)                                    
title('Resposta ao Degrau para Malha Aberta', 'FontSize', 20)
set(gca, 'FontSize', 12);   % Aumenta o tamanho da fonte dos ticks dos eixos x e y

malhafechadacontrolada_extbode = feedback(G*PI_final,1)
