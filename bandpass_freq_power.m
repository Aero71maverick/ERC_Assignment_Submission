function filteredSignal = bandpass_freq_power(signal, fs, fpass, powerThreshold_dB, windowLength)
% bandpassWithPowerThreshold - Apply bandpass filter and suppress low-power regions
%
% Syntax:
%   filteredSignal = bandpassWithPowerThreshold(signal, fs, fpass, powerThreshold_dB, windowLength)
%
% Inputs:
%   signal            - Input signal (vector)
%   fs                - Sampling frequency in Hz
%   fpass             - [f_low, f_high] bandpass range in Hz
%   powerThreshold_dB - Minimum local power (in dB) to keep
%   windowLength      - Length of moving power window (in samples)
%
% Output:
%   filteredSignal    - Filtered signal with low-power regions zeroed

    % --- Design bandpass filter ---
    bpFilt = designfilt('bandpassiir', ...
                        'FilterOrder', 6, ...
                        'HalfPowerFrequency1', fpass(1), ...
                        'HalfPowerFrequency2', fpass(2), ...
                        'SampleRate', fs);
    
    % --- Apply bandpass filter ---
    bandpassed = filtfilt(bpFilt, signal);
    
    % --- Compute local power ---
    localPower = movmean(bandpassed.^2, windowLength);
    localPower_dB = 10 * log10(localPower + eps);  % Avoid log(0)
    
    % --- Mask low-power regions ---
    mask = localPower_dB >= powerThreshold_dB;
    filteredSignal = bandpassed .* mask;

end