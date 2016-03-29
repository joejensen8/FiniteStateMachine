//David Merriman: dam134
//John Tomko: jst62
//Joe Jensen: jpj35
module lab1
       (
           //////////////////////// Clock Input ////////////////////////
           input CLOCK_50,
           input CLOCK_50_2,
           //////////////////////// Push Button ////////////////////////
           input [ 2: 0 ] BUTTON,
           //////////////////////// DPDT Switch ////////////////////////
           input [ 9: 0 ] SW,
           //////////////////////// 7-SEG Display ////////////////////////
           output [ 6: 0 ] HEX0_D,
           output HEX0_DP,
           output [ 6: 0 ] HEX1_D,
           output HEX1_DP,
           output [ 6: 0 ] HEX2_D,
           output HEX2_DP,
           output [ 6: 0 ] HEX3_D,
           output HEX3_DP,
           //////////////////////// LED ////////////////////////
           output [ 9: 0 ] LEDG
       );
		 

// =======================================================
// REG/WIRE declarations
// =======================================================
	
	//clock wire
	wire slw_clk;
	
	//input wires
	wire right_in;
	wire left_in;
	wire brake_in;
	
	//output wires
	wire error_out;
	wire [2:0] right_signal_out;
	wire [2:0] left_signal_out;
	wire [1:0] brake_out;
	wire [2:0] left_brk_lights;
	wire [2:0] right_brk_lights;
	

//=======================================================
// Input/Output assignments
//=======================================================
	//input
	assign right_signal_in = SW[0];
	assign left_signal_in = SW[1];
	assign brake_in = ~BUTTON[2];
	
	//output
	assign HEX0_D [6:0] = ~0;
	assign HEX1_D [6:0] = ~0;
	assign HEX2_D [6:0] = ~0;
	assign HEX3_D [6:0] = ~0;
	assign HEX1_DP = 1;
	assign HEX2_DP = 1;
	assign HEX0_DP = ~error_out;
	assign HEX3_DP = ~slw_clk;
	assign LEDG [2:0] = right_brk_lights [2:0];
	assign LEDG [9:7] = left_brk_lights [2:0];
	assign LEDG[5:4] = brake_out[1:0];
	

// =======================================================
// Structural coding
// =======================================================

	slowClock my_clk(CLOCK_50, slw_clk);
	
	turnSignal my_signal(slw_clk, left_signal_in, right_signal_in, left_signal_out[2:0], right_signal_out[2:0], error_out);
	
	brakeLight my_brake_light(slw_clk, brake_in, left_signal_out [2:0], right_signal_out [2:0], left_brk_lights [2:0], brake_out [1:0], right_brk_lights [2:0]);
	

endmodule





				
				
				
				