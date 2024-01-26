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
output reg o_pulse
);

reg count;

initial
	begin
		count = 1'd0;
	end

always @ ( posedge i_clk)
	begin
		if( i_push_button )
			begin
				if( count == 1'd0 )
					begin
						count <= 1'd1;
						o_pulse <= 1'd1;
					end
				else
					begin
						o_pulse <= 1'd0;
					end
			end
		else
			begin
				count = 1'd0;
				o_pulse = 1'd0;
			end
	end
	
endmodule 