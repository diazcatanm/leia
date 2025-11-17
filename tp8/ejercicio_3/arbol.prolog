% HECHOS:
% --------------------------------
mujer(mary).
mujer(clara).
mujer(ashlynn).
mujer(auravei).
hombre(william).
hombre(tomas).
hombre(herbert).
hombre(simon).
hombre(lionel).
padre(tomas, herbert).
padre(tomas, simon).
madre(auravei, herbert).
madre(auravei, simon).
padre(simon, mary).
madre(clara, mary).
padre(william, clara).
madre(ashlynn, clara).
padre(william, lionel).
madre(ashlynn, lionel).

% --------------------------------
% REGLAS:
% --------------------------------

progenitor(A, B) :- padre(A, B).
progenitor(A, B) :- madre(A, B).

% A es antepasado de B si es progenitor...
antepasado(A, B) :- progenitor(A, B).
% O si existe un antepasado C intermedio.
% antepasado(A, B) :- antepasado(A, C), antepasado(C, B).
% Aunque parece que eso da error por la recursión en el primer término...
% Otra manera de expresarlo es que A sea progenitor de un C que es antepasado de B.
antepasado(A, B) :- progenitor(A, C), antepasado(C, B).

% hermane = hermano/a
% El \= se cumple si A es distinto de B. Esto evita que cada persona sea su propio hermane.
hermane(A, B) :- progenitor(C, A), progenitor(C, B), A \= B.
hermano(A, B) :- hermane(A, B), hombre(A).
hermana(A, B) :- hermane(A, B), mujer(A).

% abuele = abuelo/a
abuele(A, B) :- progenitor(A, C), progenitor(C, B).
abuela(A, B) :- abuele(A, B), mujer(A).
abuelo(A, B) :- abuele(A, B), hombre(A).


