declare
fun {FoldL List F U}
    case List of nil then U
    [] H|T then
        {F {FoldL T F U} H}
    end
end

declare
fun {Sumar X Y}
    X + Y
end
                   
% ejecución
{Browse {FoldL [1 7 48 3] Sumar 0}}
% salida → 59