% Importul și vizualizarea datelor
t = scope19(:,1);  % Vector de timp
u = scope19(:,2);  % Semnal de intrare
y2 = scope19(:,4); % A doua ieșire (cu zero)

% Reprezentarea grafică
figure;
plot(t, u, t, y2), grid on;
title('Semnalul de intrare și ieșire');
legend('u', 'y2');
 ylabel('u / y2');
 xlabel('timp [s]');

%% Identificarea parametrică pentru a doua ieșire (cu zero) ---> y2
      %rezonanta
%y                    %u
i1 = 515;        j1 = 510;   %max     
i2 = 536;        j2 = 529;   %min 
i3 = 558;        j3 = 550;   %max 

Au = (u(j1) - u(j2)) / 2;   % Amplitudinea pentru intrare
Ay = (y2(i1) - y2(i2)) / 2;   % Amplitudinea pentru ieșire
Mr = Ay / Au  %1.5
z=sqrt(1-sqrt(1-(1/(Mr^2))))/sqrt(2);
%z = 0.3568;
z=0.38;
k2 = mean(y2) / mean(u) %1.0241
%Tr = t(j3) - t(j1);
wr = pi /(t(i2)-t(i1))
wn = wr / sqrt(1 - 2*z^2);
ph_r=rad2deg((t(j3)-t(i3))*wr)
%Tz=(tan(-90+rad2deg(ph_r)))/wr %din faza
Tz = sqrt(Mr^2 * 4*z^2 * (1 - z^2) - 1) / wr %din modul
atan
% Funcția de transfer
Ns=k2*wn^2*[Tz 1];
Ds= [1 2*z*wn wn^2];
H2 = tf(Ns,Ds)

% Model spațiu starilor
A1=[0,1;-wn^2,-2*z*wn];
B1=[k2*wn^2*Tz;k2*wn^2-2*z*wn^3*k2*Tz];
C1=[1 0];
D1=0;
sys2=ss(A1,B1,C1,D1);

% Simularea și validarea
yc = lsim(sys2, u, t, [y2(1), 0]);
figure;
plot(t, yc, t, y2), grid on;
title('Compararea ieșirii simulate cu y2');
legend('y2 Simulat', 'y2 Măsurat');
ylabel('yc / y2');
 xlabel('timp [s]')

eMPN2 = norm(yc - y2) / norm(y2 - mean(y2));
J=norm(yc-y2)/sqrt(length(y2));

fprintf("eroare medie patratica J : %f\n",J);
fprintf("eraore patratica relativa eMPN : %f\n", eMPN2);

%% BODE pt y2
%u
ir = 515;        jr = 510;   %max   
wr= 2.9920e+03;
%phr =-68.5714;
Mr =1.5;
phr=(t(jr)-t(ir))*wr; 

      %inceput
%y                    %u        %y                    
i0 = 131;        j0 = 127;   %min   
i1 = 197;        j1 = 194;   %max     
i2 = 248;        j2 = 247;   %min 
i3 = 288;        j3 = 287;   %max 

i4 = 390;        j4 =386;   %min
i5= 418;         j5=415;    %max
i6=444;          j6=440;    %min
i7=468;          j7=464;    %max

w0=pi/abs(t(i0)-t(i1));
w1=pi/abs(t(i2)-t(i3));
w2=pi/abs(t(i4)-t(i5));
w3=pi/abs(t(i6)-t(i7));
M0=(y2(i1)-y2(i0))/(u(j1)-u(j0));
M1=(y2(i3)-y2(i2))/(u(j3)-u(j2));
M2=(y2(i5)-y2(i4))/(u(j5)-u(j4));
M3=(y2(i7)-y2(i6))/(u(j7)-u(j6));
ph0=(t(j0)-t(i0))*w0;
ph1=(((t(j2)-t(i2))*w1));
ph2=(t(j4)-t(i4))*w2;
ph3=(t(j6)-t(i6))*w3;
        %final      
%y                     %u
     % w5
i9 = 616;          j9 = 609;   %min      
i10= 633;          j10 = 627;  %max  
     %w8
i15= 748;          j15=742;    %min
i16= 763;          j16=755;    %max
     %w6
i11= 805;          j11=799;    %min
i12= 819;          j12=812;    %max
     %w7
i13 = 958;         j13 = 951;  %min 
i14 = 969;         j14 =962;   %max

w5=pi/abs(t(i9)-t(i10));
w6=pi/abs(t(i11)-t(i12));
w7=pi/abs(t(i13)-t(i14));
w8=pi/abs(t(i15)-t(i16));
M5=(y2(i10)-y2(i9))/(u(j10)-u(j9));
M6=(y2(i12)-y2(i11))/(u(j12)-u(j11));
M7=(y2(i14)-y2(i13))/(u(j14)-u(j13));
M8=(y2(i16)-y2(i15))/(u(j16)-u(j15));
ph5=((t(j9)-t(i9))*w5);
ph6=((t(j11)-t(i11))*w6);
ph7=(t(j13)-t(i13))*w7;
ph8=(t(j15)-t(i15))*w8;

Wm=abs([w0 w1 w2 w3 wr w5 w8 w6 w7]);
M=[M0 M1 M2 M3 Mr M5 M8 M6 M7];
Wf=abs([w0 w1 w2 w3 wr w5 w7]);
P=[ph0 ph1 ph2 ph3 phr ph5 ph7];

%(20*log10(M7)-20*log10(M8))/(log10(w7)-log10(w8))=-32

%W1=logspace(3,4);
z = 0.3568;
k2 = 1.0241;
wn = 3.2964e+03;
Tz =  1.1182e-04;
% Funcția de transfer
Ns=k2*wn^2*[Tz 1];
Ds=[1 2*z*wn wn^2];

semilogx(Wm,20*log10(M),'*'),grid;hold on
bode(Ns,Ds,logspace(2,4)),hold on;
semilogx(Wf,rad2deg(P),'*'),grid;
%%
subplot(211)
semilogx(Wm,20*log10(M),'*-'),grid;
ylabel('Modul');
 xlabel('w(lg)');
subplot(212)
semilogx(Wf,rad2deg(P),'*-'),grid;
ylabel('Faza');
 xlabel('w(lg)');
 %% Validare prin autocorelatie  pt y2 =armax
dt = t(2) - t(1)
dy2 = iddata(y2, u, dt);

Marmx_y2 = armax(dy2, [2 2 2 0])
Hz2=tf(Marmx_y2.B,Marmx_y2.A,dt)
Hz2.Variable='z^-1'
Hs2=d2c(Hz2)
subplot(121)
resid(Marmx_y2,dy2,'corr',5),shg;
subplot(122)
compare(dy2,Marmx_y2),shg;
%% ARX
Marx_y2 = arx(dy2, [2 2 0])
Hz1=tf(Marx_y2.B,Marx_y2.A,dt)
Hz1.Variable='z^-1'
Hs1=d2c(Hz1)
subplot(121)
resid(Marx_y2,dy2,'corr',5),shg;
subplot(122)
compare(dy2,Marx_y2),shg;

%% Validare prin intercorelatie pt y2 OE
dt = t(2) - t(1);
dy2 = iddata(y2, u, dt);

Moe_y2 =oe(dy2,[2 2 0])
Hz3=tf(Moe_y2.B,Moe_y2.F,dt);
Hz3.Variable='z^-1'
Hs3=d2c(Hz3)
subplot(121)
resid(Moe_y2,dy2,'corr',5),shg;
subplot(122)
compare(dy2,Moe_y2),shg;
%% IV
Miv_y2 = iv4(dy2, [2 2 0])
Hz4=tf(Miv_y2.B,Miv_y2.A,dt);
Hz4.Variable='z^-1'
Hs4=d2c(Hz4)
subplot(121)
resid(Miv_y2,dy2,'corr',5),shg;
subplot(122)
compare(dy2,Miv_y2),shg;