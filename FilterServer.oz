declare NewPrintAgent NewFilterAgent Filter SendIntSpam SendStringSpam in
fun {NewPrintAgent}
   local S in
      thread
	 for Msg in S do
	    {Browse Msg}
	 end
      end
      {NewPort S}
   end
end
fun {NewFilterAgent PrintAgent Fun}
   local S in
      thread
	 for Msg in S do
	    if {Fun Msg} then
	       {Send PrintAgent Msg}
	    else
	       {Send PrintAgent 'mensaje rechazado'}
	    end
	 end
      end
      {NewPort S}
   end
end
proc {SendIntSpam Port}
   proc {Repeat}
      {Delay {OS.rand} mod 1000}
      {Send Port {OS.rand}}
      {Repeat}
   end
in
   thread {Repeat}
   end
end
proc {SendStringSpam Port}
   proc {Repeat}
      {Delay {OS.rand} mod 1000}
      {Send Port "spam"}
      {Repeat}
   end
in
   thread {Repeat}
   end
end

Filter = {NewFilterAgent {NewPrintAgent} IsInt}
% El servidor de filtro recibe mensajes desde dos hilos
% con distintos tipos de mensaje
{SendIntSpam Filter}
{SendStringSpam Filter}
