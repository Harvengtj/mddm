%% PART 4 : Frequency domain construction of a multisine

%% 1.  Frequency domain multisine
% Parameters
N = 1000; % Total number of samples
K = 30;  % Number of excited bins
n = 0:N-1;

% Generate random phases
phases = 2*pi*rand(1, K); % Random phases between 0 and 2*pi

% Construct X_tilde in the frequency domain
X_tilde = zeros(1, N); % Initialize frequency domain vector
X_tilde(2:K+1) = 0.5 * exp(1j * phases); % Assign non-zero values for 1 <= k <= K

% Compute the inverse DFT to get the time domain signal
x_n = 2*N*real(ifft(X_tilde, N)); % Compute the inverse FFT

% Time domain plot
figure;
plot(x_n); % Plot the real part of the time domain signal
title('Time Domain');
xlabel('Sample Number');
ylabel('Amplitude');
grid on;

% Frequency domain plot
figure;
stem(n, abs(X_tilde)); % Plot the magnitude of X_tilde
title('Frequency Domain');
xlabel('Bin Number');
ylabel('Magnitude');
xlim([0, K+10]); % Limit x-axis to show only relevant bins
grid on;



%% 2. Specified excited frequency band
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
x_t = 2*N*ifft(X_tilde, N);

% Time vector
t = (0:N-1) / fs;

% Frequency vector
f = (0:N-1) * delta_f;

% Time domain plot
figure;
plot(t, real(x_t));
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