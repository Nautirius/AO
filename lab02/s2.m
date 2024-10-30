clear;clc;close all;

im=imread('zubr.jpg');
im=double(im)/255; % normalizacja 0-1

h=2;w=3;
gim=rgb2gray(im);
subplot(h,w,1);
imshow(gim);
subplot(h,w,2);
imhist(gim);

% jasnosc
% dodajemy po tyle samo
b=.2;
bim=gim+b;
bim(bim>1)=1; % przycinanie koncowek
bim(bim<0)=0;

subplot(h,w,4);
imshow(bim);
subplot(h,w,5);
imhist(bim);

x=0:1/255:1;
y=x+b;
y(y>1)=1;
y(y<0)=0;
subplot(h,w,6);
plot(x,y);
ylim([0,1]);

% kontrast
% mierzy roznice miedzy wartosciami
% mozna zwiekszyc np. mnozac
figure;
h=2;w=3;
subplot(h,w,1);
imshow(gim);
subplot(h,w,2);
imhist(gim);

c=2;
cim=gim*c;
cim(cim>1)=1; % przycinanie koncowek
cim(cim<0)=0;

subplot(h,w,4);
imshow(cim);
subplot(h,w,5);
imhist(cim);

x=0:1/255:1;
y=x*c;
y(y>1)=1;
y(y<0)=0;
subplot(h,w,6);
plot(x,y);
ylim([0,1]);

% gamma
% potegowanie
figure;
h=2;w=3;
subplot(h,w,1);
imshow(gim);
subplot(h,w,2);
imhist(gim);

g=.5; % g powyzej jeden rozciagamy wartosci niskie na szersze spektrum, 
% interesuja nas - zwiekszamy ich kontrast, ciemne spychamy do wezszego spektrum
% ponizej - na odwrot
% g, 1/g w zaleznosci od tego co nas interesuje
gaim=gim.^g;
subplot(h,w,4);
imshow(gaim);
subplot(h,w,5);
imhist(gaim);


x=0:1/255:1;
y=x.^g;
y(y>1)=1;
y(y<0)=0;
subplot(h,w,6);
plot(x,y);
ylim([0,1]);


%======================
% b \in (-1,1)
% c \in (0,+inf) w teorii, aplikacyjnie w skali logarytmicznej log(c)
% (-10,0,10)
% g \in (0,+inf) w teorii, aplikacyjnie w skali logarytmicznej log(g)
% (-10,0,10)

% y=cx^g + b

% wyrownanie histogrmu
figure;
h=2;w=2;
subplot(h,w,1);
imshow(gim);
subplot(h,w,2);
imhist(gim);
him=histeq(gim);
subplot(h,w,3);
imshow(him);
subplot(h,w,4);
imhist(him);


