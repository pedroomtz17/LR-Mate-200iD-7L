%parametros
%Distancia de los eslabones
global l1 l2 l3 l4 l5 l6
%masas
global m1 m2 m3 m4 m5 m6 
%Distancia a los centros de masa
global cmx1 cmy1 cmz1 cmx2 cmy2 cmz2 cmx3 cmy3 cmz3
global cmx4 cmy4 cmz4 cmx5 cmy5 cmz5 cmx6 cmy6 cmz6
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

cmx1=0; cmy1=0; cmz1=0.169+0.161/2;%Eslabón 1
cmx2=l2; cmy2=0; cmz2=l1+(l3/2); %Eslabón 2
cmx3=0.162/2; cmy3=0; cmz3=l1+l3; %Eslabón 3
cmx4=l2+(l5/2); cmy4=0; cmz4=0.7875; %Eslabón 4
cmx5=l2+l5+l6/2; cmy5=0; cmz5=l1+l3+l4; %Eslabón 5
cmx6=l2+l5+l6; cmy6=0; cmz6=l1+l3+l4; %Eslabón 6

% plot3(cmx1,cmy1,cmz1,'r*')
% plot3(cmx2,cmy2,cmz2,'r*')
% plot3(cmx3,cmy3,cmz3,'r*')
% plot3(cmx4,cmy4,cmz4,'r*')
% plot3(cmx5,cmy5,cmz5,'b*')
% plot3(cmx6,cmy6,cmz6,'b*')

m1=4.85;
m2=2.78;
m3=6.36;
m4=2.39;
m5=2.04;
m6=0.45;
g=9.81;
 
Ixx1=0.05; Iyy1=0.06; Izz1=0.02;
Ixx2=0.20; Iyy2=0.19; Izz2=0.02;
Ixx3=1.40; Iyy3=1.39; Izz3=0.04;
Ixx4=1.11; Iyy4=1.11; Izz4=0.02;
Ixx5=0.99; Iyy5=1.12; Izz5=0.14;
Ixx6=0.22; Iyy6=0;    Izz6=0.07;