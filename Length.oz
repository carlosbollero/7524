declare
fun {Length List}
   case List of nil then 0
   else
      1+{Length List.2}
   end
end

{Browse {Length [0 3 7 4 5 9 5 3 9]}}

{Browse {Length nil}}

{Browse {Length [37 4 cero 9 9]}}

{Browse {Length [0 3 3 9]}}