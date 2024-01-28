module minus(
input i_sign,
input [39:0] i_s1,
input [39:0] i_s2,
output reg [39:0] o_res,
output reg sign,
output reg o_err
);

always @ (*)
	begin
		if( !i_sign )
			begin
				if( i_s2 > i_s1 ) 
					begin
						sign <= 1'd1;
						o_res <= i_s2 - i_s1;
					end
				else
					begin
						sign <= 1'd0;
						o_res <= i_s1 - i_s2;
						
					end
			end
		else
			begin
				sign <= 1'd1;
				o_res <= i_s2 + i_s1;
			end

			
			

		if( sign ) 
			begin
				if( o_res > 40'd99999 )
					begin
						o_err = 1'd1;
					end
			end
		else
			begin
				if( o_res > 40'd999999 )
					begin
						o_err = 1'd1;
					end
			end
	end
endmodule
