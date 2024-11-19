Mp = 0.15;
Ta = 0.25;

Mp2 = log(Mp)/(-pi);
Qsi = sqrt((Mp2^2)/(1+Mp2^2));

MF = (asind(Qsi))*2;

Wn=4/(Qsi*Ta);
Wcg=i*Wn;
% G_jwcg = 1.856/((74*Wcg)+1);
G_jwcg = 10.06/((0.09979*Wcg)+1);
Mod_Gjwcg = abs(G_jwcg);
Ang_Gjwcg = (angle(G_jwcg)*180)/pi;
Theta = -180+MF-Ang_Gjwcg;
Kp=cosd(Theta)/Mod_Gjwcg;
Ki=-(sind(Theta)*Wn^2)/(Mod_Gjwcg*Wn);
Tn = (Kp/Ki);
Cs = tf([Kp Ki],[1 0])
Gs = tf(10.06,[0.09979 1])
CG = series(Cs,Gs)


FTMF = feedback(CG,1)
figure;
margin(CG)
figure;
step(FTMF)