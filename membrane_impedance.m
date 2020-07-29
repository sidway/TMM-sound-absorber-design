%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% Impedance of a membrane                               %
% Author: Sidney v. C�ndido                             %
% E-mail: sidney.candido@eac.ufsm.br                    %
% Wpp: 48 984551800                                     %
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% Some references:                                      %
% Ac�stica de salas: Projeto e modelagem (Eric Brand�o) %
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% Inputs:   freq = frequency vector                     %
%           surf_den = superficial density (kg/m�)      %
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
function z_memb = membrane_impedance(freq, surf_den)

w = 2*pi*freq; %Angular frequency
z_memb = 1j*w*surf_den; % Impedance of a membrane
