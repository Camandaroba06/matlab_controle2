clear;
clc;
close all;


s = tf('s');


G = 10.8/(0.1*s+1);
C = 0.64/s;

% rlocus(G*C)
rlocus(feedback(G*C,1))