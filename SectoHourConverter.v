/*!>
* second to hour module
*
*+ Input +* 
* clk 		- clock source input positive edge
* 6bit sec 	- input from second output module to synchronize second count
* 6bit min 	- input from minute output module to synchronize second count
* 3bit hold - for suspend minute suspend
*
*
*+ Output +* 
*  5bit hour - hour value
*
*
<!*/
module SectoHourConverter(
input clk, 
input [5:0]sec,
input [5:0]min,
input [2:0]hold,
output reg [4:0]Hour
);

reg [5:0] secCount;
reg [5:0] minCount;


initial
	begin
		secCount <= 6'd0;
		minCount <= 6'd0;
	end


always @(posedge clk)
	begin
		if ( hold )
			begin
				case ( hold )
					3'b100,
					3'b101,
					3'b110,
					3'b111:
						begin
							minCount = min + 5'd1; //add 1 as count will slow 1 count, add 1 for synch
							secCount = sec;
							Hour = Hour + 5'd1;
							if( Hour >= 6'd24 )
								begin
									Hour <= 5'd0;
								end
						end
//					3'b001,						
//					3'b010,
//					3'b011,
					default:
						begin
							minCount = min + 5'd1; //add 1 as count will slow 1 count, add 1 for synch
							secCount <= sec;
						end
				endcase 			
			end
		else
			begin
				secCount = secCount + 6'd1;
				if( secCount >= 6'd60 )
					begin
						secCount <= 6'd0;
						minCount = minCount + 6'd1;
						if( minCount >= 6'd60 )
							begin
								minCount <= 6'd0;
								Hour = Hour + 5'd1;
								if( Hour >= 6'd24 )
									begin
										Hour <= 5'd0;
									end
							end
					end
			end
	end
	

endmodule 