module Digital_Clock(
	input clk,
	output [6:0] SecLoSeg,
	output [6:0] SecHiSeg
	);
	//time display
	//h2 h1 : m2 m1 : s2 s1
	
	
	reg [3:0] InSecLo, InSecHi;
	reg [31:0]segclk;
	
	initial
		begin
			InSecLo <= 4'd0;
			InSecHi <= 4'd0;
		end
	
	always @( posedge clk )
		begin
			segclk <= segclk+1'b1; //counter goes up by 1
			if ( segclk >= 32'd50000000 )
				begin
					InSecLo = InSecLo + 1'b1;
					segclk <= 32'd0; //counter goes up by 1
					if ( InSecLo >= 4'd10 )
						begin
							InSecLo <= 4'd0;
							InSecHi = InSecHi + 1'b1;
							if ( InSecHi >= 4'd6 )
								begin
									InSecHi <= 4'd0;
								end
						end
				end
			end

		Decoder7Segment secLo( .In(InSecLo), .segmentDisplay(SecLoSeg));
		Decoder7Segment secHi( .In(InSecHi), .segmentDisplay(SecHiSeg));

endmodule
