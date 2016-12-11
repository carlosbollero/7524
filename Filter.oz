declare
fun {Filter List Fun}
    case List of nil then nil
    [] H|T then
        if {Fun H} then H|{Filter T Fun}
        else {Filter T Fun}
        end
    end
end
                   
% ejecución
{Browse {Filter [1 e b 5 7 c 5 8] IsNumber}}
% salida [1 5 7 5 8]