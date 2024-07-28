% Definición de géneros
hombre(jose).
hombre(carlos).
hombre(augusto).
hombre(orlando).
hombre(stalin).
hombre(jhonny).
hombre(lian).
hombre(jose_tio).
hombre(juan).
hombre(rene).
hombre(adrian).
hombre(leonel).
hombre(jeremy).
hombre(johan).
hombre(pablo).
hombre(jostyn).

mujer(leticia).
mujer(beatriz).
mujer(ramona).
mujer(julia).
mujer(vicky).
mujer(jessica).
mujer(nany).
mujer(angie).
mujer(maria).
mujer(carlotta).
mujer(beatriz_tia).
mujer(july).
mujer(nataly).
mujer(dolores).
mujer(josselyn).
mujer(arely).

% Relaciones de pareja
% bisabuelos y abuelos
pareja(jose, leticia).
pareja(carlos, beatriz).
pareja(augusto, ramona).
pareja(orlando, julia).

%padres
pareja(pablo, dolores).

% Relaciones padre
padre(jose, augusto).
padre(carlos, julia).
padre(augusto, dolores).
padre(augusto, stalin).
padre(augusto, jhonny).
padre(augusto, vicky).
padre(augusto, jessica).
padre(orlando, pablo).
padre(orlando, jose_tio).
padre(orlando, juan).
padre(orlando, maria).
padre(orlando, carlotta).
padre(orlando, beatriz_tia).
padre(orlando, rene).
%primos por parte de padre
padre(rene, nataly).
padre(rene, jeremy).
padre(jose_tio, johan).




%relaciones madre
madre(leticia, augusto).
madre(beatriz, julia).
madre(ramona, dolores).
madre(ramona, stalin).
madre(ramona, jhonny).
madre(ramona, vicky).
madre(ramona, jessica).
madre(julia, pablo).
madre(julia, jose_tio).
madre(julia, juan).
madre(julia, maria).
madre(julia, carlotta).
madre(julia, beatriz_tia).
madre(julia, rene).
% primas por parte de padre
madre(beatriz_tia, adrian).
madre(carlotta, july).
madre(carlotta, leonel).
% primo por parte de madre
madre(vicky, lian).
% primas por parte de madre
madre(jessica, nany).
madre(jessica, angie).

% mis hermanas y yo
padre(pablo, jostyn).
padre(pablo, josselyn).
padre(pablo, arely).
madre(dolores, jostyn).
madre(dolores, josselyn).
madre(dolores, arely).


% 1. Regla para definir hermanos
% Dos personas son hermanos si tienen el mismo padre y la misma madre, y no son la misma persona
hermanos(X, Y) :- padre(P, X), padre(P, Y), madre(M, X), madre(M, Y), X \= Y.

% 2. Regla para definir hijos
% X es hijo de Y si Y es padre o madre de X
hijos(X, Y) :- padre(Y, X) ; madre(Y, X).

% 3. Regla para definir hijo varón
% X es hijo varón de Y si X es hombre y es hijo de Y
hijo(X, Y) :- hombre(X), hijos(X,Y).

% 4. Regla para definir hija
% X es hija de Y si X es mujer y es hija de Y
hija(X, Y) :- mujer(X), hijos(X,Y).

% 5. Regla para definir abuelos
% X es abuelo/a de Y si X es padre/madre del padre/madre de Y
abuelos(X, Y) :- padre(X, P), padre(P, Y)
               ; madre(M, Y), padre(X,M)
               ; madre(X, P), padre(P, Y)
               ; madre(X, P), madre(P, Y).

% 6. Regla para definir abuelo
% X es abuelo de Y si X es hombre y es abuelo de Y
abuelo(X, Y) :- hombre(X), abuelos(X,Y).

% 7. Regla para definir abuela
% X es abuela de Y si X es mujer y es abuela de Y
abuela(X, Y) :- mujer(X), abuelos(X,Y).

% 8. Regla para definir bisabuelos
% X es bisabuelo/a de Y si X es abuelo/a del padre/madre de Y
bisabuelos(X, Y) :- abuelos(X, P), padre(P, Y)
                  ; abuelos(X, M), madre(M, Y).

% 9. Regla para definir bisabuelo
% X es bisabuelo de Y si X es hombre y es bisabuelo de Y
bisabuelo(X, Y) :- hombre(X), bisabuelos(X,Y).

% 10. Regla para definir bisabuela
% X es bisabuela de Y si X es mujer y es bisabuela de Y
bisabuela(X, Y) :- mujer(X), bisabuelos(X,Y).

% 11. Regla para definir tíos
% X es tío/a de Y si X es hermano/a del padre/madre de Y
tios(X, Y) :- padre(P, Y), hermanos(X, P)
            ; madre(M, Y), hermanos(X, M).

% 12. Regla para definir tío
% X es tío de Y si X es hombre y es tío de Y
tio(X,Y) :- hombre(X), tios(X,Y).

% 13. Regla para definir tía
% X es tía de Y si X es mujer y es tía de Y
tia(X,Y) :- mujer(X), tios(X,Y).

% 14. Regla para definir primos
% X e Y son primos si sus padres son hermanos
primos(X, Y) :- padre(P1, X), padre(P2, Y), hermanos(P1, P2), X \= Y
              ; madre(M1, X), madre(M2, Y), hermanos(M1, M2), X \= Y
              ; padre(P1, X), madre(M2, Y), hermanos(P1, M2)
              ; madre(M1, X), padre(P2, Y), hermanos(M1, P2).

% 15. Regla para definir primo varón
% X es primo de Y si X es hombre y es primo de Y
primo(X, Y) :- hombre(X), primos(X,Y).

% 16. Regla para definir prima
% X es prima de Y si X es mujer y es prima de Y
prima(X, Y) :- mujer(X), primos(X,Y).

% 17. Regla para definir primos por parte de padre
% X e Y son primos por parte de padre si sus padres son hermanos
primo_por_padre(X, Y) :- padre(PadreX, X), padre(PadreY, Y), hermanos(PadreX, PadreY), X \= Y.

% 18. Regla para definir primos por parte de madre
% X e Y son primos por parte de madre si sus madres son hermanas
primo_por_madre(X, Y) :- madre(MadreX, X), madre(MadreY, Y), hermanos(MadreX, MadreY), X \= Y.

% 19. Regla para determinar si una pareja puede procrear biológicamente
% Una pareja puede procrear si son de sexos opuestos y no son parientes
% cercanos
% uso del operador OR, porque aunque no sean pareja pueden procrear

puede_procrear(X, Y) :-
    pareja(X, Y);
    ((hombre(X), mujer(Y)); (mujer(X), hombre(Y))),
      not(parientes_cercanos(X, Y)).

% 20. Regla para evitar la procreación entre parientes cercanos
% Dos personas son parientes cercanos si son hermanos, padre/madre e hijo/a, abuelos y nietos, o tíos y sobrinos
parientes_cercanos(X, Y) :-
    hermanos(X, Y);
    padre(X, Y);
    madre(X, Y);
    abuelos(X, Y);
    tios(X, Y).
