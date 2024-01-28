module calculate (
input [1:0] push_button,
input [39:0]i_s1,
input [39:0]i_s2,
input i_sign,
input i_en,
input [1:0]i_arith_func,
output reg [39:0]o_result,
output reg o_err,
output reg o_sign
);


wire [39:0]adder_res, minus_res, multiple_res, divide_res;
wire wire_add_err, wire_minus_err, wire_multiple_err, wire_divide_err;
wire wire_sign;

initial
	begin
		o_err = 1'd0;
		o_sign = 1'd0;
	end

adder	add_st( .i_s1(i_s1), .i_s2(i_s2), .o_res(adder_res), .o_err(wire_add_err));
minus	minus_st( .i_s1(i_s1), .i_s2(i_s2), .i_sign(i_sign), .o_res(minus_res), .sign(wire_sign), .o_err(wire_minus_err));
multiple	multiple_st( .i_s1(i_s1), .i_s2(i_s2), .o_res(multiple_res), .o_err(wire_multiple_err));
divider divide_st( .i_s1(i_s1), .i_s2(i_s2), .o_res(divide_res), .o_err(wire_divide_err));


parameter ADD 			= 2'b00;
parameter MINUS 		= 2'b01;
parameter MULTIPLE	= 2'b10;
parameter DIVIDE 		= 2'b11;


always @( * )
	begin
		if ( i_en )
			begin
				case ( i_arith_func )
					ADD:
						begin
							o_result = adder_res;
							o_err = wire_add_err;
							o_sign = 1'd0;
						end
					MINUS:
						begin
							o_result = minus_res;
							o_err = wire_minus_err;
							o_sign = wire_sign;
						end
					MULTIPLE:
						begin
							o_result = multiple_res;
							o_err = wire_multiple_err;
							o_sign = 1'd0;
						end
					DIVIDE:
						begin
							o_result = divide_res;
							o_err = wire_divide_err;
							o_sign = 1'd0;
						end
					endcase
				end
			else
				begin
					o_err = 1'd0;
					o_sign = 1'd0;
				end
	end
endmodule	