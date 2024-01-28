module demux(
input [39:0] i_value,
input sel,
output reg [39:0] o_res1,
output reg [39:0] o_res2
);

always @ ( sel )
	begin
		case (sel)
			1'd0: o_res1 <= i_value;
			1'd1: o_res2 <= i_value;
		endcase
	end
endmodule	