tic

clc;close all; clear all;
syms q1 q2 q3 q4 q5 q6
syms l1 l2 l3 l4 l5 l6 pi

S01=DHC(0,0,q1,l1);
S12=DHC(pi/2,l2,pi/2+q2,0);
S23=DHC(0,l3,q3,0);
S34=DHC(pi/2,l4,q4,l5);  
S45=DHC(-pi/2,0,q5,0);
S56=DHC(pi/2,0,q6,0);
S67=rotx(pi)*roty(pi/2)*transl(l6,0,0);

S02=S01*S12;
S03=S01*S12*S23;
S04=S01*S12*S23*S34;
S05=S01*S12*S23*S34*S45;
S06=S01*S12*S23*S34*S45*S56;
S07=S01*S12*S23*S34*S45*S56*S67;

%Cinematica directa
CD=S01*S12*S23*S34*S45*S56*S67;

%Coordenadas
syms xe ye ze alfa betha gamma

%Cinematica inversa
P07=transl(xe,ye,ze)*rotz(gamma)*roty(betha)*rotx(alfa);

ECU=CD-P07;

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

%%Modelo Cinemático Diferencial

%Matrices de rotación del eslabón i a i+1 para 
%velocidad angular
R01=S01(1:3,1:3);
R12=S12(1:3,1:3);
R23=S23(1:3,1:3);
R34=S34(1:3,1:3);
R45=S45(1:3,1:3);
R56=S56(1:3,1:3);
R67=S67(1:3,1:3);

%Vectores de posición para velocidad lineal 
P01=S01(1:3,4);
P12=S12(1:3,4);
P23=S23(1:3,4);
P34=S34(1:3,4);
P45=S45(1:3,4);
P56=S56(1:3,4);
P67=S67(1:3,4);

%Propagación de velocidades
syms q1p q2p q3p q4p q5p q6p
v00=[0;0;0]; w00=[0;0;0];
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
  
  %JACOBIANO RELATIVO
  J77r =[diff(v77(1),q1p) diff(v77(1),q2p) diff(v77(1),q3p) diff(v77(1),q4p) diff(v77(1),q5p) diff(v77(1),q6p);...
      diff(v77(2),q1p) diff(v77(2),q2p) diff(v77(2),q3p) diff(v77(2),q4p) diff(v77(2),q5p) diff(v77(2),q6p);...
      diff(v77(3),q1p) diff(v77(3),q2p) diff(v77(3),q3p) diff(v77(3),q4p) diff(v77(3),q5p) diff(v77(3),q6p);...
      diff(w77(1),q1p) diff(w77(1),q2p) diff(w77(1),q3p) diff(w77(1),q4p) diff(w77(1),q5p) diff(w77(1),q6p);...
      diff(w77(2),q1p) diff(w77(2),q2p) diff(w77(2),q3p) diff(w77(2),q4p) diff(w77(2),q5p) diff(w77(2),q6p);...
      diff(w77(3),q1p) diff(w77(3),q2p) diff(w77(3),q3p) diff(w77(3),q4p) diff(w77(3),q5p) diff(w77(3),q6p)
      ];
 
  %Estas sustituciones son validas por que: 
  %1. No hay un valor de -pi en los argumentos de las funciones
  %trigonométricas
  %2. La función subs sustituye la expresión previa en la matriz con el valor nuevo y evalua 
  %relaizando toda el álgebra y el aritmética correspondiente
  %3. No modifica la dimensión de la matriz
  
J07_simp1=subs(J07,sin(pi),0);
J07_simp2=subs(J07_simp1,cos(pi/2),0);
J07_simp3=subs(J07_simp2,sin(pi/2),1);
J07_simp4=subs(J07_simp3,cos(pi),1);

J07_simp=subs(J07,{cos(pi),sin(pi/2),sin(pi),cos(pi/2)},{1,1,0,0});

%Comprobación de independencia lineal 
rank(J07); 
 
DET=det(J07_simp)
%DET_simp=simplify(DET);

fileID=fopen('DET.txt','w');
fprintf(fileID,'%s',DET);
fclose(fileID);

toc