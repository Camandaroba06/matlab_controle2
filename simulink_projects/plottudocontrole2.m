figure;
step(feedback(G,1))
hold on;
step(malhafechadacontrolada_extbode);
step(malhafechadacontrolada_rascpedro);
step(sys_semintEE);
step(sys_commintEE);

% Personalizar o gráfico
title('Resposta ao Degrau para Malha Fechada', 'FontSize', 20);
xlabel('Tempo (segundos)', 'FontSize', 16);
ylabel('Amplitude (V)', 'FontSize', 16);
legend('Sem controle', 'Filtro Notch', 'Aprox 2ª ordem', 'EE sem Integrador', 'EE com Integrador', 'Location', 'southeast', 'FontSize', 14);
set(gca, 'FontSize', 12);  % Aumenta o tamanho da fonte dos ticks dos eixos x e y

hold off;