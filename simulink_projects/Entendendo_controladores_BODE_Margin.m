clear;
clc;
close all;
s = tf('s');


% % P controller MG>=10db MF=60º
% G = 32/((s+2)*(s+8))
% K = 2.8
% 
% ma_controlada = G*K 
% figure;
% grid on;
% margin(G)
% figure;
% grid on;
% margin(ma_controlada)

% % I controller MG>=10db MF=60º
% G = 32/((s+2)*(s+8))
% C = 0.473151258/s
% G_bode_analisado = G/s
% ma_controlada = G*C 
% figure;
% grid on;
% margin(G_bode_analisado)
% figure;
% grid on;
% margin(ma_controlada)






G = 32/((s+2)*(s+8))
C = 30+(1/s)
G_bode_analisado = G/s
ma_controlada = G*C 
figure;
grid on;
margin(G)
figure;
grid on;
margin(ma_controlada)
figure;
grid on;
margin(C)