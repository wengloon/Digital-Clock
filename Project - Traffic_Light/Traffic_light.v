module Traffic_light(
	input clk,
	input  slideSwitch,
	output [6:0] ASecLoSeg,
	output [6:0] ASecHiSeg,
	output [2:0] led
);


wire [6:0] traffic_light_A_second;
wire [3:0] traffic_light_A_InSecLo, traffic_light_A_InSecHi;


	traffic_light_controller traffic_light_A (	.i_clk(clk),
																.i_en(slideSwitch),
																.o_led(led),
																.o_value(traffic_light_A_second)
);


	Divider_st Sec_div10 ( .InData(traffic_light_A_second), .InDivisor(4'd10), .OutData(traffic_light_A_InSecHi));
	Modulus_st Sec_mol10 ( .InData(traffic_light_A_second), .InmodulusVal(4'd10), .OutData(traffic_light_A_InSecLo));

	Decoder7Segment AsecLo( .In(traffic_light_A_InSecLo), .segmentDisplay(ASecLoSeg));	//traffic_light_A s1
	Decoder7Segment AsecHi( .In(traffic_light_A_InSecHi), .segmentDisplay(ASecHiSeg));	//traffic_light_A s2
endmodule
