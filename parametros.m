%parametros
%Distancia de los eslabones
global l1 l2 l3 l4 l5 l6
%masas
global m1 m2 m3 m4 m5 m6 
%Distancia a los centros de masa
global c1x c1y c1z c2x c2y c2z c3x c3y c3z
global c4x c4y c4z c5x c5y c5z c6x c6y c6z
%Inercias
global Ixx1 Iyy1 Izz1 Ixx2 Iyy2 Izz2 Ixx3 Iyy3 Izz3
global Ixx4 Iyy4 Izz4 Ixx5 Iyy5 Izz5 Ixx6 Iyy6 Izz6
global g

l1=0.330;
l2=0.050;
l3=0.440;
l4=0.035;
l5=0.420;
l6=0.080;

m1=4.85;
m2=2.78;
m3=6.36;
m4=2.39;
m5=2.04;
m6=0.45;

 
c1x=-0.01; c1y=0;  c1z=0.08;
c2x=0.02;  c2y=0;  c2z=0.25;
c3x=0.04;  c3y=0;  c3z=0.45;
c4x=0.06;  c4y=0;  c4z=0.68;
c5x=0.25;  c5y=0;  c5z=0.7;
c6x=0.4;   c6y=0;  c6z=0.69;

 
Ixx1=0.05; Iyy1=0.06; Izz1=0.02;
Ixx2=0.20; Iyy2=0.19; Izz2=0.02;
Ixx3=1.40; Iyy3=1.39; Izz3=0.04;
Ixx4=1.11; Iyy4=1.11; Izz4=0.02;
Ixx5=0.99; Iyy5=1.12; Izz5=0.14;
Ixx6=0.22; Iyy6=0;    Izz6=0.07;

 
g =9.81;
