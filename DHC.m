function sal=DHC(alfa, a, theta, d)


M=[          cos(theta),          -sin(theta),          0,            a;...
   cos(alfa)*sin(theta), cos(alfa)*cos(theta), -sin(alfa), -d*sin(alfa);...
   sin(alfa)*sin(theta), sin(alfa)*cos(theta),  cos(alfa),  d*cos(alfa);...
                      0,                    0,          0,            1];
sal=M;