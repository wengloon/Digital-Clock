module UART_Rx(
input i_clk,
input i_din,
output reg indicator
);

reg [9:0] count;
reg [3:0] rx_count;
reg [3:0] state;
reg [7:0] buffer;
reg [14:0] indication_count;


parameter	IDLE = 4'd0,
			RECEIVE = 4'd1,
			DECISION = 4'd2;
			
initial count = 10'd0;

always @ ( posedge i_clk )
	begin
		case (state)
			IDLE:
				begin
					rx_count <= 4'h0;
					indicator <= 8'b00000000;
					indication_count <= 15'd0;
					if(~i_din)
						begin
							rx_count <= 4'd0;
							state <= RECEIVE;
							buffer <= 8'd0;
						end
				end
			RECEIVE:
				begin
					buffer <= {i_din,buffer[7:1]};
					rx_count <= rx_count + 1'b1;
					if( rx_count > 4'h6 )
						begin
							state <= DECISION;
						end
				end
			DECISION:
				begin
					if(( buffer[6:0] == 7'h47 ) && ( buffer[7] == 1'b0))
						begin
							indicator <= 8'b00001111;
							indication_count <= indication_count +1'b1;
							state <= IDLE;
							if( indication_count > 15'd9700)
								begin
								end
							else
								begin
									indicator <= 8'b00000000;
								end
						end
				end
			default
				begin
					state <= IDLE;
				end
		endcase
	end
	
endmodule 