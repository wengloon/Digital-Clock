module state_controller(
input [1:0]push_button,
input enable_switch,
input [39:0] in_val,
input [39:0] in_prev_res,
output reg[9:0] led,
output reg[39:0] S1,
output reg[39:0] S2,
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
		led = 10'b1111111111;
	end
	
always @ ( posedge push_button[0] or posedge push_button[1] )
	begin
		if ( push_button[0] )
			begin
				state = INPUT_1_STATE;
				display_sel = 2'b00;
				S1 = 40'd0;
				S2 = 40'd0;
				led = 10'b0000000000;
			end
		else
			begin
				if( enable_switch && ( !push_button[1] ) )
					begin					
						case ( state )
							INPUT_1_STATE:
								begin
									state = INPUT_2_STATE;
									S1 = in_val;
									display_sel = 2'b01;
									led = 10'b0000000001;
								end
							INPUT_2_STATE:
								begin
									state = INPUT_RESULT_STATE;
									S2 = in_val;
									display_sel = 2'b11;
									led = 10'b0000000010;
								end			
							INPUT_RESULT_STATE:
								begin
									state = INPUT_CONT_STATE;
									display_sel = 2'b01;
									led = 10'b0000000100;
								end
							INPUT_CONT_STATE:
								begin
									state = INPUT_2_STATE;
									S1 <= in_prev_res;
									S2 = in_val;
									display_sel = 2'b11;
									led = 10'b0000001000;
								end
						endcase
					end
			end
	end




endmodule 


