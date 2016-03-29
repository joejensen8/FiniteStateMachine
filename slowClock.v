//2.98 hz clk
module slowClock
	
	(//I/O declarations
	input clk,
	output new_clk);
	
	//register declarations
	reg[23:0] count;
	
	//assignments
	assign new_clk = count[23];
	
	//24 bit counter
	always @(posedge clk)
		begin
				count <= count+1;
		end
	
endmodule