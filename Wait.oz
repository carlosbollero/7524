declare
proc {WaitSome Xs}
    Bound in
    {ForAll Xs proc {$ X}
            thread
                {Wait X}
                Bound = true
                {Browse X}
            end
        end
    }
    {Wait Bound}
end


% ejecución
local A in
    {WaitSome [1 2 A 4 5]}
    A = 3
end