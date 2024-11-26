function waveCalculator()
    % Create the figure for the user interface
    f = figure('Position', [100, 100, 400, 400], 'Name', 'Wave Calculator', 'NumberTitle', 'off');
    
    % Deep Water Values Section
    uicontrol('Style', 'text', 'Position', [20 350 360 20], 'String', 'Deep Water Values:', 'FontWeight', 'bold');
    
    % Wave Height
    uicontrol('Style', 'text', 'Position', [20 310 100 20], 'String', 'Wave Height (m):');
    Hin = uicontrol('Style', 'edit', 'Position', [120 310 100 20], 'String', '1.0');
    
    % Period or Frequency Choice
    uicontrol('Style', 'text', 'Position', [20 270 100 20], 'String', 'Period or Frequency:');
    torf = uicontrol('Style', 'popup', 'Position', [120 270 100 20], 'String', {'Period', 'Frequency (Hz)'});
    Tin = uicontrol('Style', 'edit', 'Position', [240 270 100 20], 'String', '12.0');
    
    % Wave Angle
    uicontrol('Style', 'text', 'Position', [20 230 100 20], 'String', 'Wave Angle (°):');
    angle0 = uicontrol('Style', 'edit', 'Position', [120 230 100 20], 'String', '0.0');
    
    % Local Depth
    uicontrol('Style', 'text', 'Position', [20 190 100 20], 'String', 'Local Depth (m):');
    din = uicontrol('Style', 'edit', 'Position', [120 190 100 20], 'String', '5.0');
    
    % Buttons
    uicontrol('Style', 'pushbutton', 'Position', [20 130 100 30], 'String', 'Calculate', 'Callback', @calculateWaveParameters);
    uicontrol('Style', 'pushbutton', 'Position', [120 130 100 30], 'String', 'Reset', 'Callback', @resetFields);
    
    % Results Section
    uicontrol('Style', 'text', 'Position', [20 90 100 20], 'String', 'Results:');
    
    % Result Fields
    resultLabels = {'L (m) =', 'k = 2\pi/L =', 'C = L/T =', 'Cg =', 'n = Cg/C =', 'Ks =', 'Kr =', 'Angle =', 'H =', 'u_b ='};
    resultFields = struct();
    
    yOffset = 50;
    for i = 1:length(resultLabels)
        uicontrol('Style', 'text', 'Position', [20 yOffset 100 20], 'String', resultLabels{i});
        resultFields.(sprintf('out%d', i)) = uicontrol('Style', 'edit', 'Position', [120 yOffset 200 20], 'String', '', 'Enable', 'off');
        yOffset = yOffset - 30;
    end
    
    % Nested functions for callbacks
    function calculateWaveParameters(~, ~)
        try
            % Get input values
            H0 = str2double(get(Hin, 'String'));
            if isnan(H0), error('Invalid Wave Height'); end
            
            T = 0;
            if strcmp(torf.String{torf.Value}, 'Period')
                T = str2double(get(Tin, 'String'));
            else
                freq = str2double(get(Tin, 'String'));
                if isnan(freq) || freq == 0, error('Invalid Frequency'); end
                T = 1 / freq;
            end
            if isnan(T) || T == 0, error('Invalid Period'); end
            
            d = str2double(get(din, 'String'));
            if isnan(d), error('Invalid Local Depth'); end
            
            thet0 = str2double(get(angle0, 'String'));
            if isnan(thet0), thet0 = 0.0; end
            
            % Calculations (Assumed Refract class functions)
            k = waveNumber(d, T);
            L = 2 * pi / k;
            C = L / T;
            Angle = theta(thet0, k, T);
            Cg = groupVelocity(T, d, k);
            n = Cg / C;
            Ks = shoalingCoef(T, Cg);
            Kr = refractionCoef(thet0, Angle);
            H1 = Ks * Kr * H0;
            if H1 > 0.8 * d
                H1 = 0.8 * d;
                set(resultFields.out9, 'String', sprintf('%.6f, breaking', H1));
            else
                set(resultFields.out9, 'String', sprintf('%.6f', H1));
            end
            
            ub = (2 * pi / T) * H1 / (2 * sinh(k * d));
            % Update the result fields
            set(resultFields.out1, 'String', sprintf('%.6f', L));
            set(resultFields.out2, 'String', sprintf('%.6f', k));
            set(resultFields.out3, 'String', sprintf('%.6f', C));
            set(resultFields.out4, 'String', sprintf('%.6f', Cg));
            set(resultFields.out5, 'String', sprintf('%.6f', n));
            set(resultFields.out6, 'String', sprintf('%.6f', Ks));
            set(resultFields.out7, 'String', sprintf('%.6f', Kr));
            set(resultFields.out8, 'String', sprintf('%.6f', Angle));
            set(resultFields.out9, 'String', sprintf('%.6f', H1));
            set(resultFields.out10, 'String', sprintf('%.6f', ub));
        catch ME
            errordlg(['Error: ', ME.message]);
        end
    end

    function resetFields(~, ~)
        % Reset input and output fields
        set(Hin, 'String', '1.0');
        set(Tin, 'String', '12.0');
        set(din, 'String', '5.0');
        set(angle0, 'String', '0.0');
        set(torf, 'Value', 1);
        for i = 1:length(resultLabels)
            set(resultFields.(sprintf('out%d', i)), 'String', '');
        end
    end
end

% Helper functions for wave calculations
function k = waveNumber(d, T)
    % Placeholder calculation for wave number
    k = 2 * pi / T;
end

function Angle = theta(thet0, k, T)
    % Placeholder for refraction angle calculation
    Angle = thet0; % This would typically use k and T
end

function Cg = groupVelocity(T, d, k)
    % Placeholder for group velocity
    Cg = 2 * pi / T; % Simplified
end

function Ks = shoalingCoef(T, Cg)
    % Placeholder for shoaling coefficient
    Ks = 1; % Simplified
end

function Kr = refractionCoef(thet0, Angle)
    % Placeholder for refraction coefficient
    Kr = 1; % Simplified
end
