% Transfer Matrix modeling sound absorbers
% Author: Sidney v. Cândido
% E-mail: sidney.candido@eac.ufsm.br
% Wpp: 48 984551800
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% Some references:
% On the Design of Resonant Absorbers Using
% a Slotted Plate Ulf R. Kristiansen & Tor Erik Vigran (1994)
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

function [z_sp] = impedance_slotted_panel(width_of_slits, spacing, plate_thickness,...
    dyna_coef, rho_0, f)

% 3.2 Matrix elements for the slit resonator

d = width_of_slits;
h = plate_thickness;
w = 2*pi*f; % angular frequency
n = dyna_coef;
eta = d/spacing; % Width/spacing

delta_h = - (d/pi)*log(sin(pi*eta/2)); %end correction

x_p = w*rho_0*(h+2*delta_h); %Imaginary part of impedance

r_p = (1/2)*(sqrt(2*n*rho_0*w)*(4+(2*h/d))); % Real part

z_sp = (r_p + 1j*x_p)/eta; % Final impedance;


