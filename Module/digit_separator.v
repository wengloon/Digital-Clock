module digit_separator(
input [39:0] i_value,
input i_sign,
input i_err,
output reg [5:0] digit_pos, 
output reg [5:0] ten_pos, 
output reg [5:0] hundred_pos,
output reg [5:0] thousand_pos,
output reg [5:0] ten_thousand_pos,
output reg [5:0] hundred_thousand_pos
);


always @ ( * )
	begin
		if( i_err )
			begin
				digit_pos	 					= 6'h1B; //R
				ten_pos		 					= 6'h18; //O
				hundred_pos 					= 6'h1B; //R
				thousand_pos					= 6'h1B; //R
				ten_thousand_pos				= 6'hE; //E
				hundred_thousand_pos 		= 6'h25; //	CLOSE
			end
		else
			begin
				if( i_sign )
					begin
						hundred_thousand_pos = 6'h24;
					end
				else
					begin
						hundred_thousand_pos = ( i_value % 40'd1000000 )/ 40'd100000;
					end
				digit_pos = i_value % 40'd10;
				ten_pos = ( i_value % 40'd100 )/ 40'd10;
				hundred_pos = ( i_value % 40'd1000 )/100;
				thousand_pos = ( i_value % 40'd10000 )/ 40'd1000;
				ten_thousand_pos = (i_value % 40'd100000)/ 40'd10000;
				
			end
	end
endmodule 
