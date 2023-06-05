module Digit(
	input wire [3:0] num,
	output wire [7:0] seg
);

always_comb begin
	unique case (num)
		4'b0000: seg <= 7'h7E;
		4'b0001: seg <= 7'h30;
		4'b0010: seg <= 7'h6D;
		4'b0011: seg <= 7'h79;
		4'b0100: seg <= 7'h33;          
		4'b0101: seg <= 7'h5B;
		4'b0110: seg <= 7'h5F;
		4'b0111: seg <= 7'h70;
		4'b1000: seg <= 7'h7F;
		4'b1001: seg <= 7'h7B;
		4'b1010: seg <= 7'h77;
		4'b1011: seg <= 7'h1F;
		4'b1100: seg <= 7'h4E;
		4'b1101: seg <= 7'h3D;
		4'b1110: seg <= 7'h4F;
		4'b1111: seg <= 7'h47;
	endcase
end

endmodule