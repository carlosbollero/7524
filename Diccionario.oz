declare
local
   fun {NewDict} nil end
   fun {InsertList List Dict}
      case List of nil then Dict
      [] H|T then
	 {InsertList T {Put H Dict}}
      end
   end
   fun {Put Key Dict}
      case Dict of nil then tree(Key 1 nil nil)
      [] tree(K _ L R) andthen Key == K then
	 local Value = {Get Dict Key} in
	    {Browse Value}
	    tree(Key Value+1 L R)
	 end
      [] tree(K V L R) andthen Key < K then
	 tree(K V {Put Key L} R)
      [] tree(K V L R) andthen Key > K then
	 tree(K V L {Put Key R})
      end
   end
   fun {Get Dict Key}
      case Dict of nil then 0
      [] tree(K V _ _) andthen Key == K then
	 V
      [] tree(K _ L _) andthen Key < K then
	 {Get L Key}
      [] tree(K _ _ R) andthen Key > K then
	 {Get R Key}
      end
   end
   proc {Domain Dict}
      case Dict of nil then skip
      [] tree(K V L R) then
	 {Domain L}
	 {Browse (K#V)}
	 {Domain R}
      end
   end
   
   
in
   Diccionario = dict(new:NewDict put:Put insertList:InsertList get:Get domain:Domain)
end

F = {Diccionario.insertList [h a s f a d r a s r] {Diccionario.new}}
{Browse F}
{Diccionario.domain F}

A = {Diccionario.insertList [j f r g b f h j i] F}
{Browse A}
{Diccionario.domain A}