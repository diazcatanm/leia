% ------------------------------------------------------------------
:- dynamic se_traslada/2, prefiere/2, habilidad/2, relacion/2. % Permite modificar hechos en tiempo de ejecución

% ---------------------------
% Cargar datos de ejemplo
% ---------------------------
cargar_ejemplo :-
    retractall(se_traslada(_, _)),
    retractall(prefiere(_, _)),
    retractall(habilidad(_, _)),
    retractall(relacion(_, _)),

    assertz(se_traslada(ana, buenos_aires)),
    assertz(se_traslada(lucas, la_plata)),
    assertz(se_traslada(lucas, buenos_aires)),
    assertz(se_traslada(sofia, buenos_aires)),
    assertz(se_traslada(marcos, rosario)),
     assertz(se_traslada(marcos, santa_fe)),

    assertz(prefiere(ana, programador)),
    assertz(prefiere(ana, tester)),
    assertz(prefiere(lucas, analista_datos)),
    assertz(prefiere(sofia, disenador)),
    assertz(prefiere(marcos, programador)),

    assertz(habilidad(ana, logica)),
    assertz(habilidad(ana, python)),
    assertz(habilidad(ana, testing)),
    assertz(habilidad(lucas, estadistica)),
    assertz(habilidad(sofia, ilustracion)),
    assertz(habilidad(marcos, java)),
    assertz(habilidad(marcos, diseno_web)),

    assertz(relacion(programador, python)),
    assertz(relacion(programador, java)),
    assertz(relacion(analista_datos, estadistica)),
    assertz(relacion(disenador, ilustracion)),
    assertz(relacion(tester, testing)).

% ---------------------------
% Reglas principales (de razonamiento)
% Cuerpo :- Cabeza
% lo cual significa que si la cabeza es verdadera, entonces el cuerpo es verdadero.
% ---------------------------
apto(Persona, Rol) :-
    prefiere(Persona, Rol),
    habilidad(Persona, Habilidad),
    relacion(Rol, Habilidad).

disponible(Persona, Rol, Ciudad) :-
    apto(Persona, Rol),
    se_traslada(Persona, Ciudad).

% ---------------------------
% Test y visualización
% ---------------------------
listar_disponibles_por_rol_y_ciudad :-
    write('Ingrese rol: '), read(Rol),
    write('Ingrese ciudad: '), read(Ciudad),
    findall(P, disponible(P, Rol, Ciudad), L),
    ( L == [] ->
        writeln('No hay personas disponibles con ese rol en esa ciudad.')
    ; writeln('Personas disponibles:'),
      forall(member(P, L), format('- ~w~n', [P]))
    ).

listar_disponibles_por_rol :-
    write('Ingrese rol: '), read(Rol),
    findall(P, disponible(P, Rol, _), L),
    ( L == [] ->
        writeln('No hay personas disponibles para ese rol.')
    ; writeln('Personas disponibles:'),
      forall(member(P, L), format('- ~w~n', [P]))
    ).

listar_todos_apto :-
    findall((P,R), apto(P,R), L),
    ( L == [] ->
        writeln('No hay datos de aptitud registrados.')
    ; writeln('Personas aptas (Persona - Rol):'),
      forall(member((P,R), L), format('- ~w: ~w~n', [P,R]))
    ).

listar_todas_disponibilidades :-
    findall((P,R,C), disponible(P,R,C), L),  %  findall(ResultadoDeseado, CondicionQueDebeCumplir, ListaResultado)
    ( L == [] ->
        writeln('No hay disponibilidades registradas.')
    ; writeln('Disponibilidades: (Persona - Rol - Ciudad)'),
      forall(member((P,R,C), L), format('- ~w: ~w en ~w~n', [P,R,C]))
    ).

test :-
    cargar_ejemplo,
    writeln('---- TEST DE PROLOG ----'),
    listar_disponibles_por_rol_y_ciudad,
    listar_disponibles_por_rol,
    listar_todos_apto,
    listar_todas_disponibilidades,
    writeln('---- FIN TEST ----').

% ---------------------------
% Menú interactivo , LOS PUNTOS 4, 5, 6, Y 7 SON EN ORDEN A LO QUE ESTA EN EL ENUNCIADO DEL T.P , los demas puntos son de prueba S!!!
% ---------------------------
start_menu :-
    repeat,  %  iteracion hasta que se presione el 8 y finalice el menu.
    nl, %  nueva linea
    writeln('=== Agente Laboral - Menu ==='),
    writeln('1. Cargar datos de ejemplo'),
    writeln('2. Listar personas aptas'),
    writeln('3. Listar todas las disponibilidades'),
    writeln('4. Listar personas disponibles por rol'),
    writeln('5. Listar personas disponibles por rol y ciudad'),
    writeln('6. Mostrar roles posibles de una persona'),
    writeln('7. Verificar si una persona es apta para un rol'),
    writeln('8. Salir'),
    write('Opcion: '), read(Op),
    ejecutar(Op),
    (Op == 8), !.

ejecutar(1) :- cargar_ejemplo, writeln('Datos cargados.'), !.
ejecutar(2) :- listar_todos_apto, !.
ejecutar(3) :- listar_todas_disponibilidades, !.
ejecutar(4) :- listar_disponibles_por_rol, !.
ejecutar(5) :- listar_disponibles_por_rol_y_ciudad, !.
ejecutar(6) :-
    write('Ingrese persona: '), read(P),
    findall(R, apto(P,R), Roles),
    format('Roles posibles de ~w: ~w~n', [P,Roles]), !.
ejecutar(7) :-
    write('Persona: '), read(P),
    write('Rol: '), read(R),
    ( apto(P,R) ->
        writeln('Resultado: APTO')
    ;   writeln('Resultado: NO APTO')
    ), !.
ejecutar(8) :- writeln('Saliendo...'), !.
ejecutar(_) :- writeln('Opcion invalida.'), fail.
