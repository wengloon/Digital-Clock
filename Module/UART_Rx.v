//CLKS_PER_BIT = 50 MHZ clock, 115200 baud UART

module UART_Rx
#(parameter CLKS_PER_BIT = 435)
(
input i_clk,
input i_rx_line,
output o_data_avail,
output [7:0] o_dout
);

localparam	IDLE	= 2'd0,
			START	= 2'd1,
			DATA	= 2'd2,
			STOP	= 2'd3;

reg rx_buffer;
reg rx;	
reg [1:0] state;		
reg [15:0] counter;
reg[2:0] bit_index;
reg data_avail;
reg[7:0] data_byte;



assign o_data_avail = data_avail;
assign o_dout = data_byte;


// State and other register
always @ ( posedge i_clk )
	begin
		rx_buffer <= i_rx_line;
		rx <= rx_buffer;
	end

always @ ( posedge i_clk )
	begin
		case (state)
				IDLE:
					begin
						data_avail <= 1'd0;
						counter <= 16'd0;
						bit_index <= 3'd0;
						if( i_rx_line )
							begin
								state <= START;
							end
					end
				START:
					begin
						if( counter == (CLKS_PER_BIT-1)/2 )
							begin
								if( ~i_rx_line )	//if still low at the middle of the start bit
									begin
										counter <= 16'd0;
										state <= DATA;
									end
								else
									begin
										state <= IDLE;
									end
							end
						else
							begin
								counter <= counter + 16'd1;
							end
					end
				DATA:
					begin
						if( counter < CLKS_PER_BIT-1 )
							begin
								counter <= counter + 16'd1;
							end
						else
							begin
								counter <= 16'd0;
								data_byte[bit_index] <= i_rx_line;
								
								if( bit_index < 7)
									begin
										bit_index <= bit_index + 1;
									end
								else
									begin
										bit_index <= 0;
										state = STOP;
									end
							end
					end
				STOP:
					begin
						if( counter < CLKS_PER_BIT-1 )
							begin
								counter <= counter + 16'd1;
							end
						else
							begin
								data_avail <= 1;
								counter <= 16'd0;
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