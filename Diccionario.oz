ByFreqdeclare
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
      [] tree(K V L R) andthen Key == K then
	 {Browse V}
	 tree(Key V+1 L R)
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
   proc {Print Dict}
      case Dict of nil then skip
      [] tree(K V L R) then
	 {Print L}
	 {Browse (K#V)}
	 {Print R}
      end
   end
   fun {PutByValue Key Value D}
      case D of nil then tree(Key Value nil nil)
      [] tree(K V L R) andthen Value < V then
	 tree(K V {PutByValue Key Value L} R)
      [] tree(K V L R) andthen Value > V then
	 tree(K V L {PutByValue Key Value R})
      [] tree(K V L R) andthen Value == V then
	 if Key < K then
	    tree(K V {PutByValue Key Value L} R)
	 else
	    tree(K V L {PutByValue Key Value R})
	 end
      end
   end
   fun {Domain Dict}
      local
	 fun {SortByFreq Orig New}
	    case Orig of nil then New
	    [] tree(Key Value Left Right) then
	       {SortByFreq Right {SortByFreq Left {PutByValue Key Value New}}}
	    end
	 end      
      in
	 {SortByFreq Dict {NewDict}}
      end
   end
   
   
in
   Diccionario = dict(new:NewDict put:Put insertList:InsertList get:Get domain:Domain print:Print)
end

F = {Diccionario.insertList [h a s f a d r a s r] {Diccionario.new}}
%{Browse F}
%{Diccionario.domain F}

A = {Diccionario.insertList [j f r g b f h j i] F}
%{Browse A}
{Diccionario.print A}
{Browse '--------------'}
B = {Diccionario.domain A}
{Diccionario.print B}
