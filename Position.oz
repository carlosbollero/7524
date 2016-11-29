declare
fun {Position List Item}
   case List of nil then nil
   [] H|T then
      if H == Item then
	 1
      else
	 1+{Position List.2 Item}
      end
   end
end

{Browse {Position [1 2 3] 2}}

{Browse {Position [1 2 5 6 7 98 0 6 4 3 6 7] 3}}

{Browse {Position [1 2 5 6 7 98 0 6 4 3 6 7] 6}}

{Browse {Position nil 4}}