clear;
clc;
close all;

s = tf('s');

G_estudo = 5/((s+1)*(s+2)*(s+3));

info_G_estudo = stepinfo(feedback(G_estudo,1))


step(feedback(G_estudo,1))
