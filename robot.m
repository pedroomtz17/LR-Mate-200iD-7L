function []=robot(q1,q2,q3,q4,q5,q6)
global l1 l2 l3 l4 l5 l6
parametros

S01=DHC(0,0,q1,l1);
S12=DHC(pi/2,l2,pi/2+q2,0);
S23=DHC(0,l3,q3,0);
S34=DHC(pi/2,l4,q4,l5);  
S45=DHC(-pi/2,0,q5,0);
S56=DHC(pi/2,0,q6,0);
S67=rotx(pi)*roty(pi/2)*transl(l6,0,0);

CD=S01*S12*S23*S34*S45*S56*S67;

S02=S01*S12;
S03=S01*S12*S23;
S04=S01*S12*S23*S34;
S05=S01*S12*S23*S34*S45;
S06=S01*S12*S23*S34*S45*S56;
S07=S01*S12*S23*S34*S45*S56*S67;


x=[0 S01(1,4) S02(1,4) S03(1,4) S04(1,4) S05(1,4) S06(1,4) S07(1,4)];
y=[0 S01(2,4) S02(2,4) S03(2,4) S04(2,4) S05(2,4) S06(2,4) S07(2,4)];
z=[0 S01(3,4) S02(3,4) S03(3,4) S04(3,4) S05(3,4) S06(3,4) S07(3,4)];

plot3(x,y,z,'linewidth',3)
hold on 
frame(eye(4),'r',0.2)
% frame(S01,'g',0.2)
% frame(S02,'b',0.2)
% frame(S03,'r',0.2)
% frame(S04,'g',0.2)
% frame(S05,'b',0.2)
% frame(S06,'r',0.2)
frame(S07,'g',0.2)
grid on 
n=2;
axis([-1 1.5 -1.5 1.5 -1.5 1.5])

end 