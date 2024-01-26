/*!>
* counter module
*
*+ Input +* 
* i_clk 	- clock source
* i_rst	- reset switch
* i_en - enable signal for counter increment
* 6bit i_limit - count to counter compare
*
*+ Output +* 
*  o_en - output pulse 
*	6bit o_counter count
*
<!*/
module counter(
input i_clk,
input i_rst,
input i_en,
input [5:0]i_limit,
output reg o_en,
output reg [5:0] o_counter
);

initial
	begin 
		o_en = 1'd0;
		o_counter = 6'd0;
	end
	
	
always @( posedge i_clk )
	begin
		if(i_rst)
			begin
				o_en <= 1'd0;
			end
		else
			if( i_en )
				begin
					o_counter = o_counter + 6'd1;
					if( o_counter >= i_limit )
						begin
							o_counter = 6'd0;
							o_en <= 1'd1;
						end
					else
						begin
							o_en <= 1'd0;
						end
				end
			else
				begin
					o_en <= 1'd0;
				end
	end
	
endmodule 
			
