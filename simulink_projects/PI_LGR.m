clear;
clc;
close all;

s = tf('s');
Mp = 0.1;
Ts = 0.25;
% Mp = 0.15;
% Ts = 0.25;
G_semnada = 100.6/(s+10);
% figure;
% step(feedback(G_semnada,1))

Qsi = sqrt(((log(Mp))^2)/(pi^2 +(log(Mp))^2))
ang_poss_polMF = rad2deg(acos(Qsi))

Wn = 4/(Ts*Qsi)

Pd = -Qsi*Wn + i*(Wn*sqrt(1-Qsi^2))
contrib_ang = rad2deg(angle(100.6/(Pd+10)))

angulo=contrib_ang-(rad2deg(angle(Pd)))

phi = -180 - angulo

a = -(real(Pd)-((imag(Pd))/tan(deg2rad(phi))))

K = 1/(abs((100.6/(Pd+10))*((Pd+a)/Pd)))
% figure;
% rlocus(feedback(G_semnada,1))

C = K*(s+a)/s
G_semnada*C
figure;
step(feedback(G_semnada*C,1))


figure;
rlocus(feedback(G_semnada*C,1))
% Cz = c2d(C,0.0005,'tustin')
Ts_tustin = 0.01; %100hz 0.01 seg 10.000 microseg
% Ts_tustin = 0.0512/8000;

Cz = c2d(C,Ts_tustin,'tustin')
G_semnada_z = c2d(G_semnada,Ts_tustin,'tustin')
figure;
step(Cz)
hold on
step(C);
figure;
step(feedback(G_semnada*C,1))
hold on
step(feedback(G_semnada_z*Cz,1))
disp(Cz)
info = stepinfo(feedback(G_semnada*C,1))


C = 0.64/s;
G = 10.8/(0.1*s+1);
figure;
rlocus(feedback(G*C,1))