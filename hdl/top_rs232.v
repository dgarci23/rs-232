module top_rs232 

	(
		input				CLOCK_50,
		input				UART_RXD,
		input		[1:0]	KEY,
		input		[7:0]	SW,
		output	[7:0]	LEDR,
		output			UART_TXD
	);
	
	wire RE, WE, KEY_1_DB, KEY_0_DB;
	
	controller controller (
		.clk(CLOCK_50),
		.UART_RXD(UART_RXD),
		.UART_TXD(UART_TXD),
		.RE(RE),
		.WE(WE),
		.send_data(SW),
		.receive_data(LEDR)
	);
	
	debouncer re_debouncer (
		.in(~KEY[0]),
		.out(KEY_0_DB),
		.clk(CLOCK_50)
	);
	
	debouncer we_debouncer (
		.in(~KEY[1]),
		.out(KEY_1_DB),
		.clk(CLOCK_50)
	);
	
	edge_detector re_edge (
		.in(KEY_0_DB),
		.out(RE),
		.clk(CLOCK_50)
	);
	
	edge_detector we_edge (
		.in(KEY_1_DB),
		.out(WE),
		.clk(CLOCK_50)
	);
	
endmodule