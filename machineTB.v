`timescale 1ns / 1ps

////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer:
//
// Create Date:   11:31:58 02/21/2018
// Design Name:   Machine
// Module Name:   C:/Users/AndyWindows10S/Documents/USF/System Design/Lab 4 - Vending Machine FSM/Machine/MachineTB.v
// Project Name:  Machine
// Target Device:  
// Tool versions:  
// Description: 
//
// Verilog Test Fixture created by ISE for module: Machine
//
// Dependencies:
// 
// Revision:
// Revision 0.01 - File Created
// Additional Comments:
// 
////////////////////////////////////////////////////////////////////////////////

module MachineTB;

	// Inputs
	reg N;
	reg D;
	reg Q;
	reg O;
	reg E;

	// Outputs
	wire status;
	wire S;

	// Instantiate the Unit Under Test (UUT)
	Machine uut (
		.N(N), 
		.D(D), 
		.Q(Q), 
		.O(O), 
		.E(E), 
		.status(status), 
		.S(S)
	);

	initial begin
		N = 0; D = 0; Q = 0; O = 0; E = 0;
		#50;
		N = 0; D = 0; Q = 1; O = 0; E = 0;
		#50;
		N = 0; D = 1; Q = 0; O = 0; E = 0;
		#50;
		N = 0; D = 0; Q = 1; O = 0; E = 0;
		#50;
		N = 0; D = 1; Q = 0; O = 0; E = 0;
		#50;
		N = 1; D = 0; Q = 0; O = 0; E = 0;
	end
      
endmodule

