/*!>
* 1 tick pulse per second generator with input 500MHz module
*
*+ Input +* 
* i_clk 	- input clock 500MHz
* i_reset	- reset switch
*
*+ Output +* 
*  o_tick - tick
*
*
<!*/
module clock_500MHz_to_1tick_generator(
input i_clk,
input i_reset,
output o_tick
);


wire reset;
wire or_count;
reg [31:0] count;

assign or_count = |count;

assign o_tick = !(or_count);
assign reset = i_reset | !(or_count);


always @ ( posedge i_clk )
	begin
		if( reset )
			begin
				count <= 32'd50000000;
			end
		else
			begin
				count <= count - 1'd1;
			end
	end

endmodule
