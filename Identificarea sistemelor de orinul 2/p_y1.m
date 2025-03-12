% Importul și vizualizarea datelor
t = scope19(:,1);  % Vector de timp
u = scope19(:,2);  % Semnal de intrare
y1 = scope19(:,3); % Prima ieșire (fără zero)
y2 = scope19(:,4); % A doua ieșire (cu zero)

 %Reprezentarea grafică
 subplot(2,1,1);
 plot(t, u),grid on;
  legend('u');
 ylabel('u');
 xlabel('timp [s]');
 subplot(2,1,2);
 plot(t, y1), grid on;
 title('Semnalul de intrare și ieșire');
 legend('y1');
 ylabel('y1');
 xlabel('timp [s]');
 % figure;
   %plot(t,[u, y1-3,y2-6]), grid on,shg;
 %  title('Semnalele de intrare și ieșire');
 %  legend('u', 'y1','y2');
 %   ylabel('u / y1 / y2');
 % xlabel('timp [s]');
%% Identificarea neparametrică pentru prima ieșire (fără zero) ---> y1
      % rezonanta
%y                    %u
i1 = 471;        j1 = 464;   %max     
i2 = 495;        j2 = 487;   %min 
i3 = 518;        j3 = 510;   %max 

Au = (u(j1) - u(j2)) / 2   % Amplitudinea pentru intrare
Ay = (y1(i1) - y1(i2)) / 2;   % Amplitudinea pentru ieșire
Mr = Ay / Au;  %1.3279

z=sqrt(1-sqrt(1-(1/(Mr^2))))/sqrt(2);
z=0.4136  ;               % Factorul de amortizare
k1 = mean(y1) / mean(u) ;%1.0187   % Câștig static
wr = 2*pi /(t(i3)-t(i1))         % Pulsatia la rezonanță
wn = wr / sqrt(1 - 2*z^2)    % Pulsatia naturală
% Funcția de transfer
Ns=k1*wn^2;
Ds=[1 2*z*wn wn^2];
H1 = tf(Ns,Ds);

A1=[0,1;-wn^2,-2*z*wn];
B1=[0;k1*wn^2];
C1=[1 0];
D1=0;
sys1=ss(A1,B1,C1,D1);

% Simularea și validarea
yc = lsim(sys1, u, t, [y1(1), (y1(2) - y1(1)) / (t(2) - t(1))]);
figure;
plot(t, yc, t, y1), grid on;
title('Compararea ieșirii simulate yc cu y1');
legend('yc', 'y1');
 ylabel('yc / y1');
 xlabel('timp [s]');

eMPN1 = norm(yc - y1) / norm(y1 - mean(y1))
J=norm(yc-y1)/sqrt(length(y1));

fprintf("eroare medie patratica J : %f\n",J);
fprintf("eraore patratica relativa eMPNc : %f\n", eMPN1);

%% Validare prin autocorelatie  pt y1 =armax
dt = t(2) - t(1)
dy1 = iddata(y1, u, dt);

Marmx_y1 = armax(dy1, [2 1 2 1])
Hz1=tf(Marmx_y1.B,Marmx_y1.A,dt);
Hz1.Variable='z^-1'
Hs1=d2c(Hz1)
figure
resid(Marmx_y1,dy1,'corr',5),shg;
figure
compare(dy1,Marmx_y1),shg;
%% ARX
Marx_y1 = arx(dy1, [2 1 1]) 
Hz=tf(Marx_y1.B,Marx_y1.A,dt)
Hz.Variable='z^-1'
Hs=d2c(Hz)
figure
resid(Marx_y1,dy1,'corr',5),shg;
figure
compare(dy1,Marx_y1),shg;

%% Validare prin intercorelatie pt y1 OE
dt = t(2) - t(1);
dy1 = iddata(y1, u, dt);

Moe_y1 =oe(dy1,[1 2 1])
Hz2=tf(Moe_y1.B,Moe_y1.F,dt)
Hz2.Variable='z^-1'
Hs2=d2c(Hz2)
subplot(121)
resid(Moe_y1,dy1,5),shg;
subplot(122)
compare(dy1,Moe_y1),shg;
%% IV
Miv_y1 = iv4(dy1, [2 1 1])
Hz3=tf(Miv_y1.B,Miv_y1.A,dt);
Hz3.Variable='z^-1'
Hs3=d2c(Hz3)
subplot(121)
resid(Miv_y1,dy1,5),shg;
subplot(122)
compare(dy1,Miv_y1),shg;
%%
i1=28003;i2=28020;%2 maxime pe y
N=i2-i1;%17
Te=t2(2)-t2(1); 
Te_decimare = N*Te;
plot(t2(1:N:end),[u2(1:N:end),y2(1:N:end)])
i3 = 29815;%inceput jos
i4 = 53647;%final jos/inceput sus
i5 = 79297;%final sus
date_id = iddata(y2(i3:N:i4),u2(i3:N:i4),Te_decimare);
date_vd = iddata(y2(i4:N:i5),u2(i4:N:i5),Te_decimare);
%n4sid(date_id,1:10); %rezulta ordin 2

M1=oe(date_id,[3 3 0]);
figure
resid(date_vd,M1,5),shg; 
figure
compare(M1,date_vd),shg; %intercorelatia e validata
Hz2=tf(M1.B,M1.F,Te)
Hz2.Variable='z^-1'
Hs2=d2c(Hz2)
%%
Mpem=pem(date_id,M1);
figure
resid(date_vd,Mpem),shg;
figure
compare(Mpem,date_vd),shg;

