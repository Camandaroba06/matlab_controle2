s = tf('s');


Cs = ((20/100.6)*(s+10))/(s+20)
G_sis = 100.6/(s+10)

Ts = 0.02;

Cz = c2d(Cs, Ts, 'tustin')


figure;
step(Cs);
hold on;
step(Cz);
title('Resposta ao Degrau de Cs e Cz');
legend('Cs - Contínuo', 'Cz - Discreto');
xlabel('Tempo');
ylabel('Amplitude');
grid on;
hold off;

G_sis_discrete = c2d(G_sis, Ts, 'tustin')
figure;
step(G_sis*Cs);
hold on;
step(G_sis_discrete * Cz);
title('Resposta ao Degrau de G_{sis} * Cs e G_{sisDiscreto} * Cz');
xlabel('Tempo');
ylabel('Amplitude');
grid on;
