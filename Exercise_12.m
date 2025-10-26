clear; close all; clc;

% ------- Parameters ------------------------------------------
wc   = 1;                 % cutoff frequency (radians)
Nfft = 1024;              % FFT length
Ms   = [20, 64];          % compare these two filter orders
outDir = fullfile('figures');
if ~exist(outDir, 'dir'); mkdir(outDir); end

% ------- Loop through each filter order ----------------------
Hs = cell(1, numel(Ms));
w = linspace(-pi, pi, Nfft);

for k = 1:numel(Ms)
    M = Ms(k);
    n = 0:M;

    % Ideal low-pass impulse response (sinc function)
    hLP = sin(wc * (n - M/2)) ./ (pi * (n - M/2));
    hLP(n == M/2) = wc / pi;  % handle divide-by-zero

    % Plot impulse response
    figure('Color', 'w');
    stem(n, hLP, 'filled'); grid on;
    title(sprintf('Impulse Response h_{LP}(n), M = %d', M));
    xlabel('n'); ylabel('h_{LP}(n)');
    if ~exist(outDir, 'dir')
    mkdir(outDir);
    end
    saveas(gcf, fullfile(outDir, sprintf('hLP_M%d.png', M)));

    % Frequency response
    H = fftshift(fft(hLP, Nfft));
    Hs{k} = abs(H);
end

% ------- Compare magnitude responses -------------------------
figure('Color', 'w');
plot(w/pi, Hs{1}, 'LineWidth', 1.4); hold on;
plot(w/pi, Hs{2}, 'LineWidth', 1.4);
xlabel('\omega/\pi'); ylabel('|H_{LP}(e^{j\omega})|');
title('Magnitude Response Comparison');
legend(arrayfun(@(m) sprintf('M = %d', m), Ms, 'UniformOutput', false), ...
       'Location', 'South');
grid on; xlim([-1 1]);
if ~exist(outDir, 'dir')
    mkdir(outDir);
end
    
saveas(gcf, fullfile(outDir, 'HLP_compare.png'));
