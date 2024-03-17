module UART_Tx(
input i_clk,
input i_transmit,
input i_rst,
input [8:0]i_din,
output reg o_led,
output reg o_transmit_complete,
output reg o_flush_complete,
output reg o_dout
);

reg [8:0] buffer;
reg [9:0] count;
reg [3:0] state;
reg	start;

parameter	IDLE		= 4'd0,
			START_BIT	= 4'd1,
			BIT_0 		= 4'd2,
			BIT_1 		= 4'd3,
			BIT_2 		= 4'd4,
			BIT_3 		= 4'd5,
			BIT_4 		= 4'd6,
			BIT_5 		= 4'd7,
			BIT_6 		= 4'd8,
			PARITY 		= 4'd9;

			
always @ ( posedge i_clk or negedge i_transmit or negedge i_rst )
	begin
		if(~i_rst)
			begin
				state <= START_BIT;
				buffer <= {1'b0,7'd0,1'b0};
				start <= 1'd1;
				o_flush_complete <= 1'd1;
				o_led = 1'd1;
			end
		else if(~i_transmit)
			begin
				state <= START_BIT;
				buffer <= {1'b0,i_din[6:0],1'b0};
				start <= 1'd1;
				o_transmit_complete <= 1'd1;
				//o_led = 1'd1;
			end
		else
			begin
				case (state)
					IDLE:
						begin
							o_dout <= 1'b1;
							start <=  1'b0;
							o_transmit_complete <= 1'd1;
							o_flush_complete <= 1'd0;
							//o_led = 1'd1;
						end
					START_BIT:
						begin
							o_dout <= buffer[0];
							state <=  BIT_0;
							o_transmit_complete <= 1'd0;
							o_flush_complete <= 1'd0;
							o_led = 1'd0;
						end
					BIT_0:
						begin
							o_dout <= buffer[1];
							state <=  BIT_1;
							o_led = 1'd0;
						end
					BIT_1:
						begin
							o_dout <= buffer[2];
							state <=  BIT_2;
							o_led = 1'd0;
						end
					BIT_2:
						begin
							o_dout <= buffer[3];
							state <=  BIT_3;
							o_led = 1'd0;
						end
					BIT_3:
						begin
							o_dout <= buffer[4];
							state <=  BIT_4;
							o_led = 1'd0;
						end
					BIT_4:
						begin
							o_dout <= buffer[5];
							state <=  BIT_5;
							o_led = 1'd0;
						end
					BIT_5:
						begin
							o_dout <= buffer[6];
							state <=  BIT_6;
							o_led = 1'd0;
						end
					BIT_6:
						begin
							o_dout <= buffer[7];
							state <=  PARITY;
							o_led = 1'd0;
						end
					PARITY:
						begin
							o_dout <= buffer[8];
							state <=  IDLE;
							o_led = 1'd0;
						end
					default:
						begin
							state <=  IDLE;
							o_led = 1'd0;
						end
				endcase
			end
	end
	
endmodule 