`timescale 1ns / 1ps

module Machine( input clk,
					 input IN, // nickel
					 input ID, // dime
					 input IQ, // quarter
					 input IO, // soda
					 input IE, // diet
					 output reg give_soda, // dispensing soda status
					 output reg give_diet, // dispensing diet soda status
					 output reg status, // 1-accepting coins, 0-not accepting coins
					 output reg change// change back
					); 
	
	reg [27:0] T; // clock divider
	reg T_sig; // clock divider signal
	reg [13:0] S; // all different states : S[0] ... S[13] -> 0, 5, 10, ..., 65	
	reg dispensing; // machine is dispensing drink and/or giving change back
	
	// debounced input wires
	wire N, D, Q, O, E;
	
	// maximum for clock divider
	localparam max_T = 250000000;
	
	// registers initialization
	initial 
	begin
		S = 13'd1; 
		change = 0;
		give_soda = 0;
		give_diet = 0;
		dispensing = 0;
		status = 1;
		T = 28'd0;
	end
	
	// Debounce input module instantiation
	debounce_input UTT (clk, IN, ID, IQ, IO, IE, N, D, Q, O, E);
	//

	///
	always @ (negedge clk)  
	begin
		T_sig <= T == max_T;
		T <= ~dispensing | (T == max_T) ? 28'd0 : T + 28'd1; 
		
		status <= S[0] | S[1] | S[2] | S[3] | S[4] | S[5] | S[6] | S[7] | S[8]; 
	end
	
	///
	always @ (posedge clk)
	begin		
		if (dispensing)
		begin
			if (T_sig)
			begin
				give_soda <= 1'b0;
				give_diet <= 1'b0;
				
				if (S[9])
				begin
					S <= 13'd1;
					dispensing <= 1'b0;
				end
				else
				begin
					if (change)
						S[13:9] <= { 1'b0, S[13], S[12], S[11], S[10] };
						
					change <= ~change;
				end
			end
		end
		else
		begin
			if (status)
			begin
				if (N | D | Q)
				begin 
					S[0]  <=  1'b0;
					S[1]  <=  S[0] & N;
					S[2]  <= (S[0] & D) | (S[1] & N);
					S[3]  <= (S[1] & D) | (S[2] & N);
					S[4]  <= (S[2] & D) | (S[3] & N);
					S[5]  <= (S[0] & Q) | (S[3] & D) | (S[4] & N);
					S[6]  <= (S[1] & Q) | (S[4] & D) | (S[5] & N);
					S[7]  <= (S[2] & Q) | (S[5] & D) | (S[6] & N);
					S[8]  <= (S[3] & Q) | (S[6] & D) | (S[7] & N);
					S[9]  <= (S[4] & Q) | (S[7] & D) | (S[8] & N);
					S[10] <= (S[5] & Q) | (S[8] & D);
					S[11] <=  S[6] & Q;
					S[12] <=  S[7] & Q;
					S[13] <=  S[8] & Q;
				end
			end
			else if (O | E)
			begin
				give_soda <= O;
				give_diet <= E;
				dispensing <= 1'b1;
			end
		end
	end
endmodule
