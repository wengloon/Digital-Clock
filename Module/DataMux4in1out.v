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
module DataMux4in1out(
input [39:0]s1, 
input [39:0]s2, 
input [39:0]s3, 
input [39:0]s4,
input [1:0] sel,
output reg [39:0] out
);

always @(s1, s2, s3, s4, sel)
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
		