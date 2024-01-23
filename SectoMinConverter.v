/*!>
* second to minute module
*
*+ Input +* 
* clk 		- clock source input positive edge
* 3bit hold - for suspend minute suspend
* 6bit sec 	- input from second module to synchronize second count
*
*
*+ Output +* 
*  6bit min - minute value
*
*
!>*/

module SectoMinConverter(
input clk, 
input [5:0]sec,
input [2:0]hold, 
output reg [5:0]min
);

reg [5:0] secCount;

initial
	begin
		secCount <= 6'd0;
	end


always @(posedge clk)
	begin
		if( hold )
			begin
				case ( hold )
					3'b001,
					3'b101:
						begin 
							secCount = sec; 
						end
					3'b010:
						begin
							secCount = sec;
							min = min + 6'd1;
							if( min >= 6'd60 )
								begin
									min <= 6'd0;
								end
						end
					3'b011,
					3'b110,
					3'b111:
						begin
							secCount = sec;
							min <= min + 6'd1;
							if( min >= 6'd60 )
								begin
									min <= 6'd0;
								end
						end
//					3'b100
					default: 
						begin
							secCount = sec;
						end
					endcase 
				end
		else
			begin
				secCount = secCount + 6'd1;
				if( secCount >= 6'd60 )
					begin
						secCount <= 6'd0;
						min = min + 6'd1;
						if( min >= 6'd60 )
							begin
								min <= 6'd0;
							end
					end
			end
	end
endmodule 