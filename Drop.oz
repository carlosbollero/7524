declare 
fun {Drop List Upto}
   if Upto > {Length List} then nil
   else      
      case List of nil then nil
      else
	 if Upto > 0 then
	    {Drop List.2 Upto-1}
	 else
	    List
	 end
      end
   end
end

{Browse {Drop [0 4 3 1 6 4] 0}}

{Browse {Drop [0 4 3 1 6 4] 1}}

{Browse {Drop [0 4 3 1 6 4] 3}}

{Browse {Drop [0 4 3 1 6 4] 5}}

{Browse {Drop [0 4 3 1 6 4] 7}}