s = tf('s');
% Gs = 4.54/(10.8*s + 1)
Gs = 100.6/(s+10)
Kp=0.3;
Ki=14.8797;
% Kp = 0.5;
% Ki=18;

% C_PI = ((4.537*s+8.902)/s)
C_PI = ((Kp*s+Ki)/s)


step(feedback(Gs*C_PI,1))
C_PI_z = c2d(C_PI,0.01,'tustin')
% C_PI_z = c2d(C_PI,0.001,'tustin')