module Roll(
	input wire btn,
	input wire clk,
	input wire enable,
	output reg [2:0] num,
	output wire choose
);

initial num = 2'b00;
reg prev_enable;
wire [2:0] next;

always_comb begin
	choose = 1'b0;
	next = num;

	if (enable && !prev_enable) begin
		// Reset number to 0 if a new roll is requested
		next = 0;
	end else if (enable) begin
		if (num == 0) begin
			// Num = 0 if btn not pressed and 1 otherwise
			next = btn;
		end else if (btn) begin
			if (num == 6)
				next = 1;
			else
				next = num + 1;
		end else begin
			choose = 1'b1;
			next = num;
		end
	end
end

always_ff @(posedge clk) begin
	prev_enable <= enable;
	num <= next;
end

endmodule

