/*!>
* count down counter, count down by 1 every 1 pulse receive module
*
*+ Input +* 
* i_clk 	- input clock
* i_en	- enable switch
* i_reset	- reset switch
* i_limit	- value to count down
*
*+ Output +* 
*  o_value - count down value
*
*
<!*/
module countdown_counter(
input i_clk,
input i_enable,
input i_reset,
input [6:0] i_limit,
output [6:0] o_value
);

wire reset;
wire value;
reg [6:0]count;

assign value = | count;
assign o_value = count;
assign reset = ( ~value ) | i_reset;


always @ ( posedge i_clk )
	begin
		if ( reset )
			begin
				count <= i_limit;
			end
		else
			begin
				if( i_enable )
					begin
						count <= count - 1'd1;
					end
			end
	end
endmodule 