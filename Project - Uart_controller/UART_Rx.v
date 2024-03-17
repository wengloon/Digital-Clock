module UART_Rx(
input i_clk,
input i_din,
output reg rx_done,
output reg [7:0] o_dout
);

reg [9:0] count;
reg [3:0] rx_count;
reg [3:0] state;


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
					rx_done = 1'd0;
					if(~i_din)
						begin
							rx_count <= 4'd0;
							state <= RECEIVE;
							o_dout <= 8'd0;
						end
				end
			RECEIVE:
				begin
					o_dout <= {i_din,o_dout[7:1]};
					rx_count <= rx_count + 1'b1;
					if( rx_count > 4'h6 )
						begin
							state <= DECISION;
						end
				end
			DECISION:
				begin
					rx_done = 1'd1;
					state <= IDLE;
				end
			default
				begin
					state <= IDLE;
				end
		endcase
	end
	
endmodule 