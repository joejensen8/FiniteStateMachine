//mealy machine	
module brakeLight

	(//I/O declarations
	input clk, brake,
	input [2:0] l_signal,
	input [2:0] r_signal, 
	output reg [2:0] l_lights,
	output reg [1:0] c_lights,
	output reg [2:0] r_lights);
	
	//register declarations
	reg [1:0] state; 
	reg brake_active;
	
	//state declarations
	parameter idle = 0, brk_active = 1, brk_1 = 2, brk_2 = 3;
	
	//determine if lights need to invert
	always @(posedge clk)
		begin
			if(brake_active)
				begin
					l_lights = ~l_signal;
					r_lights = ~r_signal;
					c_lights = 2'b11;
				end
			else
				begin
					l_lights = l_signal;
					r_lights = r_signal;
					c_lights = 2'b00;	
				end
		end
		
	//determine next state
	always @(posedge clk) 
		begin
			case (state)
					idle: 
						if(brake)
							begin
								state <= brk_active;
							end
						else
							begin
								state <= idle;
							end
					brk_active:
						if(brake)
							begin
								state <= brk_active;
							end
						else
							begin
								state <= brk_1;
							end
					brk_1:
						if(brake)
							begin
								state <= brk_active;
							end
						else
							begin
								state <= brk_2;
							end
					brk_2:
						if(brake)
							begin
								state <= brk_active;
							end
						else
							begin
								state <= idle;
							end
				endcase
		end
		
	//determining output based on current state and brake input
	always @(state or brake)
		begin
			case (state)
				idle:
					if(brake)
						begin
							brake_active = 1;
						end
					else
						begin
							brake_active = 0;
						end
				brk_active: 
					begin
						brake_active = 1;
					end
				brk_1:
					begin
						brake_active = 1;
					end
				brk_2:
					if(brake)
						begin
							brake_active = 1;
						end
					else
						begin
							brake_active = 0;
						end
			endcase
		end
						
				
							
endmodule