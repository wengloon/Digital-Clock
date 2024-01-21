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
	reg [5:0] Sec, Min;
	reg [31:0]segclk;
	
	initial
		begin
			Sec <= 6'd0;
			Min <= 6'd0;
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
					segclk <= 32'd0; //counter goes up by 1
					Sec = Sec + 1'b1;
					if ( Sec >= 6'd60 )
						begin
							Sec <= 6'd0;
							Min = Min + 1'b1;
							if ( Min >= 6'd60 )
							begin
								Min <= 6'd0;
							end
						end
				end
			end

	always @(Sec)//1250
		begin
			InSecHi=Sec/10;		//50/10=5 , ""5""
			InSecLo=Sec%10;		//5/10 = ""0""
			InMinHi=Min/10;
			InMinLo=Min%10;
		end

		Decoder7Segment secLo( .In(InSecLo), .segmentDisplay(SecLoSeg));
		Decoder7Segment secHi( .In(InSecHi), .segmentDisplay(SecHiSeg));
		Decoder7Segment minLo( .In(InMinLo), .segmentDisplay(MinLoSeg));
		Decoder7Segment minHi( .In(InMinHi), .segmentDisplay(MinHiSeg));

endmodule
