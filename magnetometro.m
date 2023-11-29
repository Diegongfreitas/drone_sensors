%Esse código fornece a medida em graus do ângulo entre a frente do drone e 
%o norte magnético, baseando-se nas medidas do campo magnético da Terra 
%nos eixos x,y e z do corpo do drone e na medida declínio local, sendo esse
%o angulo entre o norte real e o norte magnético. Alterando a leitura do
%para cada instante de tempo é adicionado um ruído à medição, assim podemos
%ver a evolução do ângulo de yaw para cada medida distinta do magnetômetro.

% Parâmetros do magnetômetro
num_amostras = 100; % Número de amostras/tempo
MAG = randn(3, num_amostras); % Leitura constante do magnetômetro (Earth's magnetic field)
nMAG = 0.01 * randn(3, num_amostras); % Sinal de ruído do magnetômetro ao longo do tempo

% Transformação para o plano horizontal
roll = deg2rad(0); % Ângulo de inclinação (roll) em radianos
pitch = deg2rad(0); % Ângulo de inclinação (pitch) em radianos

% Calcular a matriz de rotação R (agora 2x3)
R = [cos(roll) sin(roll)*sin(pitch) cos(pitch);
    0 cos(pitch) -sin(pitch)];

% Inicializar vetores para armazenar resultados ao longo do tempo
mh_evolution = zeros(2, num_amostras);
psi_m_evolution = zeros(1, num_amostras);

% Calcular a evolução das leituras do magnetômetro e ângulos ao longo do tempo
for t = 1:num_amostras
    % Calcular as leituras no plano horizontal
    mh_evolution(:, t) = R * (MAG(:, t) + nMAG(:, t));

    % Calcular o ângulo de inclinação corrigido
    psi_declination = deg2rad(5); % Declinação local em radianos
    psi_m_evolution(t) = atan2(mh_evolution(2, t), mh_evolution(1, t)) + psi_declination;
    % Exibir os valores no console
    fprintf('Amostra %d: m_hx = %.4f, m_hy = %.4f, psi = %.4f\n', t, mh_evolution(1, t), mh_evolution(2, t), rad2deg(psi_m_evolution(t)));
end

% Plotar a evolução ao longo do tempo
figure;

% Plotar as leituras originais do magnetômetro ao longo do tempo
subplot(2, 2, 1);
plot(1:num_amostras, MAG');
title('Leituras Originais do Magnetômetro ao Longo do Tempo');
xlabel('Amostra');
ylabel('Valor');
legend('mx', 'my', 'mz');

% Plotar o sinal de ruído do magnetômetro ao longo do tempo
subplot(2, 2, 2);
plot(1:num_amostras, nMAG');
title('Sinal de Ruído do Magnetômetro ao Longo do Tempo');
xlabel('Amostra');
ylabel('Valor');
legend('nx', 'ny', 'nz');

% Plotar a evolução da leitura no plano horizontal ao longo do tempo
subplot(2, 2, 3);
plot(1:num_amostras, mh_evolution');
title('Leitura do Magnetômetro no Plano Horizontal ao Longo do Tempo');
xlabel('Amostra');
ylabel('Valor');
legend('m_hx', 'm_hy');

% Plotar a evolução do ângulo de inclinação corrigido ao longo do tempo
subplot(2, 2, 4);
plot(1:num_amostras, rad2deg(psi_m_evolution));
title('Ângulo de Inclinação Corrigido (Yaw) ao Longo do Tempo');
xlabel('Amostra');
ylabel('Ângulo (graus)');
legend('\psi_m');

% Ajustar o layout
sgtitle('Evolução do Sistema ao Longo do Tempo');