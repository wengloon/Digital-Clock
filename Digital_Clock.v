module Digital_Clock(
	input clk,
	input  [2:0] slideSwitch,		// slideSwitch[0] - hold switch / slideSwitch[1] - minute adjust switch / slideSwitch[2] - hour adjust switch
	input  pushBtn,
	output [6:0] SecLoSeg,
	output [6:0] SecHiSeg, 
	output [6:0] MinLoSeg,
	output [6:0] MinHiSeg, 
	output [6:0] HrLoSeg, 
	output [6:0] HrHiSeg
	);
	//time display
	//h2 h1 : m2 m1 : s2 s1
	
	
	wire [3:0] InSecLo, InSecHi, InMinLo, InMinHi, InHrLo, InHrHi;
	wire [5:0] WireSec, WireMin, WireHour;
	wire src, secsrc, minsrc, hoursrc, srcRst;
	
	assign srcRst = ( slideSwitch[0] || slideSwitch[1] || slideSwitch[2] );

	
	counter1sec50MHz Srcgen ( .clk(clk), .rst(srcRst), .sec(src));
	
	Mux2in1out(.s1(src), .s2(pushBtn), .sel(srcRst), .out(secsrc));
	Mux2in1out(.s1(src), .s2(pushBtn), .sel(srcRst), .out(minsrc));
	Mux2in1out(.s1(src), .s2(pushBtn), .sel(srcRst), .out(hoursrc));
	
	SecConverter Second_st( .clk(secsrc), .hold(slideSwitch), .Sec(WireSec));
	SectoMinConverter Minute_st( .clk(minsrc), .sec(WireSec), .hold(slideSwitch), .min(WireMin));
	SectoHourConverter Hour_st( .clk(hoursrc), .sec(WireSec), .min(WireMin), .hold(slideSwitch), .Hour(WireHour));
	

	
	Divider_st Sec_div10 ( .InData(WireSec), .InDivisor(4'd10), .OutData(InSecHi));
	Modulus_st Sec_mol10 ( .InData(WireSec), .InmodulusVal(4'd10), .OutData(InSecLo));
	Divider_st min_div10 ( .InData(WireMin), .InDivisor(4'd10), .OutData(InMinHi));
	Modulus_st min_mol10 ( .InData(WireMin), .InmodulusVal(4'd10), .OutData(InMinLo));
	Divider_st Hour_div10 ( .InData(WireHour), .InDivisor(4'd10), .OutData(InHrHi));
	Modulus_st Hour_mol10 ( .InData(WireHour), .InmodulusVal(4'd10), .OutData(InHrLo));
		
	


	Decoder7Segment secLo( .In(InSecLo), .segmentDisplay(SecLoSeg));	//s1
	Decoder7Segment secHi( .In(InSecHi), .segmentDisplay(SecHiSeg));	//s2
	Decoder7Segment minLo( .In(InMinLo), .segmentDisplay(MinLoSeg));	//m1
	Decoder7Segment minHi( .In(InMinHi), .segmentDisplay(MinHiSeg));	//m2
	Decoder7Segment hrHi( .In(InHrHi), .segmentDisplay(HrHiSeg));		//h1
	Decoder7Segment hrLo( .In(InHrLo), .segmentDisplay(HrLoSeg));		//h2

endmodule
