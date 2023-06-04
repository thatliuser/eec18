module Game(
	input wire MAX10_CLK1_50,
	input wire [9:0] SW,
	input wire [1:0] KEY,
	output wire [9:0] LEDR,
	output wire [7:0] HEX0,
	output wire [7:0] HEX1,
	output wire [7:0] HEX2,
	output wire [7:0] HEX3,
	output wire [7:0] HEX4,
	output wire [7:0] HEX5
);

// Clock alias
wire clk;
assign clk = MAX10_CLK1_50;
// Low active keys
wire btn;
assign btn = !KEY[0];
wire rst;
assign rst = !KEY[1];

wire [3:0] pulses;
wire [3:0] demux_out;
wire ctrl_pulse_i;
wire ctrl_pulse_o;
assign ctrl_pulse_i = (pulses != 0);

// Game state values
reg [2:0] num;
reg [3:0] score;
reg [3:0] turns;
reg [1:0] state;

wire [3:0] next_score;
wire [1:0] choose_result;
wire won;

Start start(
	.btn(btn),
	.clk(demux_out[0] & clk),
	
	.start(pulses[0])
);

Roll roll(
	.btn(btn),
	.clk(demux_out[1] & clk),
	
	.num(num),
	.choose(pulses[1])
);

Choose choose(
	.pulse_i(demux_out[2]),
	.choice(SW[0]),
	.confirm(btn),
	.num(num),
	.score(score),
	.clk(clk),
	
	.result(choose_result),
	.pulse_o(pulses[2]),
	.new_score(next_score)
);

Control ctrl(
	.pulse_i(ctrl_pulse_i),
	.choose_result(choose_result),
	.clk(clk),
	
	.pulse_o(ctrl_pulse_o),
	.won(won),
	.turns(turns),
	.state(state)
);

// Switches clk between submodules
Demux4 switch(
	.in(1'b1),
	.sel(ctrl_pulse_o),
	.out(demux_out)
);

always_ff @(posedge clk) begin
	score <= next_score;
end

endmodule

