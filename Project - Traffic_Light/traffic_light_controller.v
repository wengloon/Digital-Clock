module traffic_light_controller(
input i_clk,
input i_en,
output reg [2:0]o_led,
output [6:0]o_value
);

reg [1:0] state = RED_LIGHT_STATE;
wire[6:0] wire_red, wire_yellow, wire_green; 
wire tick, state_switch;
wire red_reset, yellow_reset, green_reset;
reg red_enable_control, yellow_enable_control, green_enable_control;

parameter RED_LIGHT_STATE 			= 2'b01;
parameter YELLOW_LIGHT_STATE 		= 2'b10;
parameter GREEN_LIGHT_STATE		= 2'b11;

/*
parameter RED_LIGHT_ENABLE 		= RED_LIGHT_STATE - 1;
parameter YELLOW_LIGHT_ENABLE 	= YELLOW_LIGHT_STATE - 1;
parameter GREEN_LIGHT_ENABLE		= GREEN_LIGHT_STATE - 1;
*/

parameter RED_LIGHT_ENABLE_IDX 		= 0;
parameter YELLOW_LIGHT_ENABLE_IDX 	= 1;
parameter GREEN_LIGHT_ENABLE_IDX		= 2;



assign state_switch = | o_value;
assign red_reset = ~red_enable_control | ~i_en;
assign yellow_reset = ~ yellow_enable_control | ~i_en;
assign green_reset = ~green_enable_control | ~i_en;


DataMux4in1out disp(
.s1(0), 
.s2(wire_red), 
.s3(wire_yellow), 
.s4(wire_green), 
.sel(state),
.out(o_value)
);

clock_500MHz_to_1tick_generator clock_tick(	.i_clk(i_clk),
															.i_reset(!i_en),
															.o_tick(tick)
);
														
countdown_counter red_light(
.i_clk(i_clk),
.i_enable(tick),
.i_reset(red_reset),
.i_limit(7'd10),
.o_value(wire_red),
);

countdown_counter yellow_light(
.i_clk(i_clk),
.i_enable(tick),
.i_reset(yellow_reset),
.i_limit(3'd3),
.o_value(wire_yellow),
);

countdown_counter green_light(
.i_clk(i_clk),
.i_enable(tick),
.i_reset(green_reset),
.i_limit(7'd7),
.o_value(wire_green),
);


initial
	begin
		state <= RED_LIGHT_STATE;
		o_led <= 3'd001;
		red_enable_control <= 1'd1;
	end

always @ ( posedge i_clk )
	begin
		if( !i_en )
			begin
				state <= RED_LIGHT_STATE;
				o_led <= 3'd001;
				red_enable_control <= 1'd1;
				yellow_enable_control <= 1'd0;
				green_enable_control <= 1'd0;
			end
		else
			begin
				case ( state )
					RED_LIGHT_STATE:
						begin
							if( !state_switch )
								begin
									state <= GREEN_LIGHT_STATE;
									o_led <= 3'd100;
									red_enable_control <= 1'd0;
									yellow_enable_control <= 1'd0;
									green_enable_control <= 1'd1;
								end
						end
					YELLOW_LIGHT_STATE:
						begin
							if( !state_switch )
								begin
									state <= RED_LIGHT_STATE;
									o_led <= 3'd001;
									red_enable_control <= 1'd1;
									yellow_enable_control <= 1'd0;
									green_enable_control <= 1'd0;
								end
						end
					GREEN_LIGHT_STATE:
						begin
							if( !state_switch )
								begin
									state <= YELLOW_LIGHT_STATE;
									o_led <= 3'd010;
									red_enable_control <= 1'd0;
									yellow_enable_control <= 1'd1;
									green_enable_control <= 1'd0;
								end
						end
				endcase
			end
	end
endmodule 