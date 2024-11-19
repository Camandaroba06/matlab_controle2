clear;
clc;
close all;

s = tf('s');
G_semnada = 100.6/(s+10);
% C = 0.35624/s;
C= 0.0193734759588639+0.557695071368511/s;


info_ftma = stepinfo(G_semnada)
info_ftma_mf = stepinfo(feedback(G_semnada,1))
step(0.1*G_semnada)
hold on
step(feedback(G_semnada,1))
step(feedback(G_semnada*C,1))

info_ftmaC_mf = stepinfo(feedback(G_semnada*C,1))
disp(info_ftmaC_mf.RiseTime/15)
disp(info_ftmaC_mf.RiseTime/20)
Cz = c2d(C, info_ftmaC_mf.RiseTime/20, 'tustin')
disp(Cz)