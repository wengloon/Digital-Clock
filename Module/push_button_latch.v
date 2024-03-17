/*!>
* push button latch module 
* push button press will output signal to set until reset occur to reset it
*
*+ Input +* 
* i_clk 	- input clock 500MHz
* i_push_button	- push button
*
*+ Output +* 
*  o_pulse - pulse
*
*
<!*/
module push_button_latch(
input i_clk,
input i_push_button,
input i_reset,
output reg o_signal
);

always @ ( posedge i_clk )
	begin
		if( ~i_push_button )
			begin
				o_signal <= 1'd1;
			end
		else if( i_reset )
			begin
				o_signal <= 1'd0;
			end
	end

endmodule 