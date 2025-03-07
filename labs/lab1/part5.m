%%  SETTING THE ROOT-MEAN-SQUARE OF A SIGNAL
clear all;
close all;
%% From previous task
% Parameters
f_min = 5; % Minimum frequency in Hz
f_max = 15; % Maximum frequency in Hz
N_freq = 31; % Number of equidistant frequencies
fs = 40; % Sampling frequency in Hz

% Frequency resolution
delta_f = (f_max - f_min) / (N_freq - 1);

% Frequencies in the excited band
frequencies = linspace(f_min, f_max, N_freq);

% Random phases
phases = 2 * pi * rand(1, N_freq);

% Frequency domain representation
N = fs / delta_f; % Total number of samples
X_tilde = zeros(1, N);
bin_indices = round(frequencies / delta_f) + 1; % Convert frequencies to bin indices
X_tilde(bin_indices) = 0.5 * exp(1j * phases);

% Compute inverse DFT
x_t = real(2*N*ifft(X_tilde, N));

% Time vector
t = (0:N-1) / fs;

% Frequency vector
f = (0:N-1) * delta_f;

% Time domain plot
figure;
plot(t, x_t);
title('Time Domain');
xlabel('Time (s)');
ylabel('Amplitude');
grid on;

% Frequency domain plot
figure;
stem(f, abs(X_tilde));
title('Frequency Domain');
xlabel('Frequency (Hz)');
ylabel('Magnitude');
xlim([0, f_max + 5]); % Limit x-axis to show the excited band
grid on;

% Period and frequency resolution
T = 1 / delta_f;
fprintf('Period of the multisine: %.2f seconds\n', T);
fprintf('Frequency resolution: %.2f Hz\n', delta_f);


%% 1. RMS value

RMS_des = 3;
RMS_x = rms(x_t);
x_des = x_t*(RMS_des/RMS_x);

figure;
plot(t, x_des);
title('RMS_x(n)');
xlabel('Time (s)');
ylabel('Amplitude');
grid on;
