// RTL coding for module detect  the 1011 string
module string_detector #(parameter FSM_MEALY = 1) (
	input wire clk,
	input wire rst_n,
	input wire din,
	output reg match
);

reg [2:0] state, next_state;

// State encoding
localparam IDLE = 3'b000;
localparam S1 = 3'b001;
localparam S10 = 3'b010;
localparam S101 = 3'b011;
localparam S1011 = 3'b100;

// State transition
always @(posedge clk or negedge rst_n) begin
	if (!rst_n) begin
		state <= IDLE;
	end else begin
		state <= next_state;
	end
end
// Next state logic
always @(*) begin
	case (state)
		IDLE: next_state = din ? S1 : IDLE;
		S1: next_state = din ? S1 : S10;
		S10: next_state = din ? S101 : IDLE;
		S101: next_state = din ? S1011 : S10;
		S1011: next_state = din ? S1 : S10;
		default: next_state = IDLE;
	endcase
end

// output logic
always @(*) begin
	if (!rst_n) begin 
		match <= 1'b0;
	end else if (FSM_MEALY) begin
		match <= (state == S101 && din);
	end else begin
		match <= (state == S1011);
	end
end
endmodule

