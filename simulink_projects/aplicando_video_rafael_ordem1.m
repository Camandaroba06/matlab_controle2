clear;
clc;
close all;
s = tf('s');
Vin = 12;
L=0.001;
Cap=3.3*10^(-6);
R=12;



A = [(-1/(R*Cap)) 1/Cap; -1/L 0]
B = [0; Vin/L]
C = [1 0]
D = [0]
SysMA=ss(A, B, C, D) ;

%Matriz de controlabilidade
M=ctrb(A, B)
%Posto da matriz de controlabilidade
rank(M)

%Polos de MF desejados
% polosMF=[-2+j*2*sqrt(3) -2-j*2*sqrt(3)];
polosMF = [-8 + 10.91501083i -8 - 10.91501083i];
%Projeto do vetor de ganhos K do controlador
K=acker(A, B, polosMF)

%Sistema controlado em MF com kr=1
Amfc=A-B*K;
Bmfc=B;
Cmfc=C;
Dmfc=D;
sysMFc=ss(Amfc, Bmfc, Cmfc, Dmfc);

%Cálculo de kr
GanhoCC=dcgain(sysMFc) ;
kr=1/GanhoCC
% kr=1


%Sistema controlado em MF com kr ajustado
Amfca=A-B*K;
Bmfca=B*kr;
Cmfca=C;
Dmfca=D;
sysMFca=ss(Amfca, Bmfca, Cmfca, Dmfca);

%Sistema em MF sem controlador
Amf=A-B*C;
Bmf=B;
Cmf=C;
Dmf=D;
sysMF=ss(Amf,Bmf,Cmf,Dmf);

%Resposta ao degrau em malha fechada
figure;
subplot(2,1,1);
step(sysMF, 1);
hold;
step(sysMFca, 1) ;
legend ('Sistema sem controlador', 'Sistema com controlador (kr=1/ganhocc)');
subplot(2,1,2);
step(sysMFc, 1)
legend ('Sistema com controlador (kr=1)');