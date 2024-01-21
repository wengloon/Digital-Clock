module Digital_Clock(
	input clk,
	output [6:0] SecLoSeg,
	output [6:0] SecHiSeg, 
	output [6:0] MinLoSeg, 
	output [6:0] MinHiSeg 
	);
	//time display
	//h2 h1 : m2 m1 : s2 s1
	
	
	reg [3:0] InSecLo, InSecHi, InMinLo, InMinHi;
	reg [31:0]segclk;
	
	initial
		begin
			InSecLo <= 4'd0;
			InSecHi <= 4'd0;
			InMinLo <= 4'd0;
			InMinHi <= 4'd0;
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
									InMinLo = InMinLo + 1'b1;
									if ( InMinLo >= 4'd10 )
										begin
											InMinLo <= 4'd0;
											InMinHi = InMinHi + 1'b1;
											if ( InMinHi >= 4'd6 )
												begin
													InMinHi<= 4'd0;
												end
										end
								end
						end
				end
			end

		Decoder7Segment secLo( .In(InSecLo), .segmentDisplay(SecLoSeg));
		Decoder7Segment secHi( .In(InSecHi), .segmentDisplay(SecHiSeg));
		Decoder7Segment minLo( .In(InMinLo), .segmentDisplay(MinLoSeg));
		Decoder7Segment minHi( .In(InMinHi), .segmentDisplay(MinHiSeg));

endmodule
