declare
fun {Map List Fun}
    case List of nil then nil
    [] H|T then
        {Fun H}|{Map T Fun}
    end
end

fun {MasUno N}
    N + 1
end
                   
% ejecución
{Browse {Map [1 1 3 5 7] MasUno}}
% salida [2 2 4 6 8]