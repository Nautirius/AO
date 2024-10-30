clear;clc;close all; % zamkniecie wszystkich okien

im=imread('zubr.jpg');
% imshow(im);
im=double(im)/255; % normalizacja 0-1
% imshow(im);
% figure; % otworzenie nowego okna
% imshow(im);

h=2; w=2;
subplot(h,w,1);
imshow(im);
r=im(:,:,1);
subplot(h,w,2);
imshow(r);
g=im(:,:,2);
subplot(h,w,3);
imshow(g);
b=im(:,:,3);
subplot(h,w,4);
imshow(b);

figure;
h=3; w=2;

for i=1:h
    l=im(:,:,i);
    subplot(h,w,i*2-1);
    imshow(l);
    subplot(h,w,i*2);
    imhist(l);
end


% obraz kolorowy do skali szarosci - np. srednia z rgb
figure;
gim=mean(im,3);
subplot(1,2,1);
imshow(gim);

% model YUV = [.299,.587,.144] = wagi rgb dla skali szarosci - zielonego
% swiatla dociera najwiecej, naturalne dla czlowieka jest jego wyroznienie
% srednia wazona
% funkcja permute do obrocenia wektora
YUV=permute([.299,.587,.144],[1,3,2]);
gim=sum(im.*YUV,3);
subplot(1,2,2);
imshow(gim);

% mozna tez skorzystac z funkcji
figure;
gim=rgb2gray(im);
imshow(gim);
