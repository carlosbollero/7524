declare
local NewWrapper in
   proc {NewWrapper Wrap UnWrap}
      local Key = {NewName} in
	 fun {Wrap X}
	    fun {$ K}
	       if K == Key then X end
	    end
	 end
	 
	 fun {UnWrap W}
	    {W Key}
	 end
      end
   end
end

declare
local Dictionary in
   local W U in
      local
	 {NewWrapper W U}
	 fun {NewDict} {W nil} end
	 fun {InsertList List Dict}
	    case List of nil then Dict
	    [] H|T then
	       {InsertList T {Put H Dict}}
	    end
	 end
	 
           % Inserta ordenado por clave
	 fun {Put Key Dict}
	    case {U Dict} of nil then {W tree(Key 1 nil nil)}
	    [] tree(K V L R) andthen Key == K then
	       {W tree(Key V+1 L R)}
	    [] tree(K V L R) andthen Key < K then
	       {W tree(K V {Put Key {W L}} R)}
	    [] tree(K V L R) andthen Key > K then
	       {W tree(K V L {Put Key {W R}})}
	    end
	 end
	 
	 fun {Get Dict Key}
	    case {U Dict} of nil then 0
	    [] tree(K V _ _) andthen Key == K then
	       V
	    [] tree(K _ L _) andthen Key < K then
	       {Get {W L} Key}
	    [] tree(K _ _ R) andthen Key > K then
	       {Get {W R} Key}
	    end
	 end
	 
	 proc {Print Dict}
	    case {U Dict} of nil then skip
	    [] tree(K V L R) then
	       {Print {W L}}
	       {Browse (K#V)}
	       {Print {W R}}
	    end
	 end
	 
           % Inserta por Valor y en caso de iguales, por clave
	 fun {PutByValue Key Value D}
	    case {U D} of nil then {W tree(Key Value nil nil)}
	    [] tree(K V L R) andthen Value < V then
	       {W tree(K V {PutByValue Key Value {W L}} R)}
	    [] tree(K V L R) andthen Value > V then
	       {W tree(K V L {PutByValue Key Value {W R}})}
	    [] tree(K V L R) andthen Value == V then
	       if Key < K then
		  {W tree(K V {PutByValue Key Value {W L}} R)}
	       else
		  {W tree(K V L {PutByValue Key Value {W R}})}
	       end
	    end
	 end
	 
	 fun {Domain Dict}
	    local
	       fun {SortByFreq Orig New}
		  case {U Orig} of nil then New
		  [] tree(Key Value Left Right) then
		     {SortByFreq Right {SortByFreq Left {PutByValue Key Value New}}}
		  end
	       end      
	    in
	       {SortByFreq Dict {NewDict}}
	    end
	 end
	 
      in
	 Dictionary = dict(new:NewDict put:Put insertList:InsertList get:Get domain:Domain print:Print)
      end
   end
end