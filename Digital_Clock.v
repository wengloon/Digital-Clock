module Digital_Clock(
	input clk,
	output [6:0] seg
	);
	//time display
	//h2 h1 : m2 m1
	
	
	reg [3:0] In;
	reg [31:0]segclk;
	
	initial
		begin
			In = 4'd0;
		end
	
	always @( posedge clk )
		begin
			segclk <= segclk+1'b1; //counter goes up by 1
			if ( segclk >= 32'd50000000 )
				begin
					In = In + 1'b1;
					segclk <= 32'd0; //counter goes up by 1
					if ( In >= 4'd10 )
						begin
							In <= 4'd0;
						end
				end
			end

		Decoder7Segment sec1( .In(In), .segmentDisplay(seg));

endmodule
