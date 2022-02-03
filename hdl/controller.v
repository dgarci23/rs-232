// Following design found on http://www.nandland.com
module controller

	#(
		parameter CLKS_PER_BIT = 5208
	)
	
	(
		input						CLOCK_50,
		output 					UART_TXD,
		input						UART_RXD,
		input			 [9:0]	SW,
		input			 [1:0]	KEY,
		output		 [10:0]	LEDR
	);
	
	reg state;
	
	wire [7:0] rx_data, tx_data;
	wire rx_done, tx_busy;
	
	/*rx_controller rx (
		.clk(CLOCK_50),
		.UART_RXD(UART_RXD),
		.RX_DATA(rx_data),
		.RX_DONE(rx_done)
	);*/
	
	tx_controller tx (
		.clk(CLOCK_50),
		.TX_SEND(~(empty|tx_busy)&KEY_1),
		.UART_TXD(UART_TXD),
		.TX_DATA(tx_data),
		.TX_DONE(),
		.TX_BUSY(tx_busy)
	);
	
	/*always @(posedge CLOCK_50)
		state <= SW[8];*/
		
	wire empty;	
		
	FIFO FIFO (
		.clk(CLOCK_50),
		.rst(1'b0),
		.in(SW[7:0]),
		.we(TX_SEND_EDGE),
		.re(~(empty|tx_busy)&KEY_1),
		.out(tx_data),
		.empty(empty),
		.led(LEDR[8:0])
	);
	
	assign LEDR[10] = tx_busy;

	assign LEDR[9] = empty;
	
	wire TX_SEND_DB, TX_SEND_EDGE;
	
	debouncer debouncer (
		.clk(CLOCK_50),
		.in(~KEY[0]),
		.out(TX_SEND_DB)
	);
	
	debouncer debouncer1 (
		.clk(CLOCK_50),
		.in(~KEY[1]),
		.out(KEY_1)
	);
	
	edge_detector edge_detector (
		.clk(CLOCK_50),
		.in(TX_SEND_DB),
		.out(TX_SEND_EDGE)
	);
		
endmodule
					
					
					