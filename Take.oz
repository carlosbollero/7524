declare 
fun {Take List Upto}
   case List of nil then nil
   [] H|T then
      local Result in
	 if Upto > 0 then
	    Result = List.1|{Take List.2 Upto-1}
	 else
	    nil
	 end
      end
   end
end

{Browse {Take [0 4 3 1 6 4] 1}}

{Browse {Take [0 4 3 1 6 4] 3}}

{Browse {Take [0 4 3 1 6 4] 5}}

{Browse {Take [0 4 3 1 6 4] 7}}

{Browse {Take nil 4}}