/*!>
* 2 in 1 out multiplexer module
*
*+ Input +* 
* s1 	- Source 1
* s2	- Source 2
* sel - Selector
*
*
*+ Output +* 
*  out - source output
*
*
<!*/
module Mux2in1out(
input s1, 
input s2, 
input sel,
output reg out
);

always @(s1, s2, sel)
begin
	if(~sel)
		begin 
			out=s1;
		end
	else
		begin
			out=s2;
		end
end

endmodule 
		