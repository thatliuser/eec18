module Control(
	input wire pulse_i,
	input wire [1:0] choose_result,
	input wire clk,
	// Used to trigger pulse for Choose module (high otherwise)
	output wire pulse_o,
	// Whether or not the player one for End module
	output wire won,
	output reg [3:0] turns,
	// Current state of the game (for demux)
	output reg [1:0] state
);

// Choose results from Choose.sv
localparam CONTINUE = 2'b00;
localparam LOST = 2'b01;
localparam WON = 2'b10;

// State states
localparam START = 2'b00;
localparam ROLL = 2'b01;
localparam CHOOSE = 2'b10;
localparam END = 2'b11;

initial begin
	state = START;
	turns = 0;
end

wire [1:0] next_state;
wire [3:0] next_turns;

always_comb begin
	next_state = state;
	next_turns = turns;
	pulse_o = 1'b1;
	won = 1'b0;

	unique case (state)
	START: begin
		// Button clicked in Start module
		if (pulse_i) begin
			next_turns = 1;
			next_state = ROLL;
		end
	end
	ROLL: begin
		// Roll finished
		if (pulse_i)
			next_state = CHOOSE;
	end
	CHOOSE: begin
		// IDK if I need to do this
		// TODO: Figure this out after you connect everything together
		// pulse_o = 1'b0;
		if (pulse_i) begin
			unique case (choose_result)
			CONTINUE: begin
				next_state = ROLL;
				next_turns = turns + 1;
			end
			LOST: begin
				next_state = END;
				won = 1'b0;
			end
			WON: begin
				next_state = END;
				won = 1'b1;
			end
			endcase
		end
	end
	END: begin
		// Nothing. We are done. Implement reset later
	end
	endcase
end

always_ff @(posedge clk) begin
	state <= next_state;
	turns <= next_turns;
end

endmodule

