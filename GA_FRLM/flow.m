function fq=flow(Dx,route,x);
global Px
index=0.6;
fq=x*index*Px(route(1))*Px(route(2))/Dx^2;