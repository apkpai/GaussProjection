function rad=angle_rad(x)
%角度转化弧度
a=fix(x);%取度数
b1=(x-a)*100;
b=fix(b1);%取分
c=(b1-b)*100;%取秒
d=180*60*60/pi;
rad=(a*60*60+b*60+c)/d;