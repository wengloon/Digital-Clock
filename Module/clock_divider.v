/*!>
*  divide source clock based on prescaler setting module
*
*+ Input +* 
* i_enable - enable function
* i_clk	- Clock source
* [3:0] i_prescaler - prescaler
*
*+ Output +* 
*  o_clk - output clock
*
*
<!*/
module clock_divider( 
input i_enable,
input i_clk,
input [3:0] i_prescaler,
output reg o_clk
);


reg [3:0] count = 4'd0;


always @ ( posedge i_clk )

	begin
	if( !i_enable )
		begin
			count <= 4'd0;
			o_clk <= 1'd0;
		end
	else
		begin
			count = count + 4'd1;
			if( count >= i_prescaler-1 )
				begin
					count <= 4'd0;
					o_clk <= ~o_clk;
				end
		end
	end

endmodule
