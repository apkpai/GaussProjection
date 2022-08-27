function du=dfm_du(x)
  x_1=fix(x);
  x_2=fix(100*(x-x_1));
  x_3=round(100*(100*(x-x_1)-x_2));
  du=x_1+x_2/60+x_3/3600;
end