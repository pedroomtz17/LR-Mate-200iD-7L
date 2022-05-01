clc;close all; clear all;
syms q1 q2 q3 q4 q5 q6
syms l1 l2 l3 l4 l5 l6 pi

S01=DHC(0,0,q1,l1);
S12=DHC(pi/2,l2,pi/2+q2,0);
S23=DHC(0,l3,q3,0);
S34=DHC(pi/2,l4,q4,l5);  
S45=DHC(-pi/2,0,q5,0);
S56=DHC(pi/2,0,q6,0);
S67=rotx(pi)*roty(pi/2)*transl(l4,0,0);

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

