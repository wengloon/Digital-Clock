module UART_Controller
#( parameter DATA_BIT = 8,	// Data bits
			STOPBIT_TICK = 16  // stop bit ticks
)

(
input i_clk,
input slide_switch,
input push_button,
input reset_button,
input GPIO_Rx,
output [9:0] led,
output [6:0]segmentDisplay0,
output [6:0]segmentDisplay1,
output [6:0]segmentDisplay2,
output [6:0]segmentDisplay3,
output [6:0]segmentDisplay4,
output [6:0]segmentDisplay5,
output GPIO_Tx
);


wire baud_clock, enter_latch_signal, reset_latch_signal, rx_complete_signal, tx_complete_signal, flush_signal;
wire baud_tick;

wire [7:0] Rx_Data;
reg [7:0] buffer[5:0];


reg [8:0] data0 = 9'h48;	//H
reg [8:0] data1 = 9'h65;	//e
reg [8:0] data2 = 9'h6c;	//l
reg [8:0] data3 = 9'h6c;	//l
reg [8:0] data4 = 9'h6f;	//o

/*
push_button_latch	push_latch(	.i_clk(i_clk),
										.i_push_button(push_button),
										.i_reset(complete_signal),
										.o_signal(enter_latch_signal)	//upper push button
);

push_button_latch	reset_latch(.i_clk(i_clk),
										.i_push_button(reset_button),
										.i_reset(flush_signal),
										.o_signal(reset_latch_signal)	//bottom push button
);
*/

UART_Tx tx(
.i_clk(i_clk),
.i_data_avail(~push_button),
.i_din(8'h30),
.o_tx_line(GPIO_Tx),
.o_done(tx_complete_signal)
);


UART_Rx rx
(
.i_clk(i_clk),
.i_rx_line(GPIO_Rx),
.o_data_avail(rx_complete_signal),
.o_dout(Rx_Data)
);


always @ ( posedge rx_complete_signal )
	begin
		buffer[0] <= Rx_Data;
		buffer[1] <= buffer[0];
		buffer[2] <= buffer[1];
		buffer[3] <= buffer[2];
		buffer[4] <= buffer[3];
		buffer[5] <= buffer[4];
	end
	



Decoder7Segment displaybuffer0( .In(buffer[0]), .segmentDisplay(segmentDisplay0));	//s1
Decoder7Segment displaybuffer1( .In(buffer[1]), .segmentDisplay(segmentDisplay1));	//s1
Decoder7Segment displaybuffer2( .In(buffer[2]), .segmentDisplay(segmentDisplay2));	//s1
Decoder7Segment displaybuffer3( .In(buffer[3]), .segmentDisplay(segmentDisplay3));	//s1
Decoder7Segment displaybuffer4( .In(buffer[4]), .segmentDisplay(segmentDisplay4));	//s1
Decoder7Segment displaybuffer5( .In(buffer[5]), .segmentDisplay(segmentDisplay5));	//s1


endmodule
