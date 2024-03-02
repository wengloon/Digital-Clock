module Traffic_light(
	input clk,
	input  slideSwitch,
	output [6:0] ASecLoSeg,
	output [6:0] ASecHiSeg,
	output [6:0] BSecLoSeg,
	output [6:0] BSecHiSeg,
	output [9:0] led
);

parameter TRAFFIC_LIGHT_A	= 2'd0;
parameter TRAFFIC_LIGHT_B	= 2'd1;

parameter RED_LIGHT_STATE 		= 2'b01;
parameter YELLOW_LIGHT_STATE 	= 2'b10;
parameter GREEN_LIGHT_STATE		= 2'b11;


reg [1:0] traffic_light_state[1:0];

wire [6:0] traffic_light_A_second;
wire [3:0] traffic_light_A_InSecLo, traffic_light_A_InSecHi;
wire state_A_switch;
wire [6:0] traffic_light_A_second_display;


wire [6:0] traffic_light_B_second;
wire [3:0] traffic_light_B_InSecLo, traffic_light_B_InSecHi;
wire state_B_switch;
wire [6:0] traffic_light_B_second_display;

assign state_A_switch = | traffic_light_A_second;
assign state_B_switch = | traffic_light_B_second;


	traffic_light_controller traffic_light_A (	.i_clk(clk),
																.i_en(slideSwitch),
																.i_state(traffic_light_state[TRAFFIC_LIGHT_A]),
																.o_led(led[2:0]),
																.o_value(traffic_light_A_second)
);

	traffic_light_controller traffic_light_B (	.i_clk(clk),
																.i_en(slideSwitch),
																.i_state(traffic_light_state[TRAFFIC_LIGHT_B]),
																.o_led(led[9:7]),
																.o_value(traffic_light_B_second)
);


	DataMux2in1out traffic_light_A_display(	.s1(0), 
															.s2(traffic_light_A_second), 
															.sel(slideSwitch),
															.out(traffic_light_A_second_display)
);
	
	DataMux2in1out traffic_light_B_display(	.s1(0), 
															.s2(traffic_light_B_second), 
															.sel(slideSwitch),
															.out(traffic_light_B_second_display)
);


always @ ( posedge clk )
	begin
		if( !slideSwitch )
			begin
				traffic_light_state[TRAFFIC_LIGHT_A] <= RED_LIGHT_STATE;
			end
		else
			begin
				case ( traffic_light_state[TRAFFIC_LIGHT_A] )
					RED_LIGHT_STATE:
						begin
							if( !state_A_switch )
								begin
									traffic_light_state[TRAFFIC_LIGHT_A] <= GREEN_LIGHT_STATE;
								end
						end
					YELLOW_LIGHT_STATE:
						begin
							if( !state_A_switch )
								begin
									traffic_light_state[TRAFFIC_LIGHT_A] <= RED_LIGHT_STATE;
								end
						end
					GREEN_LIGHT_STATE:
						begin
							if( !state_A_switch )
								begin
									traffic_light_state[TRAFFIC_LIGHT_A] <= YELLOW_LIGHT_STATE;
								end
						end
				endcase
			end
	end

always @ ( posedge clk )
	begin
		if( !slideSwitch )
			begin
				traffic_light_state[TRAFFIC_LIGHT_B] <= GREEN_LIGHT_STATE;
			end
		else
			begin
				case ( traffic_light_state[TRAFFIC_LIGHT_B] )
					RED_LIGHT_STATE:
						begin
							if( !state_B_switch )
								begin
									traffic_light_state[TRAFFIC_LIGHT_B] <= GREEN_LIGHT_STATE;
								end
						end
					YELLOW_LIGHT_STATE:
						begin
							if( !state_B_switch )
								begin
									traffic_light_state[TRAFFIC_LIGHT_B] <= RED_LIGHT_STATE;
								end
						end
					GREEN_LIGHT_STATE:
						begin
							if( !state_B_switch )
								begin
									traffic_light_state[TRAFFIC_LIGHT_B] <= YELLOW_LIGHT_STATE;
								end
						end
				endcase
			end
	end

	Divider_st ASec_div10 ( .InData(traffic_light_A_second_display), .InDivisor(4'd10), .OutData(traffic_light_A_InSecHi));
	Modulus_st ASec_mol10 ( .InData(traffic_light_A_second_display), .InmodulusVal(4'd10), .OutData(traffic_light_A_InSecLo));
	Decoder7Segment AsecLo( .In(traffic_light_A_InSecLo), .segmentDisplay(ASecLoSeg));	//traffic_light_A s1
	Decoder7Segment AsecHi( .In(traffic_light_A_InSecHi), .segmentDisplay(ASecHiSeg));	//traffic_light_A s2
	
	
	Divider_st BSec_div10 ( .InData(traffic_light_B_second_display), .InDivisor(4'd10), .OutData(traffic_light_B_InSecHi));
	Modulus_st BSec_mol10 ( .InData(traffic_light_B_second_display), .InmodulusVal(4'd10), .OutData(traffic_light_B_InSecLo));
	Decoder7Segment BsecLo( .In(traffic_light_B_InSecLo), .segmentDisplay(BSecLoSeg));	//traffic_light_B s1
	Decoder7Segment BsecHi( .In(traffic_light_B_InSecHi), .segmentDisplay(BSecHiSeg));	//traffic_light_B s2

endmodule
