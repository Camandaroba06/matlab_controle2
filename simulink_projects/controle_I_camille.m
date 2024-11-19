clear;
clc;
close all;


s = tf('s');

G = 10.8/(0.1*s+1);
C=64/s;

Cz = c2d(C,0.01,'tustin')
Gz = c2d(G,0.01,'tustin')
step(feedback(Cz*Gz,1))







