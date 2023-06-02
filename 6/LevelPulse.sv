module LevelPulse(
	input wire in,
	input wire clk,
	output wire pulse
);

typedef enum {
	OFF,
	PULSE,
	ON
} PulseState;

PulseState state = OFF;

always_ff @(posedge clk) begin
	unique case (state)
		OFF: begin
		if (in == 1'b1)
			state <= PULSE;
			
		pulse <= 1'b0;
		end
		PULSE: begin
		if (in == 1'b1)
			state <= ON;
		else
			state <= OFF;
			
		pulse <= 1'b1;
		end
		ON: begin
		if (in == 1'b0)
			state <= OFF;
			
		pulse <= 1'b0;
		end
	endcase
end

endmodule