%% An example 
data = dlmread('36h_a1.25f0.7h36_05.dat'); % Read data from Vectrino output text file.
data_U = data(:,3); % The third column denotes the horizontal flow velocity.
data_NoSample = 287.6; 
[phase_average_U, phase] = phase_average(data_U, data_NoSample);
% Plot phase-average velocity vs. phase (from 0 to 2pi)
figure(1);
c1 = plot(phase, phase_average_U);
set(c1, 'LineStyle', '-', 'LineWidth', 2, 'Marker', 'none', 'Color', 'k');
hXLabel = xlabel('phase, rad'); 
hYLabel = ylabel('Phase-average velocity, m/s');
axis([0 2*pi -0.05 0.05]);
set([hXLabel, hYLabel], 'FontSize', 14);
set(gca, 'FontSize', 16);