`timescale 1ns / 1ps

module MachineTest;

	// Inputs
	reg clk;
	reg N;
	reg D;
	reg Q;
	reg O;
	reg E;

	// Outputs
	wire give_soda;
	wire give_diet;
	wire status;
	wire change;

	// Instantiate the Unit Under Test (UUT)
	Machine uut (clk, N, D, Q, O, E, give_soda, give_diet, status, change);
	
	always
	begin
		clk = 0;
		#50;
		clk = 1;
		#50;
	end

	initial begin
		N = 0; D = 0; Q = 0;
		O = 0; E = 0;
		#25;
		Q = 1;
		#100;
		Q = 0;
		D = 1;
		#100;
		D = 0;
		N = 1;
		#100;
		N = 0;
		Q = 1;
		#100;
		Q = 0;
		O = 1;
		#100;
		O = 0;
	end
      
endmodule

