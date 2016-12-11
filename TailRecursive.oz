declare
proc {Length Xs A Res}
    case Xs of nil then Res = A
    else case Xs of _|Xr then
        local Y in
           Y = A + 1
           {Length Xr Y Res}
           end
        end
    end
end
                   
% ejecución
{Browse {Length [1 2 3 4 5 6 7 8] 0}}
% salida → 8