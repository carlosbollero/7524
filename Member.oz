declare
fun {Member List Item}
   case List of nil then false
   [] H|T then
      if H == Item then true
      else {Member List.2 Item}
      end
   end
end


{Browse {Member [1 2 3 4 5 6] 3}}
{Browse {Member [1 2 3 4 5 6] 5}}
{Browse {Member [1 2 3 4 5 6] 9}}
{Browse {Member [1 2 3 4 5 6] a}}
{Browse {Member [1 2 3 4 5 6] nil}}
{Browse {Member nil 3}}
	 