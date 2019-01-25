`timescale 1ns / 1ps

module debounce_input (	input clk, 
								input N,
								input D, 
								input Q,
								input O, 
								input E,
								output DN,
								output DD, 
								output DQ,
								output DO,
								output DE
							 );
							 
					
	reg pe_ff, ne_ff;
	reg [20:0] T;
	reg [4:0] b;
	
	initial pe_ff = 1'b0;
	initial ne_ff = 1'b0;
	initial T = 21'd0;
	initial b = 5'd0;
	
	// We sample the inputs every half clock cycle, so two always blocks are needed
	always @ (posedge clk)
	begin
		pe_ff <= N | D | Q | O | E;
	end
	
	always @ (negedge clk)
	begin
		ne_ff <= N | D | Q | O | E;
	end
	//
	
	// T counter 
	always @ (negedge clk)
	begin
		if (~pe_ff | ~ne_ff) // check for a fluctuation
			T <= 21'd0; // T reset
		else if (T != 1048577) 
			T <= T + 21'd1;
			
		b[4] <= (N & ~D & ~Q & ~O & ~E & (T == 1048576));
		b[3] <= (~N & D & ~Q & ~O & ~E & (T == 1048576));
		b[2] <= (~N & ~D & Q & ~O & ~E & (T == 1048576));
		b[1] <= (~N & ~D & ~Q & O & ~E & (T == 1048576));
		b[0] <= (~N & ~D & ~Q & ~O & E & (T == 1048576)); 
	end
	
	assign DN = b[4];
	assign DD = b[3];
	assign DQ = b[2];
	assign DO = b[1];
	assign DE = b[0];
	
endmodule
