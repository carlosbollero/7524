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
	 fun {NewDict} {NewCell {W nil}} end
	 proc {InsertList List Dict}
	    case List of nil then Dict
	    [] H|T then
	       {InsertList T {Put H Dict}}
	    end
	 end
	 
           % Inserta ordenado por clave
	 proc {Put Key Dict}
	    case {U @Dict} of nil then Dict := {W tree(Key 1 nil nil)}
	    [] tree(K V L R) andthen Key == K then
	       Dict := {W tree(Key V+1 L R)}
	    [] tree(K V L R) andthen Key < K then
	       Dict := {W tree(K V {Put Key {W L}} R)}
	    [] tree(K V L R) andthen Key > K then
	       Dict := {W tree(K V L {Put Key {W R}})}
	    end
	 end
	 
	 proc {Get Dict Key ?Value}
	    case {U @Dict} of nil then Value = 0
	    [] tree(K V _ _) andthen Key == K then
	       Value = V
	    [] tree(K _ L _) andthen Key < K then
	       {Get {NewCell {W L}} Key Value}
	    [] tree(K _ _ R) andthen Key > K then
	       {Get {NewCell {W R}} Key Value}
	    end
	 end
	 
	 proc {Print Dict}
	    case {U @Dict} of nil then skip
	    [] tree(K V L R) then
	       {Print {NewCell {W L}}}
	       {Browse (K#V)}
	       {Print {NewCell {W R}}}
	    end
	 end
	 
           % Inserta por Valor y en caso de iguales, por clave
	 proc {PutByValue Key Value D}
	    case {U @D} of nil then D := {W tree(Key Value nil nil)}
	    [] tree(K V L R) andthen Value < V then
	       D := {W tree(K V {PutByValue Key Value {W L}} R)}
	    [] tree(K V L R) andthen Value > V then
	       D := {W tree(K V L {PutByValue Key Value {W R}})}
	    [] tree(K V L R) andthen Value == V then
	       if Key < K then
		  D := {W tree(K V {PutByValue Key Value {W L}} R)}
	       else
		  D := {W tree(K V L {PutByValue Key Value {W R}})}
	       end
	    end
	 end
	 
	 proc {Domain Dict ?NewD}
	    local
	       fun {SortByFreq Orig New}
		  case {U @Orig} of nil then New
		  [] tree(Key Value Left Right) then
		     {SortByFreq Right {SortByFreq Left {PutByValue Key Value New}}}
		  end
	       end      
	    in
	       NewD = {NewDict}
	       {SortByFreq Dict NewD}
	    end
	 end
	 
      in
	 Dictionary = dict(new:NewDict put:Put insertList:InsertList get:Get domain:Domain print:Print)
      end
   end
end