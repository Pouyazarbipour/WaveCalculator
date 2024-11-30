function waveCalculatorGUI()
    % Create the figure for the GUI
    fig = uifigure('Name', 'Wave Calculator', 'Position', [100 100 600 500]);

    % Labels and Input Fields
    uilabel(fig, 'Text', 'Wave Height (H, m):', 'Position', [50 430 150 30]);
    hField = uieditfield(fig, 'numeric', 'Position', [200 430 100 30]);

    uilabel(fig, 'Text', 'Period (T, s) / Frequency (f, Hz):', 'Position', [50 380 220 30]);
    tField = uieditfield(fig, 'numeric', 'Position', [280 380 100 30]);

    uilabel(fig, 'Text', 'Local Depth (d, m):', 'Position', [50 330 150 30]);
    dField = uieditfield(fig, 'numeric', 'Position', [200 330 100 30]);

    uilabel(fig, 'Text', 'Wave Angle (degrees):', 'Position', [50 280 150 30]);
    angleField = uieditfield(fig, 'numeric', 'Position', [200 280 100 30]);

    uilabel(fig, 'Text', 'T or F:', 'Position', [50 230 150 30]);
    torfDropdown = uidropdown(fig, 'Items', {'Period', 'Frequency'}, 'Position', [200 230 100 30]);

    % Output Results Area
    resultArea = uitextarea(fig, 'Position', [50 50 500 150], 'Editable', 'off');

    % Calculate Button
    uibutton(fig, 'Text', 'Calculate', 'Position', [400 230 100 30], ...
        'ButtonPushedFcn', @(btn, event) calculateWave(hField, tField, dField, angleField, torfDropdown, resultArea));
end

function calculateWave(hField, tField, dField, angleField, torfDropdown, resultArea)
    % Read Input Values
    Hin = hField.Value;
    Tin = tField.Value;
    din = dField.Value;
    angle0 = angleField.Value;
    torf = torfDropdown.Value;

    % Constants and Hyperbolic Functions
    g = 9.81; % Acceleration due to gravity
    hyperbolicSinh = @(x) (exp(x) - exp(-x)) / 2;
    hyperbolicCosh = @(x) (exp(x) + exp(-x)) / 2;
    hyperbolicTanh = @(x) hyperbolicSinh(x) / hyperbolicCosh(x);

    % Convert T/F to period or frequency
    if strcmp(torf, 'Frequency')
        frequency = Tin;
        T = 1 / frequency;
    else
        T = Tin;
    end

    % Perform Wave Calculations
    try
        [L, k, C, C0, thetaDeg, Cg, n, Ks, Kr, Hshal, ub] = ...
            calculateWaveProperties(Hin, T, din, angle0, g, hyperbolicSinh, hyperbolicCosh, hyperbolicTanh);

        % Display Results
        resultArea.Value = {
            sprintf('Wave Length (L, m): %.4f', L);
            sprintf('Wave Number (k, 1/m): %.4f', k);
            sprintf('Wave Celerity deep (C0, m/s): %.4f', C0);
            sprintf('Wave Celerity (C, m/s): %.4f', C);
            sprintf('Group Velocity (Cg, m/s): %.4f', Cg);
            sprintf('n = (Cg / C) : %.4f', n);
            sprintf('Shoaling Coefficient (Ks): %.4f', Ks);
            sprintf('Refraction Coefficient (Kr): %.4f', Kr);
            sprintf('Angle (degrees) (deg): %.4f', thetaDeg);
            sprintf('Shallow Water Wave Height (H, m): %.4f', Hshal);
            sprintf('Bottom Velocity (ub, m/s): %.4f', ub);
        };

    catch ME
        % Display Error Message
        resultArea.Value = {'Error:', ME.message};
    end
end

function [L, k, C, C0, thetaDeg, Cg, n, Ks, Kr, Hshal, ub] = calculateWaveProperties(Hin, T, din, angle0, g, hyperbolicSinh, hyperbolicCosh, hyperbolicTanh)
    % Wave number (k) using iterative method
    omega = 2 * pi / T;
    k = omega^2 / g; % Initial guess for k
    for i = 1:1000
        kPrev = k;
        k = omega^2 / (g * tanh(k * din));
        if abs(k - kPrev) < 1e-10
            break;
        end
    end
    
    % Wave length (L) and Celerity (C)
    L = 2 * pi / k;
    C = L / T;
    
    % Deep water values (k0, L0, C0)
    k0 = (2 * pi) / (g * T^2 / (2 * pi));
    L0 = 2 * pi / k0;
    C0 = L0 / T;
    
    % Refraction angle (theta) using Snell's Law
    theta = asin((C / C0) * sin(angle0 * pi / 180)) * 180 / pi;
    thetaDeg = theta;
    
    % Group velocity (Cg)
    n = 0.5 * (1 + (2 * k * din) / sinh(2 * k * din));
    Cg = n * C;
    
    % Shoaling coefficient (Ks)
    Cg0 = C0 / 2; % Deep water group velocity
    Ks = sqrt(Cg0 / Cg);
    
    % Refraction coefficient (Kr)
    Kr = sqrt(cos(angle0 * pi / 180) / cos(theta * pi / 180));
    
    % Shallow water wave height (Hshal)
    Hshal = Ks * Kr * Hin;
    Hb = 0.78 * din;
    
    % Adjust Hshal if it exceeds the breaking height
    if Hshal > Hb
        Hshal = Hb;
    end
    
    % Bottom velocity (ub)
    ub = (2 * pi / T) * (Hshal / 2) / hyperbolicSinh(k * din);
end
