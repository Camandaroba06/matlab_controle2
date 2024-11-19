s = tf('s');

Gs = 100.6/(s+10)
C_avanco = (s+10)/(s+20)
C_atraso = (s+0.2)/(s+0.128)

figure;
step(feedback(Gs,1))
hold on
step(feedback(Gs*C_avanco,1))
step(feedback(Gs*C_avanco*C_atraso,1))
legend('sistema 1','sistema 2','sistema 3','sistema 4')