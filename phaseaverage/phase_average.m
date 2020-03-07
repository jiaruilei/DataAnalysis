function [pa_u, pa_phase] = phase_average(U, NoSample)
% U is the velocity record; NoSample is the exact number of samples within
% one wave cycle; Xcorr can be used to find NoSample.
NoBin = ceil(NoSample); velocity1 = U;
bins_u = zeros(NoBin, floor(1.2*length(U)/NoBin)); bins_count = zeros(NoBin,1);
phase_u = zeros(NoBin, floor(1.2*length(U)/NoBin) ); % creat matrices to bin velocity data
% The expected number of sample within one bin should be approxmately equal
% to length(U)/NoBin. 
for ii = 1:1:length(velocity1)
    phase_temp = mod(ii-1, NoSample); bin_temp = floor(phase_temp)+1;
    bins_count(bin_temp) = bins_count(bin_temp) + 1;
    bins_number_data = bins_count(bin_temp);
    bins_u(bin_temp, bins_number_data) = velocity1(ii);
    phase_u(bin_temp, bins_number_data) = phase_temp - floor(phase_temp);
end

phase_average_u = zeros(NoBin,1);
average_phase = zeros(NoBin,1); average_phase_all = zeros(NoBin,1);
for jj = 1:1:NoBin
    temp_u = bins_u(jj,:); temp_phase = phase_u(jj,:);
    phase_average_u(jj) = mean(temp_u(temp_u~=0));
    average_phase(jj) = mean(temp_phase(temp_phase~=0));
    average_phase_all(jj) = average_phase(jj) + jj - 1;
end

pa_u = phase_average_u; pa_phase = average_phase_all*2*pi/NoSample;
% The resultsed phase average velocity and phase for each bin. 
end