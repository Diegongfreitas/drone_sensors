% Parâmetros
gravidade = 9.8; % Aceleração devida à gravidade (m/s^2)
std_dev_acc = 0.2; % Desvio padrão para o ruído do acelerômetro
std_dev_gyro = 0.1; % Desvio padrão para o ruído do giroscópio
Cd = 0.5; % Coeficiente de arrasto
A = 0.01; % Área de referência (m^2)

% Número de pontos a serem simulados
num_pontos = 1000;

% Taxa de amostragem
dt = 0.01; % Exemplo de taxa de amostragem de 100 Hz

% Inicialização dos vetores para armazenar as leituras do acelerômetro e giroscópio
acc_readings = zeros(num_pontos, 3);
gyro_readings = zeros(num_pontos, 3);

% Inicialização das variáveis de estado
R = eye(3); % Matriz de rotação inicial (identidade)
omega_b = zeros(3, 1); % Gyro bias
G = [0; 0; -gravidade]; % Vetor gravidade na orientação inicial
q = [1; 0; 0; 0]; % Quaternion de orientação inicial (unidade)

% Loop para simular as leituras do acelerômetro e giroscópio
for i = 2:num_pontos
    % Simulação do giroscópio
    omega_n = std_dev_gyro * randn(3, 1); % Ruído do giroscópio
    omega_m = R * (G + omega_n + omega_b); % Leitura do giroscópio

    % Atualização da orientação usando a leitura do giroscópio
    q = updateQuaternion(q, omega_m, dt);

    % Armazenamento da leitura do giroscópio
    gyro_readings(i, :) = omega_m.';

    % Simulação do acelerômetro com força de arrasto
    a_n = std_dev_acc * randn(3, 1); % Ruído do acelerômetro
    drag_force = -0.5 * Cd * A * norm(R' * G) * R' * G; % Força de arrasto
    a_m = R' * (G + a_n) + drag_force; % Leitura do acelerômetro

    % Armazenamento da leitura do acelerômetro
    acc_readings(i, :) = a_m.';
end

% Plots
figure;

% Gráfico do Giroscópio
subplot(2, 1, 1);
plot(gyro_readings);
title('Leituras do Giroscópio');
legend('X', 'Y', 'Z');
xlabel('Tempo');
ylabel('Velocidade Angular (rad/s)');

% Gráfico do Acelerômetro
subplot(2, 1, 2);
plot(acc_readings);
title('Leituras do Acelerômetro');
legend('X', 'Y', 'Z');
xlabel('Tempo');
ylabel('Aceleração (m/s^2)');

% Função para atualizar o quaternion com base na leitura do giroscópio
function q = updateQuaternion(q_prev, omega, dt)
    omega_norm = norm(omega);
    if omega_norm > 0
        axis = omega / omega_norm;
        delta_q = [cos(omega_norm * dt / 2); sin(omega_norm * dt / 2) * axis];
    else
        delta_q = [1; 0; 0; 0];
    end
    q = quatmultiply(q_prev.', delta_q.');
    q = q.';
    q = q / norm(q);
end
