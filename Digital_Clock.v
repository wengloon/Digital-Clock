module Digital_Clock(
	input clk,
	input [2:0]slideSwitch,		// slideSwitch[0] - hold switch / slideSwitch[1] - minute adjust switch / slideSwitch[2] - hour adjust switch
	input pushBtn,
	output [6:0] SecLoSeg,
	output [6:0] SecHiSeg, 
	output [6:0] MinLoSeg,
	output [6:0] MinHiSeg, 
	output [6:0] HrLoSeg, 
	output [6:0] HrHiSeg
	);
	//time display
	//h2 h1 : m2 m1 : s2 s1
	
	
	reg [3:0] InSecLo, InSecHi, InMinLo, InMinHi, InHrLo, InHrHi;
	reg [5:0] Sec, Min;
	reg [4:0] Hour;
	reg [31:0]segclk;
	
	initial
		begin
			Sec <= 6'd0;
			Min <= 6'd0;
			Hour <= 5'd0;
			InSecLo <= 4'd0;
			InSecHi <= 4'd0;
			InMinLo <= 4'd0;
			InMinHi <= 4'd0;
			InHrLo <= 4'd0;
			InHrHi <= 4'd0;
			segclk <= 32'd0;
		end
	
	always @( posedge clk )
		begin
			if( pushBtn == 1'b0 )
				begin
					case ( slideSwitch )
						3'b1:
							begin
								Sec <= 6'd0;
								Min <= 6'd0;
								Hour <= 5'd0;
							end
						3'b111:
							begin
								Min <= 6'd0;
								Hour <= 5'd0;
							end
						3'b011:
							begin
								Min <= 6'd0;
							end
						3'b101:
							begin
								Hour <= 6'd0;
							end
						default: /* did nothing */;
					endcase
					segclk <= 32'd0;
				end
			else if( slideSwitch[0] )
				begin
					/* Clock stop - hold function*/
				end
			else
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
											Hour = Hour + 1'b1;
											if ( Hour >= 5'd24 )
												begin
													Hour <= 6'd0;
												end
										end
								end
						end
				end
		end

	//Convert data to two 7segment display
	always @(Sec)
		begin
			InSecHi=Sec/10;		//50/10=5 , ""5""
			InSecLo=Sec%10;		//5/10 = ""0""
			InMinHi=Min/10;
			InMinLo=Min%10;
			InHrHi=Hour/10;
			InHrLo=Hour%10;
		end

		Decoder7Segment secLo( .In(InSecLo), .segmentDisplay(SecLoSeg));	//s1
		Decoder7Segment secHi( .In(InSecHi), .segmentDisplay(SecHiSeg));	//s2
		Decoder7Segment minLo( .In(InMinLo), .segmentDisplay(MinLoSeg));	//m1
		Decoder7Segment minHi( .In(InMinHi), .segmentDisplay(MinHiSeg));	//m2
		Decoder7Segment hrHi( .In(InHrHi), .segmentDisplay(HrHiSeg));		//h1
		Decoder7Segment hrLo( .In(InHrLo), .segmentDisplay(HrLoSeg));		//h2


endmodule
