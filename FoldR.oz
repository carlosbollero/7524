declare
fun {FoldR List F U}
    case List of nil then U
    [] H|T then
        {F H {FoldR T F U}}
    end
end

declare
fun {Max X Y}
    if X < Y then Y
    else X end
end
                   
% ejecución
{Browse {FoldR [1 4 1 15 8 14 6] Max 0}}
% salida -> 15