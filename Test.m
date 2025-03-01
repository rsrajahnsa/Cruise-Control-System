% Vehicle Parameters
m = 1000; % Mass of vehicle (kg)
b = 50;   % Damping coefficient (N.s/m)

% PID Controller Gains (Tuned using trial & error)
Kp = 500;  % Proportional Gain
Ki = 10;   % Integral Gain
Kd = 50;   % Derivative Gain

% Simulation Parameters
dt = 0.1;  % Time step (s)
T = 50;    % Total simulation time (s)
v_ref = 20; % Desired speed (m/s)
% Initialize variables
v = 0;      % Initial speed
integral = 0; % Integral term
prev_error = 0; % Previous error for derivative term
time = 0:dt:T;  % Time array
velocity = zeros(size(time)); % Store velocity over time

% Simulation loop
for i = 1:length(time)
    % Compute error
    error = v_ref - v;
    
    % PID Controller
    integral = integral + error * dt;
    derivative = (error - prev_error) / dt;
    u = Kp * error + Ki * integral + Kd * derivative; % Control action
    
    % Vehicle Dynamics: Newton’s second law
    a = (u - b * v) / m;  % Acceleration
    v = v + a * dt;       % Velocity update
    
    % Store values
    velocity(i) = v;
    prev_error = error;
end
% Plot speed response
figure;
plot(time, velocity, 'b', 'LineWidth', 2);
hold on;
yline(v_ref, 'r--', 'LineWidth', 2); % Desired speed line
xlabel('Time (s)');
ylabel('Speed (m/s)');
title('Cruise Control System: Speed vs Time');
legend('Actual Speed', 'Desired Speed');
grid on;
