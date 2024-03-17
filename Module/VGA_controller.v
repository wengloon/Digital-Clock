// image generator of a road and a sky 640x480 @ 60 fps

////////////////////////////////////////////////////////////////////////
module VGA_controller(
	input clk,           // 50 MHz
	input reg [3:0] i_red;
	input reg [3:0] i_green;
	input reg [3:0] i_blue;
	output o_hsync,      // horizontal sync
	output o_vsync,	     // vertical sync
	output [3:0] o_red,
	output [3:0] o_green ,
	output [3:0] o_blue
);

	reg [9:0] horizontal_counter = 0;  // horizontal counter
	reg [9:0] vertical_counter = 0;  // vertical counter



	assign o_hsync = (horizontal_counter >= 0 && horizontal_counter < 96) ? 1:0;  // hsync high for 96 counts                                                 
	assign o_vsync = (vertical_counter >= 0 && vertical_counter < 2) ? 1:0;   // vsync high for 2 counts
	assign o_red = (horizontal_counter > 144 && horizontal_counter <= 783 && vertical_counter > 35 && vertical_counter <= 514) ? i_red : 4'h0;
	assign o_blue = (horizontal_counter > 144 && horizontal_counter <= 783 && vertical_counter > 35 && vertical_counter <= 514) ? i_blue : 4'h0;
	assign o_green = (horizontal_counter > 144 && horizontal_counter <= 783 && vertical_counter > 35 && vertical_counter <= 514) ? i_green : 4'h0;
	
	// counter and sync generation
	always @(posedge clk)  // horizontal counter
		begin 
			if (horizontal_counter < 799)
				horizontal_counter <= horizontal_counter + 1;  // horizontal counter (including off-screen horizontal 160 pixels) total of 800 pixels 
			else
				horizontal_counter <= 0;              
		end 
	
	always @ (posedge clk)  // vertical counter
		begin 
			if (horizontal_counter == 799)  // only counts up 1 count after horizontal finishes 800 counts
				begin
					if (vertical_counter < 525)  // vertical counter (including off-screen vertical 45 pixels) total of 525 pixels
						vertical_counter <= vertical_counter + 1;
					else
						vertical_counter <= 0;              
				end
		end

endmodule
