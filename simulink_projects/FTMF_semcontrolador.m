
s = tf('s');
G = 10.8/(0.1*s+1);
C = 0.64/s;
sistemamalhafechada = feedback(G, 1);


step(sistemamalhafechada);
title('Resposta ao Degrau da Função de Transferência em Malha Fechada Sem Controlador');
xlabel('Tempo (s)');
ylabel('Amplitude');
grid on;
figure;
sistemamalhafechada = feedback(G*C, 1);
step(sistemamalhafechada);
title('Resposta ao Degrau da Função de Transferência em Malha Fechada Sem Controlador');
xlabel('Tempo (s)');
ylabel('Amplitude');
grid on;