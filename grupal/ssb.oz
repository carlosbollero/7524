fun {NewDict}


       C = {NewCell nil}


       proc {InsertList List}
          case List of H|T then
            {C.put H}
             {C.insertList T}
          end
       end


       % Inserta ordenado por clave
       proc {Put Key}
          case @C of nil then C := tree(Key 1 nil nil)
          [] tree(K V L R) andthen Key == K then
            C := tree(Key V+1 L R)
          [] tree(K V L R) andthen Key < K then
            local Left = {NewDict} in
                Left.C := L
                {Left.put Key}
            end
            C := tree(K V L R)
          [] tree(K V L R) andthen Key > K then
            local Right = {NewDict} in
                Right.C := R
                {Right.put Key}
            end
            C := tree(K V L R)
          end
       end


       proc {Get Key ?Value}
          case @C of nil then Value = 0
          [] tree(K V _ _) andthen Key == K then
             Value = V
          [] tree(K _ L _) andthen Key < K then
            local Left = {NewRight} in
                Left.C := L
                {Left.get Key Value}
            end
          [] tree(K _ _ R) andthen Key > K then
            local Right = {NewRight} in
                Right.C := R
                {Right.get Key Value}
            end
          end
       end


       proc {Print}
          case @C of nil then skip
          [] tree(K V L R) then
            local Left = {NewDict} in
                Left.C := L
                {Left.print}
            end
             {Browse (K#V)}
            local Right = {NewDict} in
                Right.C := R
                {Right.print}
            end
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


       proc {Domain ?New}
          local
             proc {SortByFreq Orig New}
                case @Orig of tree(Key Value Left Right) then
                   {SortByFreq Right {SortByFreq Left {PutByValue Key Value New}}}
                end
             end      
          in
             New = {NewDict}
             {SortByFreq C New.C}
          end
       end


   in
        dict(new:NewDict put:Put insertList:InsertList get:Get domain:Domain print:Print)
   end
end