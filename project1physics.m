clear; clc; close all;

fprintf('=== Symbolic Calculation of Motion Parameters ===\n\n');

syms t m real positive

fprintf('Enter the parametric equations for motion:\n');
fprintf('Example formats: 5*t, 10*t - 0.5*9.8*t^2, 2*cos(3*t), etc.\n\n');

x_t = input('Enter x(t) = ', 's');
y_t = input('Enter y(t) = ', 's');

x_t = str2sym(x_t);
y_t = str2sym(y_t);

fprintf('\nEntered equations:\n');
fprintf('x(t) = %s\n', char(x_t));
fprintf('y(t) = %s\n\n', char(y_t));

vx_t = diff(x_t, t);  % dx/dt
vy_t = diff(y_t, t);  % dy/dt

fprintf('Velocity components:\n');
fprintf('vx(t) = %s\n', char(vx_t));
fprintf('vy(t) = %s\n\n', char(vy_t));

% L_z = m*(x*vy - y*vx)
L_z = m * (x_t * vy_t - y_t * vx_t);

fprintf('Angular momentum (z-component):\n');
fprintf('L_z(t) = %s\n\n', char(L_z));

fprintf('=== Numerical Evaluation and Plotting ===\n\n');

m_val = input('Enter mass value m (kg): ');

t_start = input('Enter start time (s): ');
t_end = input('Enter end time (s): ');
t_vec = linspace(t_start, t_end, 1000);

x_num = double(subs(x_t, t, t_vec));
y_num = double(subs(y_t, t, t_vec));
L_z_num = double(subs(L_z, {t, m}, {t_vec, m_val}));

vx_num = double(subs(vx_t, t, t_vec));
vy_num = double(subs(vy_t, t, t_vec));
v_mag = sqrt(vx_num.^2 + vy_num.^2);

% Create a single figure window that fits both plots
figure('Position', [100, 100, 1000, 600]);

% Trajectory (y vs x)
subplot(1, 2, 1); % Changed to 1x2 grid
plot(x_num, y_num, 'b-', 'LineWidth', 2);
xlabel('x position (m)');
ylabel('y position (m)');
title('Particle Trajectory');
grid on;
axis equal;

% Time markers
hold on;
time_markers = 1:floor(length(t_vec)/5):length(t_vec);
plot(x_num(time_markers), y_num(time_markers), 'ro', 'MarkerSize', 6, 'MarkerFaceColor', 'red');
legend('Trajectory', 'Time markers', 'Location', 'best');

% Angular Momentum vs Time
subplot(1, 2, 2);
plot(t_vec, L_z_num, 'r-', 'LineWidth', 2);
xlabel('Time (s)');
ylabel('L_z (kg·m²/s)');
title('Angular Momentum vs Time');
grid on;

fprintf('\n=== Motion Summary ===\n');
fprintf('Time range: %.1f to %.1f seconds\n', t_start, t_end);
fprintf('Mass: %.2f kg\n', m_val);
fprintf('Initial position: (%.2f, %.2f) m\n', x_num(1), y_num(1));
fprintf('Final position: (%.2f, %.2f) m\n', x_num(end), y_num(end));
fprintf('Initial angular momentum: %.4f kg·m²/s\n', L_z_num(1));
fprintf('Final angular momentum: %.4f kg·m²/s\n', L_z_num(end));

% Check if L is conserved?
L_z_range = range(L_z_num);
if L_z_range < 1e-10
    fprintf('→ Angular momentum is CONSERVED (constant)\n');
else
    fprintf('→ Angular momentum is NOT conserved\n');
    fprintf('  Variation: %.6f kg·m²/s\n', L_z_range);
end

%% animation
animate = input('\nDo you want to see an animation? (1: yes, 0: no): ');
if animate == 1
    figure('Position', [200, 200, 800, 600]);
    
    % Handle cases where x or y is constant
    x_range = max(x_num) - min(x_num);
    y_range = max(y_num) - min(y_num);
    
    % If range is zero (constant position), set a reasonable default range
    if x_range == 0
        x_margin = 1; % Default margin for constant x
    else
        x_margin = 0.1 * x_range;
    end
    
    if y_range == 0
        y_margin = 1; % Default margin for constant y
    else
        y_margin = 0.1 * y_range;
    end
    
    x_lim = [min(x_num)-x_margin, max(x_num)+x_margin];
    y_lim = [min(y_num)-y_margin, max(y_num)+y_margin];
    
    % Ensure we have valid axis limits (no infinite or NaN values)
    if any(isinf(x_lim)) || any(isnan(x_lim)) || diff(x_lim) == 0
        x_lim = [-1, 1]; % Default x limits
    end
    if any(isinf(y_lim)) || any(isnan(y_lim)) || diff(y_lim) == 0
        y_lim = [-1, 1]; % Default y limits
    end
    
    % Handle cases where velocity is zero or very small for quiver
    max_velocity = max(sqrt(vx_num.^2 + vy_num.^2));
    if max_velocity == 0
        scale = 1; % Default scale for zero velocity
    else
        scale = 0.1 * max([x_range, y_range]) / max_velocity;
        if scale == 0 || isinf(scale) || isnan(scale)
            scale = 0.1;
        end
    end
    
    fprintf('Starting animation...\n');
    
    % SMOOTH ANIMATION SETTINGS
    frame_step = 5;  % Reduced from 20 to 5 for more frames
    pause_duration = 0.00002;  % Reduced from 0.02 to 0.005 for faster updates
    
    % Pre-calculate data for better performance
    trajectory_x = x_num(1:frame_step:end);
    trajectory_y = y_num(1:frame_step:end);
    trajectory_t = t_vec(1:frame_step:end);
    trajectory_L = L_z_num(1:frame_step:end);
    trajectory_vx = vx_num(1:frame_step:end);
    trajectory_vy = vy_num(1:frame_step:end);
    
    total_frames = length(trajectory_x);
    
    for i = 1:total_frames
        clf;
        
        % Full trajectory (light gray)
        plot(x_num, y_num, 'b-', 'LineWidth', 1, 'Color', [0.7, 0.7, 0.7]);
        hold on;
        
        % Trajectory up to current point
        plot(trajectory_x(1:i), trajectory_y(1:i), 'b-', 'LineWidth', 2);
        
        % Current position
        plot(trajectory_x(i), trajectory_y(i), 'ro', 'MarkerSize', 10, 'MarkerFaceColor', 'red');
        
        % Add velocity vector (only if velocity is non-zero)
        current_speed = sqrt(trajectory_vx(i)^2 + trajectory_vy(i)^2);
        if current_speed > 1e-10
            quiver(trajectory_x(i), trajectory_y(i), trajectory_vx(i)*scale, trajectory_vy(i)*scale, ...
                   'r', 'LineWidth', 2, 'MaxHeadSize', 1, 'AutoScale', 'off');
            legend_labels = {'Future path', 'Path traveled', 'Current position', 'Velocity vector'};
        else
            legend_labels = {'Future path', 'Path traveled', 'Current position'};
        end
        
        xlabel('x position (m)');
        ylabel('y position (m)');
        title(sprintf('Particle Motion Animation\nTime = %.2f s, L_z = %.4f kg·m²/s', trajectory_t(i), trajectory_L(i)));
        grid on;
        
        % Use axis equal only if we have non-zero ranges in both dimensions
        if x_range > 0 && y_range > 0
            axis equal;
        else
            axis normal;
        end
        
        xlim(x_lim);
        ylim(y_lim);
        
        legend(legend_labels, 'Location', 'best');
        
        drawnow;
        pause(pause_duration);  % Much shorter pause for smoother animation
    end
    
    fprintf('Animation completed.\n');
end

fprintf('\n=== Program Finished ===\n');