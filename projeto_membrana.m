function [surf_den, f_res, D] = projeto_membrana
%% Op��es de projeto
opt = input(['Selecione uma op��o \n Op��o 1: C�lculo da frequ�ncia; \n Op��o 2: C�lculo da densidade de superf�cie; \n'...
    'Op��o 3: C�lculo da camada interna. \n']);
if opt == 1
% C�lculo da frequ�ncia de resso�ncnia (50 dividido pela raiz quadrada da densidade
% superficial da membrana vezes a espessura da camada interna
surf_den = input('Qual � a densidade superficial? \n'); D = input('Qual � a espessura da camada interna? \n'); % 10 cm de camada
f_res = 50/sqrt(surf_den*D);
elseif opt == 2
% C�lculo da densidade superficial a partir da ressonancia e espessura
% determinada
f_res = input('Qual � a frequ�ncia de resson�ncia? \n'); D = input('Qual � a espessura da camada interna? \n');
surf_den = ((50/f_res)^2)/D;
else opt == 3
% C�lculo da espessura a partir da ressonancia e densidade superficie
% determinada
f_res = input('Qual � a frequ�ncia de resson�ncia? \n'); surf_den = input('Qual � a densidade superficial? \n');
D = ((50/f_res)^2)/surf_den;
end
