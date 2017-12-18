function ordinal = codificarCromosoma(cromosoma)
    cantidad_ciudades = length(cromosoma);
    canonico = 1:cantidad_ciudades;
    ordinal = [];
    for i = 1:cantidad_ciudades
        k = find(canonico==cromosoma(i));
        ordinal = [ordinal,k];
        % Eliminaci�n del elemento en la posici�n k de canonico
        canonico(k) = [];
    end
end