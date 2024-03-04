`timescale 1ns/100ps
/* ‘timescale unit/precision
# unit use for delays, precision is the length of each time step for the simulation
# example `timescale 1ns/100ps -> 0.1ns means you can use delay with 1 decimal place like 5.2unit
# `timescale 1us/10ns -> 0.01ns means you can use delay with 2 decimal place like 5.25unit
*/

module module_tb();

reg clk_5MHz;

//Clock pulse generate
always #100 clk_5MHz = ~clk_5MHz;

// instantious DUT
/* xxx Dut_xxx ( xxx ); */


initial begin
	repeat (10)
		begin
//	$display("i_push_button=%d", i_push_button);		//only display on console once
//	$monitor("i_push_button=%d", i_push_button);		//any variable changes will display
		end
	end



endmodule