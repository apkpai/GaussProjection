function [x,y] = GaussPositiveFormula(a,b,B,L)
%GaussPositiveFormula高斯正算函数
% a=6378245.0;%克拉索夫斯基椭球
% b=6356863.0187730473;
e=sqrt(a*a-b*b)/a;
e_s=sqrt(a*a-b*b)/b;
rou=206265;
c=a*a/b;
B=angle_rad(B);%大地纬度转化为弧度形式
L0=6*(fix(L/6)+1)-3;%6度带中央经度
l=rou*(angle_rad(L)-angle_rad(L0));%经差：单位：秒
t=tan(B);
eta=sqrt(e_s*e_s*cos(B)*cos(B));%η
W=sqrt(1-e*e*sin(B)*sin(B));
V=sqrt(1+e_s*e_s*cos(B)*cos(B));
M=a*(1-e^2)*(1-(e^2)*(sin(B))^2)^(-3/2);%子午圈曲率半径
N=a*(1-(e*e*sin(B)*sin(B)))^(-1/2);%卯酉圈曲率半径
fun_M=@(B)a*(1-e*e)*(1-(e*e)*(sin(B)).^2).^(-3/2);
%AbsTol - 绝对误差容限
%RelTol - 相对误差容限
X=integral(fun_M,0,B,'RelTol',0,'AbsTol',1e-10);%椭球面弧长
x=X+(N/(2*rou*rou))*sin(B)*cos(B)*l*l+(N/(24*power(rou,4)))*sin(B)*power(cos(B),3)*(5-t*t+9*eta*eta+4*power(eta,4))*power(l,4)+(N/(720*power(rou,6)))*sin(B)*power(cos(B),5)*(61-58*t*t+power(t,4))*power(l,6);
y=(N/rou)*cos(B)*l+(N/(6*rou*rou*rou))*power(cos(B),3)*(1-t*t+eta*eta)*l*l*l+(N/(120*power(rou,5)))*power(cos(B),5)*(5-18*t*t+power(t,4)+14*eta*eta-58*eta*eta*t*t)*power(l,5);
end

