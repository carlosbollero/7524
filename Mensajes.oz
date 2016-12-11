declare NewAgent P in
fun {NewAgent}
    local S in
        thread
            for Msg in S do
                {Browse Msg}
            end
        end
        {NewPort S}
    end
end


P = {NewAgent}
{Send P 'hola'}
{Send P reg(a)}
{Send P 8}
{Send P [1 2]}