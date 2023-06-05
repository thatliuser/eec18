module Start(
	input wire btn,
	input wire clk,
	input wire enable,
	input wire rst,
	output wire start
);

reg on = 1'b0;
wire next;

always_comb begin
	start = 1'b0;
	next = on;

	if (enable) begin
		if (!on) begin
			if (btn)
				next = 1'b1;
		end else begin
			if (!btn) begin
				next = 1'b0;
				// Send start signal after button is released
				start = 1'b1;
			end
		end
	end
end

always_ff @(posedge clk) begin
	if (rst)
		on <= 1'b0;
	else
		on <= next;
end

endmodule
