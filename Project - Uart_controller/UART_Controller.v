module UART_Controller(
input i_clk,
input slide_switch,
input push_button,
input reset_button,
input GPIO_Rx,
output [8:0] led,
//output reg [6:0]segmentDisplay,
output GPIO_Tx
);


wire baud_clock, enter_latch_signal, reset_latch_signal, complete_signal, flush_signal;
//reg [8:0] buffer[0:4];


reg [8:0] data0 = 9'h48;	//H
reg [8:0] data1 = 9'h65;	//e
reg [8:0] data2 = 9'h6c;	//l
reg [8:0] data3 = 9'h6c;	//l
reg [8:0] data4 = 9'h6f;	//o


push_button_latch	push_latch(	.i_clk(i_clk),
										.i_push_button(push_button),
										.i_reset(complete_signal),
										.o_signal(enter_latch_signal)
);

push_button_latch	reset_latch(	.i_clk(i_clk),
										.i_push_button(reset_button),
										.i_reset(flush_signal),
										.o_signal(reset_latch_signal)
);

clock_divider_50MHz_to_115200 clock(	.i_enable(slide_switch),
													.i_clk(i_clk),
													.o_clk(baud_clock)
);

UART_Tx tx(	.i_transmit(enter_latch_signal),
				.i_rst(1),
				.i_clk(baud_clock),
				.i_din(data0),
				.o_led(led[0]),
				.o_dout(GPIO_Tx),
				.o_flush_complete(flush_signal),
				.o_transmit_complete(complete_signal)
);

always @ ( posedge complete_signal )
	begin
		data0 <= data1;
		data1 <= data2;
		data2 <= data3;
		data3 <= data4;
		data4 <= data0;
	end

endmodule
