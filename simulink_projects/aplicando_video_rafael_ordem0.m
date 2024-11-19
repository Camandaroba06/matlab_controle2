clear;
clc;
close all;
s = tf('s');
Vin = 30;
L=0.001;
Cap=3.3*10^(-6);
R=12;



A = [(-1/(R*Cap)) 1/Cap; -1/L 0]
B = [0; Vin/L]
C = [0 1]
D = [0]
SysMA=ss(A, B, C, D) ;

%Polos da planta
eig(A)

%Sistema aumentado
Abar=[A zeros(2,1) ;-C 0];
Bbar=[B; 0];
Cbar=[C 0];
Dbar=[0];

%Matriz de controlabilidade do
%sistema aumentado
M=ctrb(Abar, Bbar)
%Posto da matriz de controlabilidade
%do sistema aumentado
rank(M)

%Polos de MF desejados
% polosMF=[-2+j*2*sqrt(3) -2-j*2*sqrt(3) -1];
polosMF = [-8 + 10.91501083i -8 - 10.91501083i -1000]
%Projeto do vetor de ganhos Kbar do
%controlador
Kbar=acker(Abar, Bbar, polosMF)



%Sistema em MF sem controlador
Amf=A-B*C;
Bmf=B;
Cmf=C;
Dmf=D;
sysMF=ss(Amf, Bmf, Cmf, Dmf);

%Polos do sistema em MF sem controlador
eig(Amf)

%Sistema em MF com controlador
Amfc=Abar-Bbar*Kbar;
Bmfc=[0 0 1]';
Cmfc=Cbar;
Dmfc=Dbar;
sysMFc=ss(Amfc, Bmfc, Cmfc, Dmfc);

%Polos do sistema em MF com controlador
eig(Amfc)

%Resposta ao degrau em MF
figure;
step(sysMF, 1);
hold;
step(sysMFc, 1);
legend ('Sistema sem controlador', 'Sistema com controlador');