% Transfer Matrix modeling sound absorbers
% Author: Sidney v. Cândido
% E-mail: sidney.candido@eac.ufsm.br
% Wpp: 48 984551800
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% Some references:
% Classrom notes, Paulo Mareze 2015
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% inputs:   zm = barrier impedance (slotted panel, perfored sheet or
% membrane)

function ma_barrier = tmm_barrier (z_sp)

ma_barrier=[1, z_sp; 0, 1]; % Transfer Matrix 



