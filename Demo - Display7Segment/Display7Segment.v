/* Control 7 segment display using push button
 * every press will increase one, 7segment will display from 0-9 
*/

module Display7Segment(
	input button,
	output reg [6:0]segmentDisplay
);

reg[3:0] Inhex;

initial 
begin
		segmentDisplay <= 7'b1111111; //segment will initialize all off 
		Inhex = 4'h0;
end

always @(negedge button)
begin
	Inhex = Inhex + 1;
	if ( Inhex > 9 )
	begin
		Inhex = 0;
	end

case (Inhex)
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
