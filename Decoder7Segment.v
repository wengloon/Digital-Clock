/*!>
*  7 segment decoder module
*
*+ Input +* 
* 4bit In	- Data input 0-9
*
*
*+ Output +* 
*  7bit segmentDisplay - data output to 7segment display
*
*
<!*/
module Decoder7Segment( 
	input [3:0] In,
	output reg [6:0] segmentDisplay
	);
	

always @(In)
	begin
		case (In)
			4'h0: 
				begin
				segmentDisplay <= 7'b1000000;	
				end
			4'h1: 
				begin
				segmentDisplay <= 7'b1111001;
				end
			4'h2: 
				begin
				segmentDisplay <= 7'b0100100; 
				end
			4'h3: 
				begin
				segmentDisplay <= 7'b0110000; 
				end
			4'h4: 
				begin
				segmentDisplay <= 7'b0011001;
				end
			4'h5: 
				begin
				segmentDisplay <= 7'b0010010;
				end
			4'h6: 
				begin
				segmentDisplay <= 7'b0000010;
				end
			4'h7: 
				begin
				segmentDisplay <= 7'b1111000;
				end
			4'h8: 
				begin
				segmentDisplay <= 7'b0000000;
				end
			4'h9: 
				begin
				segmentDisplay <= 7'b0010000;
				end
			default:
				begin
				segmentDisplay <= 7'b1111111;
				end
		endcase
	end
endmodule 