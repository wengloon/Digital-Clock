module UART_Controller
(
input i_clk,
input slide_switch,
input push_button,
input reset_button,
input GPIO_Rx,
output [9:0]led,
output [6:0]segmentDisplay0,
output [6:0]segmentDisplay1,
output [6:0]segmentDisplay2,
output [6:0]segmentDisplay3,
output [6:0]segmentDisplay4,
output [6:0]segmentDisplay5,
output GPIO_Tx
);


wire rx_complete_signal, tx_complete_signal, write, read, data_ready;
wire [7:0] Rx_Data;
wire [7:0] Tx_Data;


UART_Tx tx(
.i_clk(i_clk),
.i_data_avail(data_ready),
.i_din(Tx_Data),
.o_tx_line(GPIO_Tx),
.o_done(tx_complete_signal)
);



UART_Rx rx( .i_clk(i_clk),
			.i_rx_line(GPIO_Rx),
			.o_data_avail(rx_complete_signal),
			.o_dout(Rx_Data)
);

push_button_pulse_gen write_pulse (	.i_clk(i_clk),
									.i_push_button(rx_complete_signal),
									.o_pulse(write)
);

push_button_pulse_gen read_pulse (	.i_clk(i_clk),
									.i_push_button(~push_button),
									.o_pulse(read)
);

FIFO_10_depth__8bits FIFO(	.i_clk(i_clk),
							.i_din(Rx_Data),
							.i_wr(write),
							.i_rd(read),
							.i_rst_n(reset_button),
							.o_data_ready(data_ready),
							.o_empty(),
							.o_full(),
							.o_dout( Tx_Data )
);

endmodule
