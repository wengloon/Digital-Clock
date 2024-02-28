module input_value_setup(
input [5:0] i_slide_switch,
input i_push_button,
input i_enable,
input i_clk,
output reg [39:0] o_value
);



always @ ( posedge i_clk )
	begin
		if( i_push_button )
			begin 
				if(i_enable)
					begin
						case( i_slide_switch )
							6'b100000:
								begin
									o_value <=  o_value + ( 40'd1 * 100000 );
								end
							6'b010000:
								begin
									o_value <=  o_value + ( 40'd1 * 10000 );
								end
							6'b001000:
								begin
									o_value <=  o_value + ( 40'd1 * 1000 );
								end
							6'b000100:
								begin
									o_value <=  o_value + ( 40'd1 * 100 );
								end
							6'b000010:
								begin
									o_value <=  o_value + ( 40'd1 * 10 );
								end
							6'b000001:
								begin
									o_value <=  o_value + ( 40'd1 * 1 );
								end
							6'b000000:
								begin
									o_value <= 40'd0;
								end
						endcase 
					end
				else
					begin
						o_value <= 40'd0;
					end
			end
	end
endmodule 