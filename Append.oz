declare
fun {Append List ToAdd}   
   case List of nil then ToAdd
   [] H|T then
      H|{Append T ToAdd}
   end   
end


{Show {Append [1 2 3] [4 5 6]}}

{Show {Append [1] [6]}}

{Show {Append nil [2]}}

{Show {Append nil nil}}

{Show '-----------------'}
   