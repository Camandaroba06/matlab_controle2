clc;
close all;
s = tf('s');

G = 2/(s^2 + 2*s +4)
pole(G)
filtro = (s^2+2*s+4)/((s+2)^2)
ftma_filtrada = G*filtro
ftma_filtrada = 4/((s+2)^2)
PI = (s+2)/s
ftma_pi = PI*ftma_filtrada
rlocus(ftma_pi)