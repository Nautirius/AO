%F5 odpala skrypt
clear; %czysci workspace
clc; %czysci konsole

a=5;
if a>3
    a=2;
elseif a>2
    a=7;
else
    a=12;
end

while a>3
    a=a-1
end

for i=1:10
    i
    %break/continue
end
%{
komentarz blokowy
%}
% ctrl+r ctrl+t - komentowanie/odkomentowanie