a=[1,2,3];
a=[1,2,3;4,5,6]; %2x3
a=[1:10]; %1,2,..,10
a=[1:.4:10]; %0,0.4,...,9.8
a(1,2); %1.4 indeks od 1
a(1,[1,3]);
a(2,[1:3]);
a(1,end); a(1,end-1);
a(1:end); a(:);
%mozna indeksowac macierz pojedyncza wartoscia - kolumna->wiersz itd. Do
%iterazcji zamiast podwojnej petli
a(a>2);
a(a>2) = 15:18; %nadpisze wartosci w macierzy
b'; %transponowanie
a*b';
a.*b; %element-wise .* ./ .^

x=0:.1:10;
y=sin(x);
plot(x,y)