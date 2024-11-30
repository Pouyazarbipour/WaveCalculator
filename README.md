# Wave Calculator GUI  

## Overview  
The **Wave Calculator GUI** is a MATLAB-based GUI tool designed to compute various wave parameters such as wave length, wave speed, wave height, and others based on user-provided inputs. The tool provides an interactive interface for entering wave properties and displays calculated results dynamically.  

This application is useful for students, researchers, and engineers working in fields such as oceanography, coastal engineering, and marine structures.  

---

## Features  
- **Interactive GUI**:  
  A user-friendly interface with input fields, dropdown menus, and buttons for calculations.  

- **Customizable Inputs**:  
  Enter wave height, period or frequency, wave angle, and local water depth.  

- **Calculated Parameters**:  
  - Wave length (`L`)  
  - Wave number (`k`)  
  - Wave speed (`C`)  
  - Group velocity (`Cg`)  
  - Shoaling coefficient (`Ks`)  
  - Refraction coefficient (`Kr`)  
  - Resultant wave height (`H`)  
  - Bottom orbital velocity (`u_b`)
  - more Parameters

- **Error Handling**:  
  Input validation ensures that only valid numeric values are accepted. Errors are displayed via pop-up dialogs.  

- **Reset Functionality**:  
  Resets all inputs and outputs to their default values.  

---

## How It Works  

### **Input Fields**
Users can input or select:  
1. **Wave Height (m)**: Enter the initial wave height (default: `1.0`).  
2. **Period or Frequency**:  
   - Choose between period (seconds) or frequency (Hz).  
   - Enter the corresponding value (default: `12.0` seconds).  
3. **Wave Angle (°)**: Enter the wave propagation angle (default: `0.0`).  
4. **Local Depth (m)**: Enter the depth of the water body (default: `5.0`).  

### **Buttons**
1. **Calculate**:  
   Computes all wave parameters using the entered inputs. Results are displayed in the results section.  
2. **Reset**:  
   Clears all results and restores default input values.  

### **Results**
The results section displays the calculated wave parameters in a read-only format. Parameters include wave length, wave speed, and more.  

---

## Installation  
1. Download or clone this repository.  
2. Open the `waveCalculatorGUI.m` file in MATLAB.  
3. Run the script to launch the GUI.  

---

## Dependencies  
This program requires MATLAB R2017b or later. No additional toolboxes are necessary.  

---

## How to Use  
1. Run the script in MATLAB to launch the GUI.  
2. Enter the desired wave parameters in the input fields.  
3. Click **Calculate** to compute wave parameters.  
4. Review results in the output section.  
5. Click **Reset** to clear fields and start a new calculation.  

---

## Future Improvements  
- Replace placeholder functions (`waveNumber`, `groupVelocity`, etc.) with accurate scientific equations.  
- Add visualization of wave characteristics (e.g., wave propagation or refraction).  
- Implement more advanced error handling and validation.  

---

## License  
This project is licensed under the MIT License. See the `LICENSE` file for details.  

---

## Contact  
For questions or feedback, please reach out to pouyazarbipour@gmail.com.
