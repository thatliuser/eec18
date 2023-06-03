module Choose(
	// Input pulse to begin checking
	input wire pulse_i,
	// Switch for "yes" or "no" choice	
	input wire choice,
	// Confirm button to submit answer
	input wire confirm,
	// Number rolled
	input wire [2:0] num,
	input wire [3:0] score,
	input wire clk,
	// Next state for controller: continue, lost, won
	output wire [1:0] result,
	// Pulse to controller
	output wire pulse_o,
	output wire [3:0] new_score
);

// State states
localparam WAIT = 2'b00;
localparam CHECK = 2'b01;
localparam CHOOSE = 2'b10;

// Result states
localparam CONTINUE = 2'b00;
localparam LOST = 2'b01;
localparam WON = 2'b10;

reg [1:0] state = WAIT;
wire [1:0] next;

always_comb begin
	result = CONTINUE;
	pulse_o = 1'b0;
	new_score = score;
	next = state;

	unique case (state)
	WAIT: begin
		if (pulse_i)
			next = CHECK;
	end
	CHECK: begin
		// Always add number if it's 6
		if (num == 6) begin
			next = WAIT;
			pulse_o = 1'b1;
			
			if (score > (15 - 6)) begin
				result = LOST;
				new_score = 0;
			end else if (score == (15 - 6)) begin
				result = WON;
				new_score = 15;
			end else begin
				result = CONTINUE;
				new_score = score + num;
			end
		// Otherwise we wait for user choice
		end else
			next = CHOOSE;
	end
	CHOOSE: begin
		// If they confirmed their choice
		if (confirm) begin
			pulse_o = 1'b1;
			next = WAIT;
			
			// Keep number
			if (choice == 1'b1) begin
				if (score > (15 - num)) begin
					result = LOST;
					new_score = 16;
				end else if (score == (15 - num)) begin
					result = WON;
					new_score = 15;
				end else begin
					result = CONTINUE;
					new_score = score + num;
				end
			// Discard number
			end else begin
				// It's impossible to win or lose given the previous choices
				result = CONTINUE;
				new_score = score;
			end
		end
	end
	endcase
end

always_ff @(posedge clk)
	state <= next;

endmodule