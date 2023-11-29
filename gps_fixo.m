% Parâmetros de ruído
std_dev_pos_hor = 6.0;
std_dev_pos_ver = 3.0;
std_dev_vel_hor = 0.1;
std_dev_vel_ver = 0.1;

% Número de pontos a serem gerados
num_pontos = 1000;

% Posição GPS real (latitude, longitude, altitude)
posicao_real = [0, 0, 0];

% Velocidade GPS real (latitude, longitude, altitude)
velocidade_real = [0, 0, 0];

% Inicialização dos vetores para armazenar as posições e velocidades com ruído
posicoes_com_ruido = zeros(num_pontos, 3);
velocidades_com_ruido = zeros(num_pontos, 3);

% Loop para gerar as posições e velocidades com ruído
for i = 1:num_pontos
    % Adiciona ruído às componentes horizontal e vertical da posição
    posicao_com_ruido = posicao_real + [std_dev_pos_hor * randn, std_dev_pos_hor * randn, std_dev_pos_ver * randn];

    % Adiciona ruído às componentes horizontal e vertical da velocidade
    velocidade_com_ruido = velocidade_real + [std_dev_vel_hor * randn, std_dev_vel_hor * randn, std_dev_vel_ver * randn];

    % Armazena a posição e velocidade com ruído nos vetores
    posicoes_com_ruido(i, :) = posicao_com_ruido;
    velocidades_com_ruido(i, :) = velocidade_com_ruido;
end

% Cálculo dos desvios padrão
desvio_padrao_pos_horizontal_x = std(posicoes_com_ruido(:, 1)); % Componente x
desvio_padrao_pos_horizontal_y = std(posicoes_com_ruido(:, 2)); % Componente y
desvio_padrao_pos_vertical = std(posicoes_com_ruido(:, 3));
desvio_padrao_vel_horizontal_x = std(velocidades_com_ruido(:, 1)); % Componente x
desvio_padrao_vel_horizontal_y = std(velocidades_com_ruido(:, 2)); % Componente y
desvio_padrao_vel_vertical = std(velocidades_com_ruido(:, 3));

% Exibe os valores reais das posições e velocidades
disp(['Posição Real: ', num2str(posicao_real)]);
disp(['Velocidade Real: ', num2str(velocidade_real)]);

% Exibe os desvios padrão das posições
disp(['Desvio Padrão Posições Horizontal (Componente x): ', num2str(desvio_padrao_pos_horizontal_x), ' metros']);
disp(['Desvio Padrão Posições Horizontal (Componente y): ', num2str(desvio_padrao_pos_horizontal_y), ' metros']);
disp(['Desvio Padrão Posições Vertical: ', num2str(desvio_padrao_pos_vertical), ' metros']);

% Exibe os desvios padrão das velocidades
disp(['Desvio Padrão Velocidades Horizontal (Componente x): ', num2str(desvio_padrao_vel_horizontal_x), ' (m/s)']);
disp(['Desvio Padrão Velocidades Horizontal (Componente y): ', num2str(desvio_padrao_vel_horizontal_y), ' (m/s)']);
disp(['Desvio Padrão Velocidades Vertical: ', num2str(desvio_padrao_vel_vertical), ' (m/s)']);

% Restante do código permanece igual

% Plotagem das posições em 3D
figure;
plot3(posicao_real(2), posicao_real(1), posicao_real(3), 'o', 'MarkerSize', 10, 'MarkerFaceColor', 'b');
hold on;
plot3(posicoes_com_ruido(:, 2), posicoes_com_ruido(:, 1), posicoes_com_ruido(:, 3), 'x', 'MarkerSize', 5, 'MarkerEdgeColor', 'r');
hold off;

title('Posições GPS com Ruído');
xlabel('Longitude (Componente y)');
ylabel('Latitude (Componente x)');
zlabel('Altitude');
legend('Posição Real', 'Posições com Ruído');
grid on;

% Plotagem das velocidades
figure;
plot(velocidade_real(2), 'o-', 'LineWidth', 2, 'MarkerFaceColor', 'b'); % Componente y
hold on;
plot(velocidades_com_ruido(:, 2), 'x-', 'LineWidth', 1, 'MarkerEdgeColor', 'r'); % Componente y
hold off;

title('Velocidades com Ruído');
xlabel('Tempo');
ylabel('Velocidade (Componente y)');
legend('Velocidade Real', 'Velocidades com Ruído');
grid on;
