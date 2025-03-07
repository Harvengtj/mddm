%% INFLUENCE OF THE PHASE OF MULTISINE
clear all;
close all;

N = 500; % Number of samples
K = 60;  % Number of excited frequencies

% Phases
rand_phases = 2*pi*rand(1, K);  % Random phases
schroeder_phases = cumsum((1:K) * pi / K);  % Schroeder phases
linear_phases = (1:K) * pi;  % Linear phases
cst_phases = zeros(1, K);  % Constant phases (all zeros)

% Store phases in a cell array
phases = {rand_phases, schroeder_phases, linear_phases, cst_phases};

% Initialize cells to store DFT and IDFT results
DFT = cell(1, 4);
IFT = cell(1, 4);

% Generate signals for each phase type
for i = 1:4
    % Construct X_tilde in the frequency domain
    X_tilde = zeros(1, N); % Initialize frequency domain vector
    X_tilde(2:K+1) = 0.5 * exp(1j * phases{i}); % Assign non-zero values for 1 <= k <= K
    
    % Compute the inverse DFT to get the time domain signal
    x_n = 2 * N * real(ifft(X_tilde, N)); % Compute the inverse FFT and take the real part
    
    % Store results
    DFT{i} = X_tilde;
    IFT{i} = x_n;
end

% Time domain plot
figure;
for i = 1:4
    subplot(4, 1, i);
    plot(IFT{i}); % Plot the time domain signal
    title(['Time Domain - Phase Type ', num2str(i)]);
    xlabel('Sample Number');
    ylabel('Amplitude');
end
grid on;

% Frequency domain plot
figure;
for i = 1:4
    subplot(4, 1, i);
    stem(0:N-1, abs(DFT{i})); % Plot the magnitude of X_tilde
    title(['Frequency Domain - Phase Type ', num2str(i)]);
    xlabel('Bin Number');
    ylabel('Magnitude');
    xlim([0, K+10]); % Limit x-axis to show only relevant bins
end
grid on;

figure;
for i = 1:4
    subplot(4, 1, i);
    stem(0:N-1, angle(DFT{i})); % Plot the phase of X_tilde
    title(['Frequency Domain (Phase) - Phase Type ', num2str(i)]);
    xlabel('Bin Number');
    ylabel('Phase (radians)');
    xlim([0, K+10]); % Limit x-axis to show only relevant bins
end
grid on;


%% 2. Crest Factors

% Initialize a vector to store Crest Factors
crest_factors = zeros(1, 4);

% Compute Crest Factor for each signal
for i = 1:4
    % Peak value (maximum absolute value)
    peak_value = max(abs(IFT{i}));
    
    % RMS value
    rms_value = sqrt(mean(IFT{i}.^2));
    
    % Crest Factor
    crest_factors(i) = peak_value / rms_value;
    
    % Display Crest Factor
    fprintf('Crest Factor for Phase Type %d: %.4f\n', i, crest_factors(i));
end