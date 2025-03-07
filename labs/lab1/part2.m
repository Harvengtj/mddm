%% PART2 : DFT OF A (CO)SINE
clear all;
close all;
%% 1. Generate time domain signal
N = 1000;  % Number of samples
T = round(N/3);  % Period != Window length
f = 1/T;  % Frequency
phi = 2*pi*rand;  % Random phase

n = 0:N-1;
x = cos(2*pi*f*n + phi);
figure;
stem(n, x);  
title('Time domain signal');
xlabel('n');
ylabel('Amplitude');
grid on;


%% 2. Compute DFT
X = fft(x);
X_shifted = fftshift(X);  % Shift to center the DFT


%% 3. Plot (frequencies)
freqs1 = (0:N-1)/N;  % Normalized frequency axis BUT NOT centered 
freqs2 = (-N/2:N/2-1)/N;  % Normalized frequency axis and centered

% Not centered DFT
% Amplitude
figure;
subplot(2,1,1);
stem(freqs1, abs(X), 'b'); % Utilisation de stem
title('DFT Amplitude');
xlabel('Normalized frequency [/]')
ylabel('|X(k)|');
grid on;

% Phase
subplot(2,1,2);
stem(freqs1, angle(X), 'r'); % Utilisation de stem
title('DFT Phase');
xlabel('Normalized frequency [/]')
ylabel('arg(X(k))');
grid on;


% Centered DFT
% Amplitude
figure;
subplot(2,1,1);
stem(freqs2, abs(X_shifted), 'b'); % Utilisation de stem
title('DFT Amplitude');
xlabel('Normalized frequency [/]')
ylabel('|X(k)|');
grid on;

% Phase
subplot(2,1,2);
stem(freqs2, angle(X_shifted), 'r'); % Utilisation de stem
title('DFT Phase');
xlabel('Normalized frequency [/]')
ylabel('arg(X(k))');
grid on;


%% 4. Plot (bins)
freqs1 = (0:N-1);  % NOT centered 
freqs2 = (-N/2:N/2-1);  % Centered

% Not centered DFT
% Amplitude
figure;
subplot(2,1,1);
stem(freqs1, abs(X), 'b'); % Utilisation de stem
title('DFT Amplitude');
xlabel('Bin [/]')
ylabel('|X(k)|');
grid on;

% Phase
subplot(2,1,2);
stem(freqs1, angle(X), 'r'); % Utilisation de stem
title('DFT Phase');
xlabel('Bin [/]')
ylabel('arg(X(k))');
grid on;


% Centered DFT
% Amplitude
figure;
subplot(2,1,1);
stem(freqs2, abs(X_shifted), 'b'); % Utilisation de stem
title('DFT Amplitude');
xlabel('Bin [/]')
ylabel('|X(k)|');
grid on;

% Phase
subplot(2,1,2);
stem(freqs2, angle(X_shifted), 'r'); % Utilisation de stem
title('DFT Phase');
xlabel('Bin [/]')
ylabel('arg(X(k))');
grid on;


%% 5. Take into account sampling frequency
fs = 100;  % Sampling frequency
freqs3 = ((0:N-1)/N)*fs;
freqs3_shifted = ((-N/2:N/2-1)/N)*fs;

% Not centered DFT
% Amplitude
figure;
subplot(2,1,1);
stem(freqs3, abs(X), 'b'); % Utilisation de stem
title('DFT Amplitude');
xlabel('Frequency [Hz]')
ylabel('|X(k)|');
grid on;

% Phase
subplot(2,1,2);
stem(freqs3, angle(X), 'r'); % Utilisation de stem
title('DFT Phase');
xlabel('Frequency [Hz]')
ylabel('arg(X(k))');
grid on;


% Centered DFT
% Amplitude
figure;
subplot(2,1,1);
stem(freqs3_shifted, abs(X_shifted), 'b'); % Utilisation de stem
title('DFT Amplitude');
xlabel('Frequency [Hz]')
ylabel('|X(k)|');
grid on;

% Phase
subplot(2,1,2);
stem(freqs3_shifted, angle(X_shifted), 'r'); % Utilisation de stem
title('DFT Phase');
xlabel('Frequency [Hz]')
ylabel('arg(X(k))');
grid on;





