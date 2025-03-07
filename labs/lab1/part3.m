%% PART 3 : TIME DOMAIN CONSTRUCTION OF A MULTISINE
clear all;
close all;
%% 1. Compute multisine
N = 1000;  % Number of samples
K = 10  % Number of excited frequencies
n = 0:N-1;
x = zeros(1, N);  % Time domain signal


for k = 1:K
    A = 1  % Amplitude of each cosine
    phi_k = 2*pi*rand;  % Random phase
    x_k = cos(2*pi*k*n/N + phi_k);
    x = x + x_k;
end


%% Time Domain Plot
figure;
plot(n, x);
title('Multisine signal in time domain');
xlabel('Sample index n');
ylabel('Amplitude');
grid on;

%% Compute DFT
X = fft(x);
X_shifted = fftshift(X);  % Centered FFT

%% Define Frequency Axis (in Bins)
freq_bins = 0:N-1;  % Non-centered bins
freq_bins_shifted = -N/2:N/2-1;  % Centered bins

%% DFT Plot (Frequency in Bins)
figure;
subplot(2,1,1);
stem(freq_bins, abs(X), 'b');
title('DFT Amplitude (Bins)');
xlabel('Frequency bin');
ylabel('|X(k)|');
grid on;

subplot(2,1,2);
stem(freq_bins, angle(X), 'r');
title('DFT Phase (Bins)');
xlabel('Frequency bin');
ylabel('arg(X(k))');
grid on;



%% 2. Define Frequency Axis (in Hz)
fs = 100;
freqs = (0:N-1) * (fs / N);  % Non-centered
freqs_shifted = (-N/2:N/2-1) * (fs / N);  % Centered

%% Time Axis (in seconds)
t = n / fs;

%% Time Domain Plot (in seconds)
figure;
plot(t, x);
title('Multisine Signal in Time Domain');
xlabel('Time (s)');
ylabel('Amplitude');
grid on;

%% DFT Plot (Frequency in Hz)
figure;
subplot(2,1,1);
stem(freqs, abs(X), 'b');
title('DFT Amplitude (Hz)');
xlabel('Frequency (Hz)');
ylabel('|X(f)|');
grid on;

subplot(2,1,2);
stem(freqs, angle(X), 'r');
title('DFT Phase (Hz)');
xlabel('Frequency (Hz)');
ylabel('arg(X(f))');
grid on;


%% 3. Excite specific frequency lines
fs = 200;
excited_freqs = [4 8 12 16 20 24];
n = 0:N-1;  % Time indices
t = n / fs;  % Time in seconds

% Initialize signal
x = zeros(1, N);

% Generate Multisine Signal with Specific Frequencies
for k = 1:length(excited_freqs)
    phi_k = 2 * pi * rand;  % Random phase in [0, 2π]
    x = x + cos(2 * pi * excited_freqs(k) * n / fs + phi_k);
end

%% Time Domain Plot
figure;
plot(t, x);
title('Multisine Signal (Specific Frequencies) in Time Domain');
xlabel('Time (seconds)');
ylabel('Amplitude');
grid on;

%% Compute DFT
X = fft(x);
X_shifted = fftshift(X);  % Centered FFT

%% Define Frequency Axis in Hz
freqs = (0:N-1) * (fs / N);  % Non-centered
freqs_shifted = (-N/2:N/2-1) * (fs / N);  % Centered

%% DFT Plot (Frequency in Hz)
figure;
subplot(2,1,1);
stem(freqs, abs(X), 'b');
title('DFT Amplitude (Hz, Specific Frequencies)');
xlabel('Frequency (Hz)');
ylabel('|X(f)|');
grid on;

subplot(2,1,2);
stem(freqs, angle(X), 'r');
title('DFT Phase (Hz, Specific Frequencies)');
xlabel('Frequency (Hz)');
ylabel('arg(X(f))');
grid on;