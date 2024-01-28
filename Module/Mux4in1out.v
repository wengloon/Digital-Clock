/*!>
* 4 in 1 out multiplexer module
*
*+ Input +* 
* s1 	- Source 1
* s2	- Source 2
* s3 	- Source 3
* s4	- Source 4
* 2BIT sel - Selector
*
*
*+ Output +* 
*  out - source output
*
*
<!*/
module Mux4in1out(
input s1, 
input s2, 
input s3, 
input s4, 
input [1:0]sel,
output reg out
);

always @(*)
begin
	case ( sel )
		2'b00:
			begin 
				out=s1;
			end
		2'b01:
			begin
				out=s2;
			end
		2'b10:
			begin
				out=s3;
			end	
		2'b11:
			begin
				out=s4;
			end
	endcase
end

endmodule 