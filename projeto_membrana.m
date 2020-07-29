function [surf_den, f_res, D] = projeto_membrana
%% Opções de projeto
opt = input(['Selecione uma opção \n Opção 1: Cálculo da frequência; \n Opção 2: Cálculo da densidade de superfície; \n'...
    'Opção 3: Cálculo da camada interna. \n']);
if opt == 1
% Cálculo da frequência de ressoâncnia (50 dividido pela raiz quadrada da densidade
% superficial da membrana vezes a espessura da camada interna
surf_den = input('Qual é a densidade superficial? \n'); D = input('Qual é a espessura da camada interna? \n'); % 10 cm de camada
f_res = 50/sqrt(surf_den*D);
elseif opt == 2
% Cálculo da densidade superficial a partir da ressonancia e espessura
% determinada
f_res = input('Qual é a frequência de ressonância? \n'); D = input('Qual é a espessura da camada interna? \n');
surf_den = ((50/f_res)^2)/D;
else opt == 3
% Cálculo da espessura a partir da ressonancia e densidade superficie
% determinada
f_res = input('Qual é a frequência de ressonância? \n'); surf_den = input('Qual é a densidade superficial? \n');
D = ((50/f_res)^2)/surf_den;
end
