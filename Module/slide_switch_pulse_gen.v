/*!>
* 1 pulse generator with 1 enable signal module
*
*+ Input +* 
* i_clk 	- input clock 500MHz
* i_en	- enable signal
*
*+ Output +* 
*  o_pulse - pulse
*
*
<!*/
module slide_switch_pulse_gen(
input i_clk,
input i_en,
output reg o_pulse
);

reg [4:0] count;

initial
	begin
		count = 5'd0;
	end

always @ ( posedge i_clk)
	begin
		if( i_en )
			begin
				if ( o_pulse == 1'd0 )
					begin
						o_pulse <= 1'd1;
					end
				else
					if(count == 5'd50000)
						begin
							o_pulse <= 1'd0;
							count = 5'd0;
						end
					else
						begin
							count = count + 5'd1;
						end
			end
		else
			begin
				count = 1'd0;
				o_pulse = 1'd0;
			end
	end
	
endmodule 