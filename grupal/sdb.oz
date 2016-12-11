declare
local Dictionary in
   local
      fun {DictionaryOps D}
	 local
	    fun {InsertList List}
	       case List of H|T then
		  {Put H}
		  {InsertList T}
	       end
	    end

               % Inserta ordenado por clave
	    fun {Put Key}
	       case D of nil then {DictionaryOps tree(Key 1 nil nil)}
	       [] tree(K V L R) andthen Key == K then
		  {DictionaryOps tree(Key V+1 L R)}
	       [] tree(K V L R) andthen Key < K then
		  {DictionaryOps tree(K V {Put Key L} R)}
	       [] tree(K V L R) andthen Key > K then
		  {DictionaryOps tree(K V L {Put Key R})}
	       end
	    end
	    
	    
	    fun {Get Key}
	       case D of nil then 0
	       [] tree(K V _ _) andthen Key == K then
		  V
	       [] tree(K _ L _) andthen Key < K then
		  local Left = {DictionaryOps L} in
		     {Left.get Key}
		  end
	       [] tree(K _ _ R) andthen Key > K then
		  local Right = {DictionaryOps R} in
		     {Right.get Key}
		  end
	       end
	    end
	    
	    proc {Print}
	       case D of nil then skip
	       [] tree(K V L R) then
		  local
		     Left = {DictionaryOps L}
		     Right = {DictionaryOps R}
		  in
		     {Left.print}
		     {Browse (K#V)}
		     {Right.print}
		  end
	       end
	    end
	 
               % Inserta por Valor y en caso de iguales, por clave
	    fun {PutByValue Key Value D}
	       case D of nil then {DictionaryOps tree(Key Value nil nil)}
	       [] tree(K V L R) andthen Value < V then
		  {DictionaryOps tree(K V {PutByValue Key Value L} R)}
	       [] tree(K V L R) andthen Value > V then
		  {DictionaryOps tree(K V L {PutByValue Key Value R})}
	       [] tree(K V L R) andthen Value == V then
		  if Key < K then
		     {DictionaryOps tree(K V {PutByValue Key Value L} R)}
		  else
		     {DictionaryOps tree(K V L {PutByValue Key Value R})}
		  end
	       end
	    end
	    
	    fun {Domain}
	       local
		  fun {SortByFreq Orig New}
		     case Orig of nil then New
		     [] tree(Key Value Left Right) then
			{SortByFreq Right {SortByFreq Left {PutByValue Key Value New}}}
		     end
		  end
	       in
		  {SortByFreq D {NewDict}}
	       end
	    end
	       
	 in
	    dict(new:NewDict put:Put insertList:InsertList get:Get domain:Domain print:Print)
	 end
      end
      
   in
      fun {NewDict} {DictionaryOps nil} end
   end
end