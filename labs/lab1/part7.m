%% RANDOM NOISE SIGNALS
clear all;
close all;

%% 1. Step 1
% Parameters
N = 1000; % Number of samples

% Generate white Gaussian noise
noise = randn(1, N);

% Time domain plot
figure;
plot(noise);
title('Time Domain - White Gaussian Noise');
xlabel('Sample Number');
ylabel('Amplitude');
grid on;

% Frequency domain plot
noise_fft = fft(noise); % Compute DFT
frequencies = (0:N-1); % Frequency axis in bins

figure;
stem(frequencies, abs(noise_fft));
title('Frequency Domain - White Gaussian Noise');
xlabel('Bin Number');
ylabel('Magnitude');
grid on;


%% 2. Step 2
% Parameters
N = 1000; % Number of samples
fs = 100; % Sampling frequency in Hz
f_pass = 5; % Passband edge frequency in Hz

% Generate white Gaussian noise
noise = randn(1, N);

% Design Chebyshev Type I lowpass filter
order = 5; % Filter order
ripple = 2; % Passband ripple in dB
Wn = f_pass / (fs / 2); % Normalized passband edge frequency
[b, a] = cheby1(order, ripple, Wn, 'low');

% Filter the noise
filtered_noise = filter(b, a, noise);

% Time domain plot
t = (0:N-1) / fs; % Time axis in seconds
figure;
plot(t, filtered_noise);
title('Time Domain - Filtered Random Noise');
xlabel('Time (s)');
ylabel('Amplitude');
grid on;

% Frequency domain plot
filtered_noise_fft = fft(filtered_noise); % Compute DFT
frequencies = (0:N-1) * (fs / N); % Frequency axis in Hz

figure;
stem(frequencies, abs(filtered_noise_fft));
title('Frequency Domain - Filtered Random Noise');
xlabel('Frequency (Hz)');
ylabel('Magnitude');
xlim([0, fs / 2]); % Display only up to Nyquist frequency
grid on;


%% 3. Step 3

% Parameters
N = 1000; % Number of samples
fs = 100; % Sampling frequency in Hz
f_cutoff = 5; % Cutoff frequency in Hz

% Generate white Gaussian noise
noise = randn(1, N);

% Compute DFT
noise_fft = fft(noise);

% Band-limit the DFT
frequencies = (0:N-1) * (fs / N); % Frequency axis in Hz
noise_fft(frequencies > f_cutoff) = 0;

% Compute inverse DFT
band_limited_noise = 2 * N * real(ifft(noise_fft));

% Scale the signal to have an RMS value of 1
desired_RMS = 1;
current_RMS = sqrt(mean(band_limited_noise.^2));
scaled_noise = band_limited_noise * (desired_RMS / current_RMS);

% Repeat the sequence to create a periodic signal
num_repeats = 3; % Number of repetitions
periodic_noise = repmat(scaled_noise, 1, num_repeats);

% Time domain plot
t = (0:length(periodic_noise)-1) / fs; % Time axis in seconds
figure;
plot(t, periodic_noise);
title('Time Domain - Periodic Band-Limited Random Noise');
xlabel('Time (s)');
ylabel('Amplitude');
grid on;

% Frequency domain plot
periodic_noise_fft = fft(periodic_noise); % Compute DFT
frequencies = (0:length(periodic_noise)-1) * (fs / length(periodic_noise)); % Frequency axis in Hz

figure;
stem(frequencies, abs(periodic_noise_fft));
title('Frequency Domain - Periodic Band-Limited Random Noise');
xlabel('Frequency (Hz)');
ylabel('Magnitude');
xlim([0, fs / 2]); % Display only up to Nyquist frequency
grid on;