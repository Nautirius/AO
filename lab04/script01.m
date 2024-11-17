im=rgb2gray(double(imread("opera.jpg"))/255);

fim = fft2(im);

A=abs(fim);
phi=angle(fim);

imshow(fftshift(log(A)), [0, max(log(A(:)))]); % log bo dane bardzo maja bardzo rozne wartosci (0-400000) 
% fftshift - przestawienie cwiartek tak, by rozblysk byl w srodku

%A(1,4)=10^5; % zwiekszamy amplitude jednej czestotliwosci - na obrazku pojawia sie fale
% (x,y) - x - ile razy -1 przy krawedzi gornej pojaiw sie max amplitudy (fala), y - bocznej
% konkretny przebieg fal to obrazek opery
% gwiadza - miara zaleznosci miedzy wszystkimi punktami jednoczesnie
% zaleznosci miedzy tymi samymi punktami na obrazku oryginalnym i po
% transformacji
% transformata symetryczna wzgledem srodka (fft liczy tylko polowe)
% zaleznosc - albo dwie wartosci obie jasne lub ciemne albo jedna jasna
% druga ciemna
%wysokie amplitudy wzdluz linii - na obrazie linia pod katem postym do tej
%na transformacie
%wiemy ze jest kreska, ale nie wiemy gdie
% skosy na obrazie -> rozblyski na transformacie

z=A.*exp(1i*phi); % postac eksponencjalna
im2=imshow(abs(ifft2(z)));

% faza - jak funkcje sa przesuniete wzgl siebie
imshow(phi, [-pi,pi]);

% do czego tego mozna uzyc:
% widmo amplitudowe - zaleznosc punktow od sasiadow dla calego obrazu
% jednoczesmie. W dziedzinie czestotliwosiowej filtracja - bieremy
% amplitude i mnoymy prez amplitude filtra - zlozonosc liniowa (lepsza niz
% normalna filtracja)

%normalne filtrowanie:
k=11;
f=ones(k)/k^2;
imfilter(im,f);

%
[h,w]=size(im);
ff=fft2(f,h,w);
fA=abs(ff);
fphi=angle(ff);

% 11x11 prostokatow
imshow(log(fA), log([min(fA(:)), max(fA(:))]));
% dla fazy tez prostokaty (z gradientem)
imshow(fphi, [-pi, pi]);

z=fA.*A.*exp(1i*phi); % filtracja (blur)
im2 = abs(ifft2(z));
imshow(im2);

% inne zastosowanie: im bardziej bialy punkt tym funkcja wazniejsza. mala
% funkcja malo wnosi do obrazu. Sa daleko od srodka, wazne blisko srodka.
% mozna wyrzucic malo wazne wartosci. maska - wazne 1, malo wazne - 0

m=zeros(h,w);
k=100;
m([1:k,end-k:end],[1:k,end-k:end])=1;
imshow(m);

mf=fft2(m,h,w);
mA=abs(mf);
mphi=angle(mf);

z=m.*A.*exp(1i*phi); % filtracja - kompresja
im2 = abs(ifft2(z));
imshow(im2);
% sa standardowe maski (gwiazdy bo zazwyczaj sa kreski pochyle), zazwyczaj
% transformacje cosinusowe (zabki?)



