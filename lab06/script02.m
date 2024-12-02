clear;clc;close all;

im2=rgb2gray(double(imread("ptaki2.jpg"))/255);
figure;
imshow(im2);

%w kolorze
figure;
h=3; w=2;
im_rgb2=double(imread("ptaki2.jpg"))/255;
for i=1:h
    l=im_rgb(:,:,i);
    subplot(h,w,i*2-1);
    imshow(l);
    subplot(h,w,i*2);
    imhist(l);
end

b=imbinarize(im_rgb(:,:,3));
bim2=~b;%r|~b; %logiczne lub

bim2=imclose(bim2, ones(5));
bim2=imopen(bim2, ones(5));
figure;
imshow(bim2);

%duzo ucietych i duzo calych obiektow


l2=bwlabel(bim2);

for i=1:max(l2(:))
    if sim(l2==i,'all') < 1000
        l2(l2==i)=0;
    end
end
l2=bwlabel(l2>0);
n2=max(l2(:));
M2;

% area - pole powierzchni (ile pikseli)
% centroid - srodek masy (fizyczny)
% bounding box - najmniejsy prostokat zamykajacy figure rownolegly do osi ukladu
% majoraxis - os glowna - najwieksza rozpietosc obiektu
% minoraxis - pod katem prostym do osi glownej
% z obu mozna okreslic prostokat okalajacy nie rownolegly do osi
% eccentricity - jak bardzo jest przesuniety srodek masy do srodka osrodka (0-1)
% oerientation
% circularity - 
% Image - obraz z bounding boxa
% FilledImage - obrazek co wyzej tylko  wypelnionymi dziurami
% Ekstrema - wspolrzedne punktow ekstremalnych (lewo prawo gora dol)
% Solidity - stosunek pola bounding boxa do pola obiektu
% perimiter (old) - obwod (stary sposob liczenia)

% osie Fereta - dlugosci bounding boxa - malo praktyczne

% wymiary porownujemy do kola
% bierzemy kolo o takim samym polu co ksztalt
% Ra = sqrt(A/pi); d = Ra*2;
% pole mozemy opisac jedna liczba
% malo praktyczne


% dobieramy kolo, ktore ma ten sam obwod co figura
% Rp=P/2*pi
% niezaleznie od skali stosunek Ra/Rp jest taki sam (circularity)
% im figury bardziej podobne do kola tym bardziej te promienie sa takie same
% circularity - (0-1] (jeden bo kolo ma najwieksze pole przy danym
% obwodzie)

% Rp/Ra - 1 (0, 1] im blizej kola tym blizej zera - wsp. Malinowskiego


% srednia odleglosci punktow od srodka masy
% dla kola mala srednia (najmniejsza)
% stosunek to wsp. Blair-Bliss
bb=AO5RBlairBliss(l==4);

% przecietna odleglosc pikseli na krawedzi od srodka masy
% wsp. Danielssona

% srednia odleglosc punktow od krawedzi - wsp Haralika
% niski przy figurach porowatych

% wsp Fereta - stosunek wymiarow bounding boxa - malo przydatne
% ok gdy mamy taka sama figure, w roznych orientacjach - zmiana orientacji

f={@AO5RBlairBliss, @AO5RCircularityL, @AO5RCircularityS, @AO5RDanielsson, @AO5RFeret, @AO5RHaralick, @AO5RMalinowska, @AO5RShape};

M=zeros(n, length(f));
% macierz M: wiersze - kaczki, kolumny - wspolczynniki
for i=1:n
    for j=1:length(f)
        M(i,j)=f{j}(l==i);
    end
end

% osma ges jest inna (przycieta)
mg=mean(M);
sig=std(M);
c=abs(M-mg)./sig; % roznica miedzy srednia gesia (w odchyleniach)
% mniejsza niz 3 sigmy (2 z kawalkiem)
% 1 sigma - 67.7% ;2 - 95%; 3 - 99.7
% jak wieksze niz 3 sigmy to 3 promile szansy, ze to jest ges
% po 3 sigmach mozemy przyjac ze to nie jest ges

% osma nie przekracza, bo liczac srednia i odchylenie wliczamy ja
% mozemy usunac outliera na czas obliczen (mp po medianie albo skrajnych
% watosciach)
% lub po kolei liczymy statystyki dla wszyskich bez "leave one out"

for i=1:n
    tM=M;
    tM(i,:)=[];
    mg=mean(tM);
    sig=std(tM);
    c(i,:)=abs(M(i,:)-mg)./sig;
end

%teraz dla ostatniej gesi wszystkie wartosci przekraczaja 3 sigmy

test=c>3;
test=sim(test,2)>1;
M(test,:)
idx=find(test); %znajduje obiekt nietypowy
c(l==idx)=0; %usuniecie nietypowego obiektu

%aktualizacja wartosci po usunieciu obiektu
l=bwlabel(l>0);
n=max(l(:));
M(idx,:)=[];