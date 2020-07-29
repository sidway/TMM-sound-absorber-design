%% Demostration of modeling a sound absorbing device with TMM
%% Device: Diaphragmatic bass trap
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


% %==================     SLOTED PANEL LAYER    =====================%
% % Slotted panel inputs (entradas da placa ranhurada )
% slot.spacing = 112.5/1000; % Spacing between slots (center to center) [m]
% slot.width = 62.5/1000;    % Slot width [m]
% slot.thick = 15e-3;       % Slot thickness [m]

% %==================     Membrane Layer    =====================%
[membrane.surf_density, f_res, D] = projeto_membrana;
% % Slotted panel inputs (entradas da placa ranhurada )
% membrane.area = 1;     % [m²]
% membrane.wheight = .3;   % [kg]
% membrane.surf_density = membrane.wheight/membrane.area; %[kg/m²]

% Impedance estimation
[z_mem] = membrane_impedance(in.freq,membrane.surf_density);

%===================     POROUS LAYER      =========================%
% Porous inputs ( entradas do material poroso )
porous.thickness  = 0.5*D;   % thickness ( slot.thick )
porous.resistivity = 12000; % flow resistivity ( resistividade ao fluxo )
porous.flow_resistance = porous.thickness*porous.resistivity; 

% Delany model to estimate acoustics characteristics of porous layer
[kc, zc, zs, ~ ] = zs_gen(porous.resistivity, in.freq, in.rho_0,...
    in.c0, porous.thickness);
%==================    air layer         ===========================%
air.thick = D-porous.thickness;

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% Iniciate final impedance
out.z_final = zeros(1,length(in.freq));

for k = 1:length(in.freq)
    % TMM of Slotted panel Layer
    [ma_sp] = tmm_barrier(z_mem(k));

    % TMM of porous layer
    [ma_porous] = tmm_fluid(zc(k), kc(k), porous.thickness);

    % TMM of air layer
    [ma_ar] = tmm_fluid(  in.c0*in.rho_0, 2*pi*in.freq(k)/in.c0 , air.thick);
    

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
semilogx(in.freq, alpha_system, '-','linew', 2); grid on; hold on
semilogx(in.freq, alpha_porous, '-','linew', 1); grid on
xlim([20 20000]);
title('Absorption Coeficient')
ylabel('Absorção \alpha'); xlabel('in.frequência')
ylim([0 1]);
legend('System',...
    'Porous Layer only','location', 'best')
set(gca,'fontsize', 18)