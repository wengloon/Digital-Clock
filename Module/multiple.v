module multiple(
input [39:0] i_s1,
input [39:0] i_s2,
output reg [39:0] o_res,
output reg o_err
);

always @ (*)
	begin
		o_res = i_s1 * i_s2;
		if( o_res > 20'd999999 )
			begin
				o_err = 1'd1;
			end
	end
endmodule
