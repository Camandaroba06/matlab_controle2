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
Ts = 0.5;


% Not filter
K = Vin;
G = num/(s^2 + s*den_1 + den_2)
wn = sqrt(den_2)
zeta_not = (den_1)/(2*wn)
wo_not = wn

not_filter = (s^2 + 2*zeta_not*wo_not*s + wo_not^2)/((s+wo_not)^2)

ftma_notchada = G*not_filter


% PI controller
open_loop = ftma_notchada*Vin
zeta = sqrt(((log(OS))^2)/((log(OS))^2+ pi^2))
% PM = atan((2*zeta)/(sqrt(sqrt(1+4*zeta^4)-2*zeta^2)))
PM = rad2deg(atan((2*zeta) / sqrt(-2*zeta^2 + sqrt(1 + 4*zeta^4))));

% wc = (4/(Ts*zeta))*(sqrt(1-2*zeta^2+sqrt(zeta^4 - 4*zeta^2 +2)))



PI = (s+wo_not)/s
open_loop_PI = PI*open_loop


[mag,fase]=bode(open_loop_PI,wc)
Kp = 1/mag

figure;
grid on;
margin(open_loop_PI)




% Kp = 0.0048172367584
figure;
grid on;
step(feedback(Kp*open_loop_PI,1))

figure;
grid on;
margin((open_loop_PI))


figure;
grid on;
margin((Kp*open_loop_PI))