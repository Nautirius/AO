clear;clc;close all;

im=rgb2gray(double(imread("kaczki.jpg"))/255);

imhist(im);
bim=~imbinarize(im, 0.6); % binaryzacja
bim=imclose(bim, ones(7)); % zamkniecie
%imshow(bim);

% morfologia
% erode, dilate, open, close, fill (wypelnia np. czarne kropki w bialej figure), 
% clean (usuwa szum, np. biale kropki na czarnym tle), remove (usuwa
% srodek, zostawia krawedz),
% skel (skeleton, szklielet obrazu - zbior punktow ktore sa w tej samej
% odleglosci od krawedzi, po jednym pikselu) - inf: tak dlugo az cos sie
% zmienia
sk = bwmorph(bim, "skel", inf);
imshow(sk);
%pt=bwmorph(sk, "endpoints"); % punkty koncowe linii
pt=bwmorph(sk, "branchpoints"); % punkty gdzie sie rozgalezia
imshow(pt);
% obraz mozna obciac do branchpointow i endpointow - i tak mamy sporo
% informacji

% zapisujemy do listy
[y, x]=find(pt);

% zaznaczamy punkty na obrazku
sim=im;
sim(pt)=1;
imshow(sim);

% shrink - wyszczupla; inf - dostaniemy 3 punkty dla 3 kaczek
%bim=bwmorph(bim, "shrink", inf);
%imshow(bim);
% topologiczna liczba Eulera - obiekt - liczba_dziur (bez dziur - 1, jedna
% dziura - 0 itd.)
% jesli ksztalty maja ta sama liczbe eulera, to mozna przeksztalcic jeden w
% drugi
% topologia - plaszczyzny a nie ksztalty
% ksztalty ktore da sie przeksztalcic jeden w drugo sa takie same - kolo i
% kwadrat to topologicznie to samo. Gdy sa dziury (rozna ilosc) to juz nie.
% shrink nie zmienia liczby eulera obiektu (erozja moze zmnienic lub
% zwiekszyc ilosc obiektow)

% thin - schodzimy do linii o grubosci 1 - interesuje nas przebieg
%bim=bwmorph(bim, "thin", inf);
%imshow(bim);
% thicken - zachowana krwedz miedzy obiektami (w przecinienstwie do dilate)
% dostajemy segmenty. w segmencie nie ma zadnych innych obiektow niz jeden obiekt
% (w calosci)
seg=bwmorph(bim, "thicken", inf); % segmentacja przez pogrubianie
imshow(seg);


% liczba obiektow - oznaczanie pikseli (wartosci 0, 1, 2, 3 itd. patrzac po sasiadach)
l=bwlabel(seg);
imshow(label2rgb(l));

% wyswietlamy kaczke nr 2
imshow((l==2).*bim.*im);
% l - podzial na segmenty
% bim - ksztalty
% im - kolory/jasnosci

% ile kaczek na obrazie - max label
m=max(l(:));

% analiza - podzial problemu na czesci
% synteza - polaczenie


% mozemy najpierw podzielic obrazek na regiony, a potem osobno je
% przetwarzac


% inna metoda segmentacji
% transformata odleglosciowa:
% kazdemu pikselowi przypisujemy odleglosc od najblizszego bialego piksela
% (dla bialego odl=0)

d=bwdist(bim, "euclidean"); % (~bim)
imshow(d, [0, max(d(:))]); % kaczki czarne a tlo tym jasniejsze im dalej od kaczki (dla odwrocenia bim na odwrot)\
% zlewiska, wododzialy
% segmentacja wododzialowa
l=watershed(d);
imshow(label2rgb(l));
% bardziej dokladna segmentacja
% domyslnie miara odleglosci/metryka l2 - euklidesowa
% l_1 = |a|+|b| - cityblock (manhattan)
% l_2 = sqrt(a^2+b^2)
% l_inf = max(a,b) - chessboard
% quasi-eucliden
% segmentacja przy OCR (detekcja pisma) - lepiej miec prostokatne segmenty (czebyszew moze
% byc lepszy od euklidesa)

