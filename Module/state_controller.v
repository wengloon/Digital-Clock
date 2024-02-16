module state_controller(
input enter_button,
input reset_button,
input i_sign,
input enable_switch,
input [39:0] in_val,
input [39:0] in_prev_res,
output reg[3:0] led,
output reg[39:0] S1,
output reg[39:0] S2,
output reg o_sign,
output reg [1:0]display_sel
);


parameter INPUT_1_STATE 			= 3'b001;
parameter INPUT_2_STATE 			= 3'b010;
parameter INPUT_RESULT_STATE		= 3'b111;
parameter INPUT_CONT_STATE 		= 3'b100;

reg [2:0] state;

initial
	begin
		state = INPUT_1_STATE;
		display_sel = 2'b00;
		S1 = 40'd0;
		S2 = 40'd0;
		led = 4'b1111;
	end
	
always @ ( posedge reset_button or posedge enter_button )
	begin
		if ( reset_button )
			begin
				state = INPUT_1_STATE;
				display_sel = 2'b00;
				S1 = 40'd0;
				S2 = 40'd0;
				led = 4'b0000;
			end
		else
			begin
				if( enable_switch && enter_button )
					begin					
						case ( state )
							INPUT_1_STATE:
								begin
									state = INPUT_2_STATE;
									S1 = in_val;
									display_sel = 2'b01;
									led = 4'b0001;
									o_sign = 1'd0;
								end
							INPUT_2_STATE:
								begin
									state = INPUT_RESULT_STATE;
									S2 = in_val;
									display_sel = 2'b11;
									led = 4'b0010;
									o_sign = 1'd0;
								end			
							INPUT_RESULT_STATE:
								begin
									state = INPUT_CONT_STATE;
									display_sel = 2'b01;
									led = 4'b0100;
									o_sign = i_sign;
								end
							INPUT_CONT_STATE:
								begin
									state = INPUT_RESULT_STATE;
									S1 <= in_prev_res;
									S2 = in_val;
									display_sel = 2'b11;
									led = 4'b1000;
									o_sign = i_sign;
								end
						endcase
					end
			end
	end




endmodule 


