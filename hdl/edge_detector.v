module edge_detector (
   input 	clk,
   input 	in,
   output 	out
   );
	
   reg [1:0] q;
   
   always @(posedge clk) begin
      q[1] <= in;
      q[0] <= q[1];
   end
   
   assign out = q[1] & ~q[0];

endmodule