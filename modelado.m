tic

clc;close all; clear all;
%Coordenadas articulares
syms q1 q2 q3 q4 q5 q6 
%Dimensiones de eslabones
syms l1 l2 l3 l4 l5 l6 pi

S01=DHC(0,0,q1,l1);
S12=DHC(pi/2,l2,pi/2+q2,0);
S23=DHC(0,l3,q3,0);
S34=DHC(pi/2,l4,q4,l5);  
S45=DHC(-pi/2,0,q5,0);
S56=DHC(pi/2,0,q6,0);
% S67=DHC(0,0,0,l6);
S67=rotx(pi)*roty(pi/2)*transl(l6,0,0);

S02=S01*S12;
S03=S01*S12*S23;
S04=S01*S12*S23*S34;
S05=S01*S12*S23*S34*S45;
S06=S01*S12*S23*S34*S45*S56;
S07=S01*S12*S23*S34*S45*S56*S67;

%Cinematica directa
CD=S01*S12*S23*S34*S45*S56*S67;

%Coordenadas cartesianas
syms xe ye ze alfa betha gamma

%% Cinematica inversa
%P07 -> Vector de posicion que va de 0 a 7
P07=transl(xe,ye,ze)*rotz(gamma)*roty(betha)*rotx(alfa);
%CD=P07;
%0=CD-P07
ECU=CD-P07;

%Extraccion de la matriz homogenea
%Contiene las variables articulares (q1,q2,...,q6)
%y las coordenadas del efector final (xe,ye,ze)
ecu1=ECU(1,1);
ecu2=ECU(1,2);
ecu3=ECU(1,3);
ecu4=ECU(1,4);

ecu5=ECU(2,1);
ecu6=ECU(2,2);
ecu7=ECU(2,3);
ecu8=ECU(2,4);

ecu9=ECU(3,1);
ecu10=ECU(3,2);
ecu11=ECU(3,3);
ecu12=ECU(3,4);

ecu13=ECU(4,1);
ecu14=ECU(4,2);
ecu15=ECU(4,3);
ecu16=ECU(4,4);

%%Modelo Cinematico Diferencial

%Matrices de rotacion del eslabon i a i+1 para 
%velocidad angular
R01=S01(1:3,1:3);
R12=S12(1:3,1:3);
R23=S23(1:3,1:3);
R34=S34(1:3,1:3);
R45=S45(1:3,1:3);
R56=S56(1:3,1:3);
R67=S67(1:3,1:3);

%Vectores de posicion para velocidad lineal 
P01=S01(1:3,4);
P12=S12(1:3,4);
P23=S23(1:3,4);
P34=S34(1:3,4);
P45=S45(1:3,4);
P56=S56(1:3,4);
P67=S67(1:3,4);

%% Propagacion de velocidades
syms q1p q2p q3p q4p q5p q6p %velocidad de las articulaciones
v00=[0;0;0]; %velocidad de entrada
w00=[0;0;0]; %velocidad angular
Z=[0;0;1];

v11=transpose(R01)*(v00+cross(w00,P01));
w11=transpose(R01)*w00+q1p*Z;

v22=transpose(R12)*(v11+cross(w11,P12));
w22=transpose(R12)*w11+q2p*Z;

v33=transpose(R23)*(v22+cross(w22,P23));
w33=transpose(R23)*w22+q3p*Z;

v44=transpose(R34)*(v33+cross(w33,P34));
w44=transpose(R34)*w33+q4p*Z;

v55=transpose(R45)*(v44+cross(w44,P45));
w55=transpose(R45)*w44+q5p*Z;

v66=transpose(R56)*(v55+cross(w55,P56));
w66=transpose(R56)*w55+q6p*Z;

v77=transpose(R67)*(v66+cross(w66,P67));
w77=transpose(R67)*w66+0*Z;

%JACOBIANO ABSOLUTO 
R07=R01*R12*R23*R34*R45*R56*R67;
v07=R07*v77; 
w07=R07*w77;

J07 =[diff(v07(1),q1p) diff(v07(1),q2p) diff(v07(1),q3p) diff(v07(1),q4p) diff(v07(1),q5p) diff(v07(1),q6p);...
      diff(v07(2),q1p) diff(v07(2),q2p) diff(v07(2),q3p) diff(v07(2),q4p) diff(v07(2),q5p) diff(v07(2),q6p);...
      diff(v07(3),q1p) diff(v07(3),q2p) diff(v07(3),q3p) diff(v07(3),q4p) diff(v07(3),q5p) diff(v07(3),q6p);...
      diff(w07(1),q1p) diff(w07(1),q2p) diff(w07(1),q3p) diff(w07(1),q4p) diff(w07(1),q5p) diff(w07(1),q6p);...
      diff(w07(2),q1p) diff(w07(2),q2p) diff(w07(2),q3p) diff(w07(2),q4p) diff(w07(2),q5p) diff(w07(2),q6p);...
      diff(w07(3),q1p) diff(w07(3),q2p) diff(w07(3),q3p) diff(w07(3),q4p) diff(w07(3),q5p) diff(w07(3),q6p)
      ];
  
J07_simp1=subs(J07,sin(pi),0);
J07_simp2=subs(J07_simp1,cos(pi/2),0);
J07_simp3=subs(J07_simp2,sin(pi/2),1);
J07_simp4=subs(J07_simp3,cos(pi),1);
J07_simp=subs(J07,{cos(pi),sin(pi/2),sin(pi),cos(pi/2)},{1,1,0,0});
  
%JACOBIANO RELATIVO
J77r =[diff(v77(1),q1p) diff(v77(1),q2p) diff(v77(1),q3p) diff(v77(1),q4p) diff(v77(1),q5p) diff(v77(1),q6p);...
      diff(v77(2),q1p) diff(v77(2),q2p) diff(v77(2),q3p) diff(v77(2),q4p) diff(v77(2),q5p) diff(v77(2),q6p);...
      diff(v77(3),q1p) diff(v77(3),q2p) diff(v77(3),q3p) diff(v77(3),q4p) diff(v77(3),q5p) diff(v77(3),q6p);...
      diff(w77(1),q1p) diff(w77(1),q2p) diff(w77(1),q3p) diff(w77(1),q4p) diff(w77(1),q5p) diff(w77(1),q6p);...
      diff(w77(2),q1p) diff(w77(2),q2p) diff(w77(2),q3p) diff(w77(2),q4p) diff(w77(2),q5p) diff(w77(2),q6p);...
      diff(w77(3),q1p) diff(w77(3),q2p) diff(w77(3),q3p) diff(w77(3),q4p) diff(w77(3),q5p) diff(w77(3),q6p)
      ];
  
J77r_simp=subs(J77r,{cos(pi),sin(pi/2),sin(pi),cos(pi/2)},{1,1,0,0});
J77Inv=inv(J77r_simp);
J77Inv_simp=simplify(J77Inv);
  %Estas sustituciones son validas por que: 
  %1. No hay un valor de -pi en los argumentos de las funciones
  %trigonométricas
  %2. La función subs sustituye la expresión previa en la matriz con el valor nuevo y evalua 
  %relaizando toda el álgebra y el aritmética correspondiente
  %3. No modifica la dimensión de la matriz

%Comprobación de independencia lineal 
rank(J77r_simp); 

%DET_simp=simplify(DET);
DET=det(J77r_simp);
SDET = simplify(DET,'Steps',10);

fileID=fopen('DET.txt','w');
fprintf(fileID,'%s',SDET);
fclose(fileID);

%Velocidad directa 
qp=[q1p;q2p;q3p;q4p;q5p;q6p];
xep=J77r_simp*qp;

%Calculo de la aceleracion
q=[q1;q2;q3;q4;q5;q6];

J77p=diff_matrix(J77r_simp,qp,q);
J77p_simp= simplify(J77p);

%% MODELADO DINÁMICO
syms q1pp q2pp q3pp q4pp q5pp q6pp q7pp 
syms m1 m2 m3 m4 m5 m6 m7
syms Ixx1 Iyy1 Izz1 Ixx2 Iyy2 Izz2 Ixx3 Iyy3 Izz3
syms Ixx4 Iyy4 Izz4 Ixx5 Iyy5 Izz5 Ixx6 Iyy6 Izz6
syms cmx1 cmy1 cmz1 cmx2 cmy2 cmz2 cmx3 cmy3 cmz3
syms cmx4 cmy4 cmz4 cmx5 cmy5 cmz5 cmx6 cmy6 cmz6

%Inercias de cada eslabón
I1=diag([Ixx1 Iyy1 Izz1]);
I2=diag([Ixx2 Iyy2 Izz2]);
I3=diag([Ixx3 Iyy3 Izz3]);
I4=diag([Ixx4 Iyy4 Izz4]);
I5=diag([Ixx5 Iyy5 Izz5]);
I6=diag([Ixx6 Iyy6 Izz6]);

%Vectores de posción a los centros de masa
P1_cm1=[cmx1;cmy1;cmz1];
P2_cm2=[cmx2;cmy2;cmz2];
P3_cm3=[cmx3;cmy3;cmz3];
P4_cm4=[cmx4;cmy4;cmz4];
P5_cm5=[cmx5;cmy5;cmz5];
P6_cm6=[cmx6;cmy6;cmz6];

%Energía cinética
k1=1/2*m1*transpose(v11+cross(w11,P1_cm1))*(v11+cross(w11,P1_cm1))+1/2*transpose(w11)*I1*w11;
k2=1/2*m2*transpose(v22+cross(w22,P2_cm2))*(v22+cross(w22,P2_cm2))+1/2*transpose(w22)*I2*w22;
k3=1/2*m3*transpose(v33+cross(w33,P3_cm3))*(v33+cross(w33,P3_cm3))+1/2*transpose(w33)*I3*w33;
k4=1/2*m4*transpose(v44+cross(w44,P4_cm4))*(v44+cross(w44,P4_cm4))+1/2*transpose(w44)*I4*w44;
k5=1/2*m5*transpose(v55+cross(w55,P5_cm5))*(v55+cross(w55,P5_cm5))+1/2*transpose(w55)*I5*w55;
k6=1/2*m6*transpose(v66+cross(w66,P6_cm6))*(v66+cross(w66,P6_cm6))+1/2*transpose(w66)*I6*w66;

kt=k1+k2+k3+k4+k5+k6;

%Energía potencial
% Alturas a los centros de masa
syms g
h1=subs(S01(3,4),l1,cmz1);
h2=subs(S02(3,4),l1,cmz2);
h3=subs(S03(3,4),l3,cmz3);
h4=subs(S04(3,4),[l1 l3 l4],[cmz4 0 0]);
h5=subs(S05(3,4),[l1 l3 l4],[cmz5 0 0]);
h6=subs(S06(3,4),l5,cmz6);

u1=m1*g*h1;
u2=m2*g*h2;
u3=m3*g*h3;
u4=m4*g*h4;
u5=m5*g*h5;
u6=m6*g*h6;

ut=u1+u2+u3+u4+u5+u6;

%Energía total; 
E=kt+ut;

%Langrangiano
L=kt-ut;

q=[q1;q2;q3;q4;q5;q6];
qp=[q1p;q2p;q3p;q4p;q5p;q6p];
qpp=[q1pp;q2pp;q3pp;q4pp;q5pp;q6pp];

Qp=[qp;qpp];

%Ecuaciones de movimiento
% taun_ns(ns=no simplificado)
tau1_ns=[diff(diff(L,q1p),q1)  diff(diff(L,q1p),q2) diff(diff(L,q1p),q3) diff(diff(L,q1p),q4) diff(diff(L,q1p),q5) diff(diff(L,q1p),q6)...
      diff(diff(L,q1p),q1p)  diff(diff(L,q1p),q2p) diff(diff(L,q1p),q3p) diff(diff(L,q1p),q4p) diff(diff(L,q1p),q5p) diff(diff(L,q1p),q6p)]*Qp-diff(L,q1);
tau1=subs(tau1_ns,[cos(pi) sin(pi/2) sin(pi) cos(pi/2)],[1 1 0 0]);

tau2_ns=[diff(diff(L,q2p),q1)  diff(diff(L,q2p),q2) diff(diff(L,q2p),q3) diff(diff(L,q2p),q4) diff(diff(L,q2p),q5) diff(diff(L,q2p),q6)...
      diff(diff(L,q2p),q1p)  diff(diff(L,q2p),q2p) diff(diff(L,q2p),q3p) diff(diff(L,q2p),q4p) diff(diff(L,q2p),q5p) diff(diff(L,q2p),q6p)]*Qp-diff(L,q2);
tau2=subs(tau2_ns,[cos(pi) sin(pi/2) sin(pi) cos(pi/2)],[1 1 0 0]);

tau3_ns=[diff(diff(L,q3p),q1)  diff(diff(L,q3p),q2) diff(diff(L,q3p),q3) diff(diff(L,q3p),q4) diff(diff(L,q3p),q5) diff(diff(L,q3p),q6)...
      diff(diff(L,q3p),q1p)  diff(diff(L,q3p),q2p) diff(diff(L,q3p),q3p) diff(diff(L,q3p),q4p) diff(diff(L,q3p),q5p) diff(diff(L,q3p),q6p)]*Qp-diff(L,q3);
tau3=subs(tau3_ns,[cos(pi) sin(pi/2) sin(pi) cos(pi/2)],[1 1 0 0]);

tau4_ns=[diff(diff(L,q4p),q1)  diff(diff(L,q4p),q2) diff(diff(L,q4p),q3) diff(diff(L,q4p),q4) diff(diff(L,q4p),q5) diff(diff(L,q4p),q6)...
      diff(diff(L,q4p),q1p)  diff(diff(L,q4p),q2p) diff(diff(L,q4p),q3p) diff(diff(L,q4p),q4p) diff(diff(L,q4p),q5p) diff(diff(L,q4p),q6p)]*Qp-diff(L,q4);
tau4=subs(tau4_ns,[cos(pi) sin(pi/2) sin(pi) cos(pi/2)],[1 1 0 0]);

tau5_ns=[diff(diff(L,q5p),q1)  diff(diff(L,q5p),q2) diff(diff(L,q5p),q3) diff(diff(L,q5p),q4) diff(diff(L,q5p),q5) diff(diff(L,q5p),q6)...
      diff(diff(L,q5p),q1p)  diff(diff(L,q5p),q2p) diff(diff(L,q5p),q3p) diff(diff(L,q5p),q4p) diff(diff(L,q5p),q5p) diff(diff(L,q5p),q6p)]*Qp-diff(L,q5);
tau5=subs(tau5_ns,[cos(pi) sin(pi/2) sin(pi) cos(pi/2)],[1 1 0 0]);

tau6_ns=[diff(diff(L,q6p),q1)  diff(diff(L,q6p),q2) diff(diff(L,q6p),q3) diff(diff(L,q6p),q4) diff(diff(L,q6p),q5) diff(diff(L,q6p),q6)...
      diff(diff(L,q6p),q1p)  diff(diff(L,q6p),q2p) diff(diff(L,q6p),q3p) diff(diff(L,q6p),q4p) diff(diff(L,q6p),q5p) diff(diff(L,q6p),q6p)]*Qp-diff(L,q6);
tau6=subs(tau6_ns,[cos(pi) sin(pi/2) sin(pi) cos(pi/2)],[1 1 0 0]);

%% Modelo dinámico en forma matricial
%Matriz de inercias
M=[diff(tau1,q1pp),diff(tau1,q2pp),diff(tau1,q3pp),diff(tau1,q4pp),diff(tau1,q5pp),diff(tau1,q6pp);...
   diff(tau2,q1pp),diff(tau2,q2pp),diff(tau2,q3pp),diff(tau2,q4pp),diff(tau2,q5pp),diff(tau2,q6pp);...
   diff(tau3,q1pp),diff(tau3,q2pp),diff(tau3,q3pp),diff(tau3,q4pp),diff(tau3,q5pp),diff(tau3,q6pp);...
   diff(tau4,q1pp),diff(tau4,q2pp),diff(tau4,q3pp),diff(tau4,q4pp),diff(tau4,q5pp),diff(tau4,q6pp);...
   diff(tau5,q1pp),diff(tau5,q2pp),diff(tau5,q3pp),diff(tau5,q4pp),diff(tau5,q5pp),diff(tau5,q6pp);...
   diff(tau6,q1pp),diff(tau6,q2pp),diff(tau6,q3pp),diff(tau6,q4pp),diff(tau6,q5pp),diff(tau6,q6pp)];
rank(M)

%Matriz de torque gravitacional
g1=subs(tau1,Qp,zeros(12,1));
g2=subs(tau2,Qp,zeros(12,1));
g3=subs(tau3,Qp,zeros(12,1));
g4=subs(tau4,Qp,zeros(12,1));
g5=subs(tau5,Qp,zeros(12,1));
g6=subs(tau6,Qp,zeros(12,1));

G=[g1;g2;g3;g4;g5;g6];

%Matriz de fuerzas centrífugas y coriolis (todo lo relacionado a la
%velocidad)
%Calculo de Mp
Mp=diff_matrix(M,qp,q);
KE=1/2*transpose(qp)*M*qp;
dKE=[diff(KE,q1);diff(KE,q2);diff(KE,q3);diff(KE,q4);diff(KE,q5);diff(KE,q6)];

C=Mp*qp-dKE;

%Mp(6x)*qp(6x1)
parametros
Me=eval(M);
Ce=eval(C);
Ge=eval(G);

toc