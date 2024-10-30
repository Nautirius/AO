clear;clc;

%metoda Cramera
A=[1,2,3,4;1,4,9,16;2,5,6,7;1,9,8,3];
b=(1:4)';

W=det(A);

for i=1:4
    A2=A;
    A2(:,i)=b;
    x(i)=det(A2)/W;
end

x

%albo A^(-1)*b ale nieoptymalne bo obracanie macierzy jest drogie