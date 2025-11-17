% --------------------------------
% VACUNAS
% a. SPIKEVAX (Moderna) bivariante (spikevaxBi)
% b. SPIKEVAX (Moderna) monovariante (spikevaxMono)
% c. COMIRNATY (Pfizer-BioNTech) bivariante (comirnaty)
% --------------------------------
% edad_minima(Vacuna, EdadEnAnios).
% contraindicacion(Vacuna, Comorbilidad).

edad_minima(spikevaxBi, 0.5).
edad_minima(spikevaxMono, 0.5).
edad_minima(comirnaty, 12).

contraindicacion(spikevaxBi, anafilaxia_primerDosis).
contraindicacion(spikevaxBi, alergia_primerDosis).
contraindicacion(spikevaxMono, anafilaxia_primerDosis).
contraindicacion(spikevaxMono, alergia_primerDosis).
contraindicacion(comirnaty, anafilaxia_primerDosis).
contraindicacion(comirnaty, alergia_primerDosis).


% --------------------------------
% PERSONAS
% --------------------------------
% edad(Persona, EdadEnAnios).
% comorbilidad(Persona, Comorbilidad).

edad(marianela, 5).
edad(tomas, 35).
edad(valentina, 55).
edad(abril, 27).
edad(carla, 14).
edad(mateo, 0.4).

comorbilidad(marianela, alergia_primerDosis).
comorbilidad(tomas, ninguna).
comorbilidad(valentina, trombocitopenia).
comorbilidad(abril, anafilaxia_primerDosis).
comorbilidad(carla, ninguna).
comorbilidad(mateo, ninguna).


% --------------------------------
% REGLAS
% --------------------------------

% 1. Existe contraindicación p/ una vacuna y una persona si la persona tiene alguna comorbilidad 
% que figure como contraindicacion para esa vacuna.

existe_contraindicacion(Persona, Vacuna) :-
    comorbilidad(Persona, Comorbilidad),
    contraindicacion(Vacuna, Comorbilidad).

% 2. Una vacuna es apta para una persona si se cumple que:
% a. la edad de la persona es mayor o igual a la edad minima autorizada para esa vacuna
% b. no existe ninguna contraindicacion para esa persona.

vacuna_apta_para_persona(Vacuna, Persona) :-
    edad(Persona, Edad),
    edad_minima(Vacuna, Minima),
    Edad >= Minima,
    \+ existe_contraindicacion(Persona, Vacuna).

% 3. Consulta para que vacunas puede recibir una persona: ?- vacuna_para_persona(Persona, Vacuna).

vacuna_para_persona(Persona, Vacuna) :-
    vacuna_apta_para_persona(Vacuna, Persona).

