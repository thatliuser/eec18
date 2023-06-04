module Roll(
	input wire btn,
	input wire clk,
	output reg [2:0] num,
	output wire choose
);

initial num = 2'b00;
wire [2:0] next;

always_comb begin
	choose = 1'b0;
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

always_ff @(posedge clk) 
	num <= next;

endmodule