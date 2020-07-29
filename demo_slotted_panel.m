%% Demostration of modeling a sound absorbing device with TMM
%% Device: Slotted Panel ("Palets" acusticos)
% Referencias: 
% 1. Classroom NOTES by Paulo Mareze
% 2. On the Design of Resonant Absorbers Using
% a Slotted Plate Ulf R. Kristiansen & Tor Erik Vigran (1994)
%
% writen by Sidney Volney Cândido (29/07/2020)
%
% email: sidney.candido@eac.ufsm.br
% wpp: (48) 984551800
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
clear

% General Inputs
in.freq =exp(log(20):0.02:log(20000));
in.c0 = 343; % Velocidade do som no ar
in.rho_0 = 1.2;      % densidade do ar
in.eta = 1.82*10^-5; 
f = config_plot(20,20000); % axes configurations

%==================     SLOTED PANEL LAYER    =====================%
% Slotted panel inputs (entradas da placa ranhurada )
slot.spacing = 112.5/1000; % Spacing between slots (center to center) [m]
slot.width = 62.5/1000;    % Slot width [m]
slot.thick = 15e-3;       % Slot thickness [m]

% Impedance estimation
[z_sp] = impedance_slotted_panel(slot.width,slot.spacing, slot.thick,...
    in.eta, in.rho_0, in.freq);

%===================     POROUS LAYER      =========================%
% Porous inputs ( entradas do material poroso )
porous.thickness = 50e-3;   % thickness ( slot.thick )
porous.resistivity = 15000; % flow resistivity ( resistividade ao fluxo )
porous.flow_resistance = porous.thickness*porous.resistivity; 

% Delany model to estimate acoustics characteristics of porous layer
[kc, zc, zs, ~ ] = zs_gen(porous.resistivity, in.freq, in.rho_0,...
    in.c0, porous.thickness);

% Iniciate final impedance
out.z_final = zeros(1,length(in.freq));

for k = 1:length(in.freq)
    % TMM of Slotted panel Layer
    [ma_sp] = tmm_barrier(z_sp(k));

    % TMM of porous layer
    [ma_porous] = tmm_fluid(zc(k), kc(k), porous.thickness);

    % TMM of air layer
    [ma_ar] = tmm_fluid(  in.c0*in.rho_0, 2*pi*in.freq(k)/in.c0 , 0.1);
    

    % Global Matrix
    ma_gg = ma_sp*ma_porous*ma_ar;

  
    % Surface impedance of the system
    out.z_final(k)=(ma_gg(1,1)/ma_gg(2,1));
end
clear ma_gg k ma_ar ma_porous ma_sp 
% Computing Absorption coeficient in third octave
% porous (to compare)
[~, alpha_porous] = reflection_and_absorption_coefficient(zs,in.rho_0*in.c0);
[third_bands,alpha_third_porous,] = narrow_to_one_third_octave(in.freq,alpha_porous);
% system
[~, alpha_system] = reflection_and_absorption_coefficient(out.z_final,in.rho_0*in.c0);
[~,alpha_third_system,] = narrow_to_one_third_octave(in.freq,alpha_system);

%% Absorption Plot
figure('Name', 'absorção')
set(gcf, 'Position', get(0, 'Screensize'));

plot_absorption(in.freq, alpha_system, f, '-', [0 0 1]); hold on
plot_absorption(in.freq, alpha_porous, f, '-', [1 0 0]); hold on
title('Coeficiente de absorção')
legend('System',...
    'Porous Layer only','location', 'best')
set(gca,'fontsize', 18)