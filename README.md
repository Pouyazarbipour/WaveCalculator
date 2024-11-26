# WaveCalculator Code Explanation
## Overview
This MATLAB script creates a Graphical User Interface (GUI) for a wave calculator. It calculates wave parameters such as wave length, wave speed, and wave height based on user inputs and predefined equations. The program includes interactive elements like input fields, buttons, and result displays, with calculations performed using nested functions.

###1. GUI Initialization
The waveCalculator function initializes the GUI window and elements.

Figure Creation:
matlab
Copy code
f = figure('Position', [100, 100, 400, 400], 'Name', 'Wave Calculator', 'NumberTitle', 'off');
A figure window (f) is created with dimensions 400x400 pixels.
The title is set to "Wave Calculator" without a default figure number.
###2. Deep Water Input Section
This section collects inputs from the user.

Labels and Input Fields:
Example: Wave height input:

matlab
Copy code
uicontrol('Style', 'text', 'Position', [20 310 100 20], 'String', 'Wave Height (m):');
Hin = uicontrol('Style', 'edit', 'Position', [120 310 100 20], 'String', '1.0');
A label and a text box are created to input the wave height (default: 1.0 meters).
Period or Frequency:

matlab
Copy code
torf = uicontrol('Style', 'popup', 'Position', [120 270 100 20], 'String', {'Period', 'Frequency (Hz)'});
Tin = uicontrol('Style', 'edit', 'Position', [240 270 100 20], 'String', '12.0');
A dropdown allows the user to choose between wave period and frequency.
A corresponding input field is provided for entering the selected value (default: 12.0 seconds).
Other Inputs: Inputs for wave angle and local depth are added similarly.

3. Buttons
Buttons allow the user to perform actions such as calculations or resetting fields.

Calculate Button:

matlab
Copy code
uicontrol('Style', 'pushbutton', 'Position', [20 130 100 30], 'String', 'Calculate', 'Callback', @calculateWaveParameters);
Executes the calculateWaveParameters function when clicked.
Reset Button:

matlab
Copy code
uicontrol('Style', 'pushbutton', 'Position', [120 130 100 30], 'String', 'Reset', 'Callback', @resetFields);
Resets all fields to their default values by calling the resetFields function.
4. Results Display
The GUI includes fields to display calculated wave parameters.

Result Labels and Fields:
Example: Displaying wave length (L):

matlab
Copy code
uicontrol('Style', 'text', 'Position', [20 yOffset 100 20], 'String', 'L (m) =');
resultFields.out1 = uicontrol('Style', 'edit', 'Position', [120 yOffset 200 20], 'String', '', 'Enable', 'off');
The result label shows L (m) =, and a non-editable text box displays the computed value.
This pattern is repeated for other parameters like wave number, wave speed, and group velocity.

5. Core Functionalities
5.1 Calculation Function
The calculateWaveParameters function performs the calculations and updates the result fields.

Input Validation: Inputs are read and validated:

matlab
Copy code
H0 = str2double(get(Hin, 'String'));
if isnan(H0), error('Invalid Wave Height'); end
Converts the string from the input field to a number.
If the input is invalid (e.g., non-numeric), an error dialog is shown.
Wave Parameter Calculations: Uses placeholder functions (waveNumber, groupVelocity, etc.) to compute parameters. For example:

matlab
Copy code
k = waveNumber(d, T);
L = 2 * pi / k;
k is calculated using the placeholder waveNumber function.
L (wave length) is derived from k.
Result Updates: Updates the GUI with calculated values:

matlab
Copy code
set(resultFields.out1, 'String', sprintf('%.6f', L));
5.2 Reset Function
The resetFields function restores all input fields to default values:

matlab
Copy code
set(Hin, 'String', '1.0');
set(Tin, 'String', '12.0');
6. Helper Functions
The script uses placeholder helper functions for calculations. These should be replaced with actual scientific formulas.

Wave Number (k):

matlab
Copy code
function k = waveNumber(d, T)
    k = 2 * pi / T;
end
Calculates a simplified wave number. For real applications, this should account for wave dispersion relations.
Refraction Angle (theta):

matlab
Copy code
function Angle = theta(thet0, k, T)
    Angle = thet0; % Simplified
end
A placeholder returning the initial wave angle (thet0).
7. Customization Notes
Replace placeholder functions with accurate formulas as needed.
Expand error handling for robustness.
