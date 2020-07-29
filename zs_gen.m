%%%% Função Calculo de impedancia de superficie %%%%%
function [kc, Zc, Zs, Vp, resf] = zs_gen(resf, f, ro, co, d1)
         

%             resf=25000; %Resistividade ao fluxo [kg*s^-1*m^-3]
%             f=100:5:10000; %Vetor Frequencia [Hz]
%             ro=1.2; %Densidade do ar [kg/m³]
%             co=343; %Velocidade do ar [m/s]
            w=2*pi.*f;
%             d1=[25*10^-3];
            k0=(2*pi/co).*f;
            V=1000.*f/resf;
            kc = k0.*((1+10.8.*V.^-0.7)-1i*(10.3.*V.^-0.59));
            Zc = ro*co*((1+9.08.*V.^-0.75)-1i*11.9.*(V.^-0.73));
            Zs=-1i*Zc.*cot(kc.*d1); %Impedancia de superficie
            Vp=1-(abs((Zs-ro*co)./(Zs+ro*co))).^2; %Coeficiente de absorção
%             semilogx(f, Vp)
return