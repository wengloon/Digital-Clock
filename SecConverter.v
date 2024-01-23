/*!>
* second output module
*
*+ Input +* 
* clk 		- clock source input positive edge
* 3bit hold - for suspend minute suspend
*
*
*+ Output +* 
*  6bit hour - second value
*
*
<!*/
module SecConverter (
input clk,
input [2:0]hold,
output reg [5:0]Sec
);

always @(posedge clk)
	begin
		if( hold )
			begin
				case ( hold )
				3'b001,
				3'b101,
				3'b111,
				3'b011:
					begin
						Sec <= 6'd0;
					end
//				3'b010,
//				3'b100,
//				3'b110,
				default:
					begin
//						Sec <= 6'd0;
					end
				endcase 
			end
		else
			begin
				Sec = Sec + 6'd1;
				if( Sec >= 6'd60 )
					begin
						Sec <= 6'd0;
					end
			end
	end
endmodule 