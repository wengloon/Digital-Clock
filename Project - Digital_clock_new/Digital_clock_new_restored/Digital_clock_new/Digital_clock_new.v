module Digital_clock_new(
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

wire pulse;
wire rst = slideSwitch[0] | slideSwitch[1] | slideSwitch[2];
wire [3:0] InSecLo, InSecHi, InMinLo, InMinHi, InHrLo, InHrHi;
wire [5:0] second, minute, hour;
wire pulse_minute_up, pulse_hour_up;
wire manual_second_up, manual_minute_up, manual_hour_up;
wire second_up, minute_up, hour_up;
wire sec_rst, min_rst;
	
	assign manual_second_up = slideSwitch[0] & (!pushBtn) & rst;
	assign manual_minute_up = slideSwitch[1] & (!pushBtn) & rst;
	assign manual_hour_up = slideSwitch[2] & (!pushBtn) & rst;

	pulse_generator_In500Mhz_Out100ms pulse_source( .i_clk(clk), .i_en(!rst), .o_pulse(pulse) );
	
	Mux2in1out second_up_src(  .s1(pulse), .s2(manual_second_up),.out(second_up), .sel(rst) );
	Mux2in1out minute_up_src(  .s1(pulse_minute_up), .s2(manual_minute_up),.out(minute_up), .sel(rst) );
	Mux2in1out hour_up_src( .s1(pulse_hour_up), .s2(manual_hour_up), .out(hour_up), .sel(rst) );
	
	counter second_module(.i_clk(second_up), .i_limit(6'd60), .i_rst(), .o_en(pulse_minute_up), .o_counter(second));
	counter minute_module(.i_clk(minute_up), .i_limit(6'd60), .i_rst(), .o_en(pulse_hour_up), .o_counter(minute));
	counter hour_module(.i_clk(hour_up), .i_limit(6'd24), .i_rst(), .o_en(), .o_counter(hour));

	Divider_st Sec_div10 ( .InData(second), .InDivisor(4'd10), .OutData(InSecHi));
	Modulus_st Sec_mol10 ( .InData(second), .InmodulusVal(4'd10), .OutData(InSecLo));
	Divider_st min_div10 ( .InData(minute), .InDivisor(4'd10), .OutData(InMinHi));
	Modulus_st min_mol10 ( .InData(minute), .InmodulusVal(4'd10), .OutData(InMinLo));
	Divider_st Hour_div10 ( .InData(hour), .InDivisor(4'd10), .OutData(InHrHi));
	Modulus_st Hour_mol10 ( .InData(hour), .InmodulusVal(4'd10), .OutData(InHrLo));

	Decoder7Segment secLo( .In(InSecLo), .segmentDisplay(SecLoSeg));	//s1
	Decoder7Segment secHi( .In(InSecHi), .segmentDisplay(SecHiSeg));	//s2
	Decoder7Segment minLo( .In(InMinLo), .segmentDisplay(MinLoSeg));	//m1
	Decoder7Segment minHi( .In(InMinHi), .segmentDisplay(MinHiSeg));	//m2
	Decoder7Segment hrHi( .In(InHrHi), .segmentDisplay(HrHiSeg));		//h1
	Decoder7Segment hrLo( .In(InHrLo), .segmentDisplay(HrLoSeg));		//h2
	
	
	
	
endmodule 