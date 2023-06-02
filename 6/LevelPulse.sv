module LevelPulse(
	input wire in,
	input wire clk,
	output wire pulse
);

// Sadly wires can't take enum typing
localparam OFF = 2'b00;
localparam PULSE = 2'b01;
localparam ON = 2'b10;

reg [1:0] state = OFF;
wire [1:0] next;

always_comb begin
	unique case (state)
	OFF: begin
		next = in ? PULSE : OFF;
	end
	PULSE: begin
		next = in ? ON : OFF;	
	end
	ON: begin
		next = in ? ON : OFF;
	end
	endcase
end

assign pulse = (next == PULSE);

always_ff @(posedge clk) 
	state <= next;

endmodule