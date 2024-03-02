/*!>
* 2 in 1 out Data multiplexer module
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
module DataMux2in1out(
input [39:0]s1, 
input [39:0]s2, 
input sel,
output reg [39:0] out
);

always @(s1, s2, sel)
begin
	case ( sel )
	1'b0:
		begin 
			out=s1;
		end
	1'b1:
		begin
			out=s2;
		end
	endcase
end

endmodule 
		