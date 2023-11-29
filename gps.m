%Esse código recebe os valores de posição e velocidade a serem obtidos por
%um GPS e adiciona ruido nesses valores, observamos que conforme aumentamos
%o npumero de pontos gerados à cada execução convergimos o desvio padrão
%das amostras aos desvios esperados para a posição e velocidade em cada
%eixo do drone.

% Parâmetros de ruído
std_dev_pos_hor = 6.0;
std_dev_pos_ver = 3.0;
std_dev_vel_hor = 0.1;
std_dev_vel_ver = 0.1;

% Número de pontos a serem gerados
num_pontos_base = 100;

% Número de execuções
num_execucoes = 4;

for k = 1:num_execucoes
    % Ajuste o número de pontos para cada execução
    num_pontos = num_pontos_base * 2^k;

    % Posição GPS real (latitude, longitude, altitude)
    posicao_real = [randn * 10, randn * 10, randn * 10];

    % Velocidade GPS real (latitude, longitude, altitude)
    velocidade_real = [randn * 0.1, randn * 0.1, randn * 0.1];

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

    % Exibe os desvios padrão das posições
    disp(['Desvio Padrão Posições Horizontal (Componente x) (Execução ', num2str(k), '): ', num2str(desvio_padrao_pos_horizontal_x), ' metros']);
    disp(['Desvio Padrão Posições Horizontal (Componente y) (Execução ', num2str(k), '): ', num2str(desvio_padrao_pos_horizontal_y), ' metros']);
    disp(['Desvio Padrão Posições Vertical (Execução ', num2str(k), '): ', num2str(desvio_padrao_pos_vertical), ' metros']);

    % Exibe os desvios padrão das velocidades
    disp(['Desvio Padrão Velocidades Horizontal (Componente x) (Execução ', num2str(k), '): ', num2str(desvio_padrao_vel_horizontal_x), ' (m/s)']);
    disp(['Desvio Padrão Velocidades Horizontal (Componente y) (Execução ', num2str(k), '): ', num2str(desvio_padrao_vel_horizontal_y), ' (m/s)']);
    disp(['Desvio Padrão Velocidades Vertical (Execução ', num2str(k), '): ', num2str(desvio_padrao_vel_vertical), ' (m/s)']);
    
    % Plotagem das posições e velocidades em 3D
    figure;

    % Plotagem das posições
    subplot(2, 1, 1);
    plot3(posicao_real(2), posicao_real(1), posicao_real(3), 'o', 'MarkerSize', 10, 'MarkerFaceColor', 'b');
    hold on;
    plot3(posicoes_com_ruido(:, 2), posicoes_com_ruido(:, 1), posicoes_com_ruido(:, 3), 'x', 'MarkerSize', 5, 'MarkerEdgeColor', 'r');
    hold off;
    title(['Posições GPS com Ruído - Execução ', num2str(k)]);
    xlabel('Longitude');
    ylabel('Latitude');
    zlabel('Altitude');
    legend('Posição Real', 'Posições com Ruído');
    grid on;

    % Plotagem das velocidades
    subplot(2, 1, 2);
    plot(velocidade_real, 'o-', 'LineWidth', 2, 'MarkerFaceColor', 'b');
    hold on;
    plot(velocidades_com_ruido, 'x-', 'LineWidth', 1, 'MarkerEdgeColor', 'r');
    hold off;
    title(['Velocidades com Ruído - Execução ', num2str(k)]);
    xlabel('Componente');
    ylabel('Velocidade');
    legend('Velocidade Real', 'Velocidades com Ruído');
    grid on;

    % Pausa para visualização (opcional)
    pause(1);
end
