declare
local Dictionary in
   local
      fun {NewDict} {NewCell nil} end
      proc {InsertList Dict List}
	 case List of H|T then
	    {InsertList {Put Dict H} T}
	 end
      end
      
       % Inserta ordenado por clave
      proc {Put Dict Key}
	 case @Dict of nil then Dict := tree(Key 1 nil nil)
	 [] tree(K V L R) andthen Key == K then
	    Dict := tree(Key V+1 L R)
	 [] tree(K V L R) andthen Key < K then
	    local Left = {NewCell L} in
	       {Put Left Key}
	       Dict := tree(K V @Left R)
	    end
	 [] tree(K V L R) andthen Key > K then
	    local Right = {NewCell R} in
	       {Put Right Key}
	       Dict := tree(K V L @Right)
	    end
	 end
      end

      proc {Get Dict Key ?Value}
	 case @Dict of nil then Value = 0
	 [] tree(K V _ _) andthen Key == K then
	    Value = V
	 [] tree(K _ L _) andthen Key < K then
	    {Get {NewCell L} Key Value}
	 [] tree(K _ _ R) andthen Key > K then
	    {Get {NewCell R} Key Value}
	 end
      end
      
      proc {Print Dict}
	 case @Dict of nil then skip
	 [] tree(K V L R) then
	    {Print {NewCell L}}
	    {Browse (K#V)}
	    {Print {NewCell R}}
	 end
      end

       % Inserta por Valor y en caso de iguales, por clave
      proc {PutByValue Key Value Dict}
	 case @Dict of nil then tree(Key Value nil nil)
	 [] tree(K V L R) andthen Value < V then
	    local Left = {NewCell L} in
	       {PutByValue Key Value Left}
	       Dict := tree(K V @Left R)
	    end
	 [] tree(K V L R) andthen Value > V then
	    local Right = {NewCell R} in
	       {PutByValue Key Value Right}
	       Dict := tree(K V L @Right)
	    end
	 [] tree(K V L R) andthen Value == V then
	    if Key < K then
	       local Left = {NewCell L} in
		  {PutByValue Key Value Left}
		  Dict := tree(K V @Left R)
	       end
	    else
	       local Right = {NewCell R} in
		  {PutByValue Key Value Right}
		  Dict := tree(K V L @Right)
	       end
	    end
	 end
      end

      proc {Domain Dict ?New}
	 local
	    proc {SortByFreq Orig New}
	       case @Orig of tree(Key Value Left Right) then
		  {SortByFreq Right {SortByFreq Left {PutByValue Key Value New}}}
	       end
	    end      
	 in
	    New = {NewDict}
	    {SortByFreq Dict New}
	 end
      end
              
   in
      Dictionary = dict(new:NewDict put:Put insertList:InsertList get:Get domain:Domain print:Print)
   end
end