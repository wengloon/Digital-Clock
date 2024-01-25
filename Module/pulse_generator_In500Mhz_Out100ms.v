/*!>
* 100ms pulse generator with input 500MHz module
*
*+ Input +* 
* i_clk 	- input clock 500MHz
* i_en	- enable switch
*
*+ Output +* 
*  o_pulse - pulse
*
*
<!*/
module pulse_generator_In500Mhz_Out100ms(
input i_clk,
input i_en,
output reg o_pulse
);

reg [31:0] count;

always @( posedge i_clk )
	begin
		if( i_en )
				begin
					count = count + 26'd1;
					if ( count >= 32'd50000000)
						begin
							o_pulse <= 1'd1;
							count <= 32'd0;
						end
					else if( count >= 32'd50000 )
						begin
							o_pulse <= 1'd0;
						end
				end
		else
			begin
				o_pulse <= 1'd0;
				count <= 32'd0;
			end
	end
		
endmodule 