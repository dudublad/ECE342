module control
(
	input clk,
	input reset,

	// Button input
	input i_enter,

	// Datapath
	output logic o_inc_actual,
	input i_over,
	input i_under,
	input i_equal,

	// LED Control: Setting this to 1 will copy the current
	// values of over/under/equal to the 3 LEDs. Setting this to 0
	// will cause the LEDs to hold their current values.
	output logic o_update_leds
);

// Declare two objects, 'state' and 'nextstate'
// that are of enum type.
enum int unsigned
{

	S_FIST,
	S_SECOND,
	S_THIRD,
	S_FOURTH

} state, nextstate;

// Clocked always block for making state registers
always_ff @ (posedge clk or posedge reset) begin
	if (reset) state <= // TODO: choose initial reset state
	else state <= nextstate;
end

// always_comb replaces always @* and gives compile-time errors instead of warnings
// if you accidentally infer a latch
always_comb begin
	// Set default values for signals here, to avoid having to explicitly
	// set a value for every possible control path through this always block
	nextstate = state;
	o_inc_actual = 1'b0;
	o_update_leds = 1'b0;

	case (state)
		// TODO: complete this
		S_FIRST: begin
			o_inc_actual = 1'b1;
			if (i_enter) nextstate = S_SECOND;
		end
		S_SECOND: begin
			if (i_enter) nextstate = S_THIRD;
		end
		S_THIRD: begin
			o_update_leds = 1'b0;
			if (i_equal) nextstate = S_FOURTH;
			else nextstate = S_SECOND;
		end
	endcase
end

endmodule
