module FIFO_10_depth__8bits(
input i_clk,
input [7:0]i_din,
input i_wr,
input i_rd,
input i_rst_n,
output reg [9:0]o_led,
output o_empty,
output o_full,
output reg [7:0]o_dout
);


reg [7:0] buffer[9:0];
reg [3:0] write_idx;
reg [3:0] read_idx;
wire [7:0] write_data;
wire [7:0] read_data;

assign o_empty = ( write_idx == read_idx ) ? 1'd1 : 1'd0;	//read index same as write index
assign o_full = ( write_idx + 4'd1 == read_idx ) ? 1'd1 : 1'd0; // read index was infront of write index by 1 only
always @ ( posedge i_clk or negedge i_rst_n)
	begin
		if( ~i_rst_n )
			begin
				o_led <= 0;
			end
		o_led[write_idx] <= 1;
	end
	

always @ ( posedge i_clk or negedge i_rst_n)
	begin
		if( ~i_rst_n )
			begin
				write_idx <= 0;
			end
		else
			begin
				if( i_wr )
					begin
						if( ~o_full )
							begin
								buffer[write_idx] <= i_din;
								write_idx <= write_idx + 4'd1;
							end
					end
			end
	end
	
always @ ( posedge i_clk or negedge i_rst_n)
	begin
		if( ~i_rst_n )
			begin
				read_idx <= 0;
			end
		else
			begin
				if( i_rd )
					begin
						if( ~o_empty )
							begin
								o_dout <= buffer[read_idx];
								read_idx <= read_idx + 4'd1;
							end
						else
							begin
								o_dout <= 7'd0;
							end
					end
			end
	end


endmodule 