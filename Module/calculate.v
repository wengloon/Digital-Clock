module calculate (
input [1:0] push_button,
input [39:0]i_s1,
input [39:0]i_s2,
input i_sign,
input i_en,
input i_reset,
input [1:0]i_arith_func,
output reg led,
output reg [39:0]o_result,
output reg o_err,
output reg o_sign
);

parameter ADD 			= 2'b00;
parameter MINUS 		= 2'b01;
parameter MULTIPLE		= 2'b10;
parameter DIVIDE 		= 2'b11;


initial
	begin
		o_err = 1'd0;
		o_sign = 1'd0;
	end


always @( posedge i_en  or posedge i_reset)
	begin
		if( i_reset )
			begin
				led = 1'd1;
				o_err = 1'd0;
				o_sign = 1'd0;
			end
		else
			begin
				if( i_en && ~o_err)
					begin
						led = 1'd0;
						case ( i_arith_func )
							ADD:
								begin
									o_result = i_s1 + i_s2;
									o_sign = 1'd0;
								end
							MINUS:
								begin
									if( i_sign )
										begin
											o_result = i_s2 + i_s1;
											o_sign = 1'd1;
										end
									else
										begin
											if( i_s2 > i_s1 ) 
												begin
													o_result = i_s2 - i_s1;
													o_sign = 1'd1;
												end
											else
												begin
													o_result = i_s1 - i_s2;
													o_sign = 1'd0;
												end
										end
								end
							MULTIPLE:
								begin
									o_sign = 1'd0;
									o_result = i_s1 * i_s2;
								end
							DIVIDE:
								begin
									o_sign = 1'd0;
									o_result = i_s1/i_s2;
								end
						endcase
					end

			if( o_sign ) 
				begin
					if( o_result > 40'd99999 )
						begin
							o_err = 1'd1;
						end
					else
						begin
							o_err = 1'd0;
						end
				end
			else
				begin
					if( o_result > 40'd999999 )
						begin
							o_err = 1'd1;
						end
					else
						begin
							o_err = 1'd0;
						end
				end
			end
	end

	
endmodule	