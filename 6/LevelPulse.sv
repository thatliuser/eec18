module LevelPulse(
	input wire in,
	input wire clk,
	output wire pulse
);

reg on = 1'b0;
wire next;

always_comb begin
	pulse = 1'b0;
	next = on;
	
	if (!on) begin
		if (in) begin
			next = 1'b1;
			pulse = 1'b1;
		end
	end else begin
		if (!in)
			next = 1'b0;
	end
end

always_ff @(posedge clk) 
	on <= next;

endmodule