% Carga de datos
distancias = load('lau15_dist.txt');
% Constantes
cantidad_poblacion = 1000;
iteraciones = 30;
porcentaje_mutacion = 0.1;
% Creaci�n de poblaci�n inicial
cromosomas = crearPoblacionInicial(cantidad_poblacion);
for i = 1:iteraciones
    fprintf(strcat("***** Iteraci�n ", num2str(i), " de ", num2str(iteraciones)," *****\n"));
    % Obtenci�n del fitness por cada cromosoma de la poblaci�n
    distancias_poblacion = obtenerDistanciasPoblacion(distancias,cromosomas);
    fitness = abs(distancias_poblacion - max(distancias_poblacion));
    % Ordenaci�n de los cromosomas seg�n su valor fitness
    matriz_auxiliar = [cromosomas, distancias_poblacion, fitness];
    matriz_auxiliar = sortrows(matriz_auxiliar, 17);
    cromosomas = matriz_auxiliar(:,1:15);
    distancias_poblacion = matriz_auxiliar(:,16);
    fitness = matriz_auxiliar(:,17);
    % Creaci�n de la bolsa de reproducci�n
    bolsa = [];
    for j = 1:cantidad_poblacion
        % Los mejores cromosomas (al �ltimo) se repiten m�s veces
        bolsa = [bolsa;repmat(cromosomas(j,:),[j,1])];
    end
    % Reproducci�n y creaci�n de los nuevos cromosomas
    cantidad_bolsa = sum(1:cantidad_poblacion);
    nuevos_cromosomas = [];
    for j = 1:cantidad_poblacion
        indices_pareja = randsample(cantidad_bolsa, 2);
        pareja = bolsa(indices_pareja,:);
        hijo = reproducir(pareja);
        % Mutaci�n
        if rand() <= porcentaje_mutacion
            posiciones = randsample(15,2);
            aux = hijo(posiciones(1));
            hijo(posiciones(1)) = hijo(posiciones(2));
            hijo(posiciones(2)) = aux;
        end
        % Incorporaci�n del nuevo hijo a la poblaci�n
        nuevos_cromosomas = [nuevos_cromosomas; hijo];
    end
    cromosomas = nuevos_cromosomas;
end
fprintf(strcat("La mejor ruta con una distancia de ", num2str(distancias_poblacion(cantidad_poblacion)), " es:\n"));
disp(cromosomas(cantidad_poblacion,:));