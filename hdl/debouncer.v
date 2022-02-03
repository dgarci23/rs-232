module debouncer (
	input clk,
	input in,
	output reg out
	);
	
	reg [19:0] count;
	
	always @(posedge clk)
		count <= count + 1'b1;
		
	always @(posedge count[19])
		out <= in;

endmodule