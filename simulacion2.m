%Simulación 2: Cinematica inversa
clc; close all; clear all;
parametros 

global xe ye ze alfa betha gamma
q0=[0,0,0,0,0,0];

for i=0:1:2   
    if(i==0)
        %Posición inicial = robot(0,0,0,0,0,0)
        %Donde (0.55,0,0.805,0,-pi/2,-pi) 
        xe=0.55;ye=0;ze=0.805;
        alfa=0;betha=-pi/2;gamma=-pi;
        q=fsolve(@c_inv,q0)

        figure(i+1)
        robot(q(1),q(2),q(3),q(4),q(5),q(6))
        hold on 
        plot3(xe,ye,ze,'r*')
      
    elseif (i==1)
        %Posición intermedia = (0.824199,0.02975,0.340979,-pi,0,0)
        xe=0.824199;ye=0.02975;ze=0.340979;
        alfa=-pi;betha=0;gamma=0;
        q=fsolve(@c_inv,q0)
        
        figure(i+1)
        robot(q(1),q(2),q(3),q(4),q(5),q(6))
        hold on 
        plot3(xe,ye,ze,'r*')
        
    else 
        %Posicón final = (0.158752,0.790429,0.492442,-pi,deg2rad(-18.779),deg2rad(78.415))
        xe=0.158752;ye=0.790429;ze=0.492442;
        alfa=-pi;betha=deg2rad(-18.779);gamma=deg2rad(78.415);
        q=fsolve(@c_inv,q0)
        
        figure(i+1) 
        robot(q(1),q(2),q(3),q(4),q(5),q(6))
        hold on 
        plot3(xe,ye,ze,'r*')
    end
    i=i+1;
end 