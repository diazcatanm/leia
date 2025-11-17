% HECHOS:
% acciones buenas y malas
bueno(ayudar).
malo(mentir).

% que accion hace sebastian 
hace(sebastian,ayudar).
hace(sebastian,mentir).

% REGLAS
% Si alguien hace algo bueno, ese alguien es bueno
es_buena(Persona):-hace(Persona,Accion),bueno(Accion).

% Si alguien hace algo malo, ese alguien es malo.
es_mala(Persona):-hace(Persona,Accion),malo(Accion).
