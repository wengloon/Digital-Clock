/*!>
*  7 segment decoder ( expand )module
*
*+ Input +* 
* 8bit In	- Data input 0-9 + A-Z, unsupport display will be "-"
*
*
*+ Output +* 
*  7bit segmentDisplay - data output to 7segment display
*
*
<!*/
module Decoder7Segment_expand( 
	input [5:0] In,
	output reg [6:0] segmentDisplay
	);
	

always @(In)
	begin
		case (In)
			6'h0: 
				begin
				segmentDisplay <= 7'b1000000;	
				end
			6'h1: 
				begin
				segmentDisplay <= 7'b1111001;
				end
			6'h2: 
				begin
				segmentDisplay <= 7'b0100100; 
				end
			6'h3: 
				begin
				segmentDisplay <= 7'b0110000; 
				end
			6'h4: 
				begin
				segmentDisplay <= 7'b0011001;
				end
			6'h1C,//S
			6'h5: 
				begin
				segmentDisplay <= 7'b0010010;
				end
			6'h6: 
				begin
				segmentDisplay <= 7'b0000010;
				end
			6'h7: 
				begin
				segmentDisplay <= 7'b1111000;
				end
			6'h8: 
				begin
				segmentDisplay <= 7'b0000000;
				end
			6'h9: 
				begin
				segmentDisplay <= 7'b0010000;
				end
			6'hA: //A
				begin
				segmentDisplay <= 7'b0010000;	
				end
			6'hB: //B 
				begin
				segmentDisplay <= 7'b0000011;	
				end
			6'hC: //C
				begin
				segmentDisplay <= 7'b1000110;	
				end
			6'hD: //D
				begin
				segmentDisplay <= 7'b0010001;	
				end
			6'hE: //E
				begin
				segmentDisplay <= 7'b0000110;	
				end
			6'hF: //F
				begin
				segmentDisplay <= 7'b0001110;	
				end
			6'h10://G
				begin
				segmentDisplay <= 7'b1000010;	
				end
			6'h11://H
				begin
				segmentDisplay <= 7'b0001011;	
				end
			6'h12://I
				begin
				segmentDisplay <= 7'b1001111;	
				end
			6'h15://L
				begin
				segmentDisplay <= 7'b1000111;	
				end
			6'h17://N
				begin
				segmentDisplay <= 7'b0101011;	
				end
			6'h18://O
				begin
				segmentDisplay <= 7'b0100011;	
				end
			6'h19://P
				begin
				segmentDisplay <= 7'b0001100;	
				end
			6'h1A://Q
				begin
				segmentDisplay <= 7'b0011000;	
				end
			6'h1B://R
				begin
				segmentDisplay <= 7'b0101111;	
				end
			6'h1E://U
				begin
				segmentDisplay <= 7'b1000001;	
				end
			6'h22://Y
				begin
				segmentDisplay <= 7'b0011001;	
				end
			6'h13,//J
			6'h14,//K				
			6'h16,//M
			6'h1D,//T
			6'h1F,//V
			6'h20,//W
			6'h21,//X
			6'h23,//Z
			6'h24://universal
				begin
				segmentDisplay <= 7'b0111111;
				end
			default:
				begin
					segmentDisplay <= 7'b1111111;
				end
		endcase
	end
endmodule 