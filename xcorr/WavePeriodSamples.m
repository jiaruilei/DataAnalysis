%% Finding the exact number of samples within one wave period
y = velocity1; % y = Horizontal velocity (Ux) record from ADV
ac = xcorr(y,y); % Cross-correlation function
[~,locs] = findpeaks(ac); % find where correlation peaks
mean(diff(locs(5:end-4))); % calculate the distance between adjacent peaks (from the 5th to the 5th-last peak)
disp('The number of data points within one wave period is'); disp(mean(diff(locs(5:end-4)))); 
% Note: this value might be different from SamplingRate * Period