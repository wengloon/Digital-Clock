//CLKS_PER_BIT = 50 MHZ clock, 115200 baud UART
module UART_Tx
#(parameter CLKS_PER_BIT = 435)
(
input i_clk,
input i_data_avail,
input [7:0]i_din,
output reg o_tx_line,
output reg o_done
);


reg [1:0] state;
reg [15:0] counter;
reg [2:0] bit_idx;
reg [7:0] buffer;


localparam	IDLE	= 2'd0,
			START	= 2'd1,
			DATA	= 2'd2,
			STOP	= 2'd3;
			

always @ ( posedge i_clk )
	begin
		case( state )
			IDLE:
				begin
					o_tx_line <= 1'd1;	//tx line IDLE HIGH
					o_done <= 1'd0;
					counter <= 16'd0;
					bit_idx <= 1'd0;
					if( i_data_avail )
						begin
							buffer <= i_din;
							state <= START;
						end
				end
			START:	//send start bit
				begin
					o_tx_line <= 1'd0;
					//wait CLKS_PER_BTI -1 clock cycles for start bit to 1
					if( counter < CLKS_PER_BIT - 1)
						begin
							counter <= counter + 16'd1;
						end
					else
						begin
							counter <= 16'd0;
							state <= DATA;
						end
				end
			DATA:
				begin
					o_tx_line <= buffer[bit_idx];
					if( counter < CLKS_PER_BIT - 1)
						begin
							counter <= counter + 16'd1;
						end
					else
						begin
							counter <= 16'd0;
							// Check if we have sent out all bits
							if( bit_idx < 7)
								begin
									bit_idx <= bit_idx + 3'd1;
								end
							else
								begin
									bit_idx <= 3'd0;
									state <= STOP;
								end
						end
				end
			STOP: //send stop bit
				begin
					o_tx_line <= 1;
					if( counter < CLKS_PER_BIT - 1)
						begin
							counter <= counter + 16'd1;
						end
					else
						begin
							o_done <= 1;
							state <= IDLE;
						end
				end
			default:
				begin
					state <= IDLE;
				end
		endcase

	end
	
endmodule 