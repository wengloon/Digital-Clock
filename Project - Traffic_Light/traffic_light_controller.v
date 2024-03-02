module traffic_light_controller(
input i_clk,
input i_en,
input [1:0] i_state,
output reg [2:0]o_led,
output [6:0]o_value
);


wire[6:0] wire_red, wire_yellow, wire_green; 
wire tick, err_tick,state_switch;
wire red_reset, yellow_reset, green_reset;
reg red_enable_control, yellow_enable_control, green_enable_control;
reg error_state;

localparam ERROR_STATE				= 2'b00;

localparam RED_LIGHT_STATE 			= 2'b01;
localparam YELLOW_LIGHT_STATE 		= 2'b10;
localparam GREEN_LIGHT_STATE		= 2'b11;
localparam YELLOW_ON_STATE			= 1'b0;
localparam YELLOW_OFF_STATE			= 1'b1;

parameter RED_LIGHT_ENABLE_IDX 		= 0;
parameter YELLOW_LIGHT_ENABLE_IDX 	= 1;
parameter GREEN_LIGHT_ENABLE_IDX	= 2;



assign state_switch = | o_value;
assign red_reset = ~red_enable_control | ~i_en;
assign yellow_reset = ~ yellow_enable_control | ~i_en;
assign green_reset = ~green_enable_control | ~i_en;


DataMux4in1out disp(
.s1(0), 
.s2(wire_red), 
.s3(wire_yellow), 
.s4(wire_green), 
.sel(i_state),
.out(o_value)
);

clock_500MHz_to_1tick_generator clock_tick(	.i_clk(i_clk),
															.i_reset(!i_en),
															.o_tick(tick)
);

clock_500MHz_to_1tick_generator blink_tick(	.i_clk(i_clk),
															.i_reset(i_en),
															.o_tick(err_tick)
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


always @ ( posedge i_clk )
	begin
		if( !i_en )
			begin
				red_enable_control <= 1'd0;
				yellow_enable_control <= 1'd0;
				green_enable_control <= 1'd0;
				if( err_tick )
					begin
						case ( error_state )
							YELLOW_ON_STATE:
								begin
									o_led <= 3'd010;
									error_state <= YELLOW_OFF_STATE;
								end
							YELLOW_OFF_STATE:
								begin
									o_led <= 3'd000;
									error_state <= YELLOW_ON_STATE;
								end
						endcase
					end
			end
		else
			begin
				case ( i_state )
					RED_LIGHT_STATE:
						begin
							o_led <= 3'd001;
							red_enable_control <= 1'd1;
							yellow_enable_control <= 1'd0;
							green_enable_control <= 1'd0;
						end
					YELLOW_LIGHT_STATE:
						begin
							o_led <= 3'd010;
							red_enable_control <= 1'd0;
							yellow_enable_control <= 1'd1;
							green_enable_control <= 1'd0;
						end
					GREEN_LIGHT_STATE:
						begin
							o_led <= 3'd100;
							red_enable_control <= 1'd0;
							yellow_enable_control <= 1'd0;
							green_enable_control <= 1'd1;
						end
					default:
						begin
							o_led <= 3'd000;
							red_enable_control <= 1'd0;
							yellow_enable_control <= 1'd0;
							green_enable_control <= 1'd0;
						end
				endcase
			end
	end
endmodule 