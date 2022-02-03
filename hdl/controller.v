// Following design found on http://www.nandland.com
module controller

	#(
		parameter CLKS_PER_BIT = 5208
	)
	
	(
		input					CLOCK_50,
		// UART signals to the DE2-115
		output 					UART_TXD,
		input					UART_RXD,
		// Read signal from the processor
		input					RE,
		input					WE
		// UART data
		input		[7:0]			send_data,
		output		[7:0]			receive_data	
	);
	
	wire [7:0] rx_data, tx_data;
	wire rx_done, tx_busy, tx_done, rx_done, tx_empty, rx_empty;

	assign tx_done = ~(tx_empty|tx_busy);
	
	rx_controller rx (
		.clk(CLOCK_50),
		.UART_RXD(UART_RXD),
		.RX_DATA(rx_data),
		.RX_DONE(rx_done)
	);
	
	tx_controller tx (
		.clk(CLOCK_50),
		.TX_SEND(tx_done),
		.UART_TXD(UART_TXD),
		.TX_DATA(tx_data),
		.TX_DONE(),
		.TX_BUSY(tx_busy)
	);
		
	FIFO fifo_tx (
		.clk(CLOCK_50),
		.rst(1'b0),
		.in(send_data),
		.we(WE),
		.re(tx_done),
		.out(tx_data),
		.empty(tx_empty),
	);

	FIFO fifo_rx (
		.clk(CLOCK_50),
		.rst(1'b0),
		.in(tx_data),
		.we(rx_done),
		.re(RE),
		.out(receive_data),
		.empty(rx_done)
	);
	
endmodule
					
					
					
