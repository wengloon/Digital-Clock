/*!>
*  convert 50Mhz to 1Hz source generator module
*
*+ Input +* 
* clk	- Clock source
* rst - reset function
*
*+ Output +* 
*  sec - 1Hz output 
*
*
<!*/
module counter1sec50MHz(
input clk,
input rst,
output reg sec
);

reg [31:0] clkcount;

always @ ( posedge clk )
	begin
		if ( rst )
			begin
				clkcount = 32'd0;
				sec <= 1'd1;
			end
		else
			begin
			clkcount = clkcount + 32'd1;
			if( clkcount >= 32'd25000000 )
				begin
					sec <= ~sec;
					clkcount <= 32'd0;
				end
			end
	end 
endmodule 