module FIFO

	#(
		parameter SIZE = 16,
		parameter WORD_LEN = 8
	)
	
	(
		input										clk,
		input										rst,
		input			[WORD_LEN-1:0]			in,
		input										we,
		input										re,
		output reg	[WORD_LEN-1:0]			out,
		output 									empty
	);
	
	
	reg [WORD_LEN-1:0] data [SIZE-1:0];
	
	reg [$clog2(SIZE)-1:0] rpointer, wpointer;
	initial rpointer = 0;
	initial wpointer = 0;
	
	assign empty = (rpointer == wpointer);
	
	always @(posedge clk)
		begin
			if (rst)
			begin
				rpointer <= 0;
				wpointer <= 0;
			end
			else
			begin
				if (we)
				begin
					data[wpointer] <= in;
					wpointer <= wpointer + 1;
				end
				if (re)
				begin
					out <= data[rpointer];
					rpointer <= rpointer + 1;
				end
			end
		end
		
endmodule
		