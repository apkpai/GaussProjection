function angle=rad_angle(x)
% 弧度转度数,只能计算正的，负值可以先取绝对值然后360加上所算的值
d=(180*60*60)/pi;
a=x*d;
du=fix(a/3600);
fen=fix((a-du*3600)/60);
miao=(a-du*3600-fen*60);
   if(x>0)
     angle=sprintf('%d.%d.%.4f',du,fen,miao);
   else
     angle=sprintf('%d.%d.%.4f',359+du,59+fen,60+miao);
   end