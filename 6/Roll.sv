module Roll(
	input wire btn,
	input wire clk,
	output wire [2:0] num,
	output wire choose
);

reg [2:0] state = 2'b00;

always_comb begin
	if (state == 0) begin
		num = btn;
	end else if (btn) begin
		if (state == 6)
			num = 1;
		else
			num = state + 1;
	end else
		num = state;
end

always_ff @(posedge clk)
	state <= num;

endmodule