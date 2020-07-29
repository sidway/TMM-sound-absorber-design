% Transfer Matrix modeling sound absorbers
% Author: Sidney v. Cândido
% E-mail: sidney.candido@eac.ufsm.br
% Wpp: 48 984551800
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% Some references:
% Classrom notes, Paulo Mareze 2015
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% inputs:   zc = caracteristic impedance of fluid
%           kc = caracteristic wavenumber on fluid
%           thickness...
%           caracteristic area (test it)

function [ma_fluid] = tmm_fluid(zc, kc, thickness)

% Impedance matrix of a fluid
ma_fluid=[cos(kc*thickness), 1j*(zc)*sin(kc*thickness);...
    (1j./(zc))*sin(kc*thickness), cos(kc*thickness)];