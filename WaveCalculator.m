function waveCalculator()
    % Constants
    g = 9.81; % Acceleration due to gravity
    
    % Hyperbolic functions
    hyperbolicSinh = @(x) (exp(x) - exp(-x)) / 2;
    hyperbolicCosh = @(x) (exp(x) + exp(-x)) / 2;
    hyperbolicTanh = @(x) hyperbolicSinh(x) / hyperbolicCosh(x);

    % Input values (you can modify these as needed or use input function for user inputs)
    Hin = 5;   % Wave Height (H, m)
    Tin = 12;  % Period (T, s) or Frequency (f, Hz)
    din = 5;  % Local Depth (d, m)
    angle0 = 0; % Wave Angle (degrees)
    torf = 'Period'; % 'Period' or 'Frequency'
    
    % If frequency is selected
    if strcmp(torf, 'Frequency')
        frequency = Tin; 
        T = 1 / frequency;
    else
        T = Tin;
    end

    % Perform wave calculations
    [L, k, C, C0, thetaDeg, Cg, n, Ks, Kr, Hshal, ub] = calculateWaveProperties(Hin, T, din, angle0, g, hyperbolicSinh, hyperbolicCosh, hyperbolicTanh);

    % Display the results
    fprintf('L (m) = %.4f\n', L);
    fprintf('k (1/m) = %.4f\n', k);
    fprintf('C (m/s) = %.4f\n', C);
    fprintf('Cg (m/s) = %.4f\n', Cg);
    fprintf('n = Cg / C = %.4f\n', n);
    fprintf('Ks = %.4f\n', Ks);
    fprintf('Kr = %.4f\n', Kr);
    fprintf('Angle (degrees) = %.4f\n', thetaDeg);
    fprintf('H (m) = %.4f\n', Hshal);
    fprintf('ub (m/s) = %.4f\n', ub);
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
