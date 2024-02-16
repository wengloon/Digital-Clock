module Basic_calculator(
input clk,
input [9:0] slide_switch,
input [1:0] push_button,
output [9:0] led,
output [6:0] digitSeg,
output [6:0] tenSeg,
output [6:0] hundredSeg,
output [6:0] thousandSeg,
output [6:0] tenThousandSeg,
output [6:0] hundredThousandeg
);


reg [2:0] state;
reg error, sign;
wire [1:0] arithmatic; 
wire [1:0] displ_sel;
wire enable;

assign enable = displ_sel[0] & displ_sel[1];

wire [39:0] S1, S2, result, value_display;
wire [39:0] wire_S0, wire_S1, wire_S2, wire_res; 
wire wire_err, wire_sign;
wire [1:0]	push_button_pulse;
wire [5:0] digit_pos, ten_pos, hundred_pos, thousand_pos, ten_thousand_pos, hundred_thousand_pos;

	push_button_pulse_gen enter_pulse( .i_clk(clk), .i_push_button(push_button[1]) , .o_pulse(push_button_pulse[1]) );
	push_button_pulse_gen reset_pulse( .i_clk(clk), .i_push_button(push_button[0]) , .o_pulse(push_button_pulse[0]) );

	input_value_setup in_value(.i_slide_switch(slide_switch[9:4]), .i_enable(!slide_switch[2]), .i_push_button(push_button_pulse[1]), .o_value(wire_S0));	

	state_controller calculator_state( 
							.enter_button(push_button_pulse[1]), 
							.reset_button(push_button_pulse[0]), 
							.enable_switch(slide_switch[2]), 
							.in_val(wire_S0), 
							.in_prev_res( wire_res ),
							.led(led[3:0]), 
							.display_sel(displ_sel), 
							.S1(S1), 
							.S2(S2));

	DataMux4in1out disp( .s1( wire_S0 ), 
								.s2( wire_S0 ), 
								.s3( 40'hE3 ), 
								.s4( wire_res ), 
								.sel(displ_sel), 
								.out(value_display));
	
	calculate calculate_process(	.i_s1(S1), 
											.i_s2(S2), 
											.i_sign(wire_sign),
											.i_en(enable), 
											.i_arith_func(slide_switch[1:0]), 
											.o_result(wire_res), 
											.o_err(wire_err), 
											.o_sign(wire_sign));

					
	digit_separator separator( .i_value(value_display), 
										.i_sign(wire_sign), 
										.i_err(error),
										.digit_pos(digit_pos), 
										.ten_pos(ten_pos), 
										.hundred_pos(hundred_pos), 
										.thousand_pos(thousand_pos), 
										.ten_thousand_pos(ten_thousand_pos), 
										.hundred_thousand_pos(hundred_thousand_pos));

										

	Decoder7Segment_expand digit( .In(digit_pos), .segmentDisplay(digitSeg));								//1
	Decoder7Segment_expand ten( .In(ten_pos), .segmentDisplay(tenSeg));									//10
	Decoder7Segment_expand hundred( .In(hundred_pos), .segmentDisplay(hundredSeg));							//100
	Decoder7Segment_expand thousand( .In(thousand_pos), .segmentDisplay(thousandSeg));						//1000
	Decoder7Segment_expand ten_thousand( .In(ten_thousand_pos), .segmentDisplay(tenThousandSeg));				//10000
	Decoder7Segment_expand hundred_thousand( .In(hundred_thousand_pos), .segmentDisplay(hundredThousandeg));		//100000
	
endmodule