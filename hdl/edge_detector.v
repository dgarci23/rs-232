module edge_detector 

	#(parameter SIZE = 1)

	(
		input 					clk,
		input 	[SIZE-1:0]	in,
		output 	[SIZE-1:0]	out
   );
	
   reg [2*SIZE-1:0] q;
   
   always @(posedge clk) begin
      q[2*SIZE-1:SIZE] <= in;
      q[SIZE-1:0] <= q[2*SIZE-1:SIZE];
   end
   
   assign out = q[2*SIZE-1:SIZE] & ~q[SIZE-1:0];

endmodule