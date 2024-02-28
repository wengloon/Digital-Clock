/*!>
* 1 pulse generator with 1 click module
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
module push_button_pulse_gen(
input i_clk,
input i_push_button,
output o_pulse
);

reg i_push_button_D;
reg i_push_button_DD;
assign o_pulse = i_push_button_D & !i_push_button_DD;

always @ ( posedge i_clk)
	begin
		i_push_button_D <= i_push_button;
		i_push_button_DD <= i_push_button_D;
	end
	
endmodule 