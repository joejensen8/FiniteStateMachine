//moore machine
module turnSignal
		
				(//input and output declarations
				input clk, left, right,
				output reg [2:0] l_signal,
				output reg [2:0] r_signal,
				output reg error);
				
				
				//register declarations
				reg [4:0] state;
				
				//state declarations
				parameter idle = 0, r11 = 1, r12 = 2, r13 = 3, r21 = 4, r22 = 5, 
								r23 = 6, r31 = 7, r32 = 8, r33 = 9, l11 = 10, 
								l12 = 11, l13 = 12, l21 = 13, l22 = 14, 
								l23 = 15, l31 = 16, l32 = 17, l33 = 18, err = 19;
				
				//output
				always @(state)
					begin
						case(state)
						
							//idle
							idle:
							begin
								l_signal <= 0;
								r_signal <= 0;
								error <= 0;
							end
							
							//right light 1
							r11:
							begin
								l_signal<= 0;
								r_signal <= 3'b100;
								error <= 0;
							end
							r12:
							begin
								l_signal<= 0;
								r_signal <= 3'b100;
								error <= 0;
							end
							r13:
							begin
								l_signal<= 0;
								r_signal <= 3'b100;
								error <= 0;
							end
							
							//right light 2
							r21:
							begin
								l_signal <= 0;
								r_signal <= 3'b110;
								error <= 0;
							end
							r22:
							begin
								l_signal <= 0;
								r_signal <= 3'b110;
								error <= 0;
							end
							r23:
							begin
								l_signal <= 0;
								r_signal <= 3'b110;
								error <= 0;
							end
							
							//right light 3
							r31:
							begin
								l_signal <= 0;
								r_signal <= 3'b111;
								error <= 0;
							end
							r32:
							begin
								l_signal <= 0;
								r_signal <= 3'b111;
								error <= 0;
							end
							r33:
							begin
								l_signal <= 0;
								r_signal <= 3'b111;
								error <= 0;
							end
							
							//left light 1
							l11:
							begin
								r_signal <= 0;
								l_signal <= 3'b001;
								error <= 0;
							end
							l12:
							begin
								r_signal <= 0;
								l_signal <= 3'b001;
								error <= 0;
							end
							l13:
							begin
								r_signal <= 0;
								l_signal <= 3'b001;
								error <= 0;
							end
							
							//left light 2
							l21:
							begin
								r_signal <= 0;
								l_signal <= 3'b011;
								error <= 0;
							end
							l22:
							begin
								r_signal <= 0;
								l_signal <= 3'b011;
								error <= 0;
							end
							l23:
							begin
								r_signal <= 0;
								l_signal <= 3'b011;
								error <= 0;
							end
							
							//left light 3
							l31:
							begin
								r_signal <= 0;
								l_signal <= 3'b111;
								error <= 0;
							end
							l32:
							begin
								r_signal <= 0;
								l_signal <= 3'b111;
								error <= 0;
							end
							l33:
							begin
								r_signal <= 0;
								l_signal <= 3'b111;
								error <= 0;
							end
							
							//error
							err:
							begin
								l_signal <= 0;
								r_signal <= 0;
								error <= 1;
							end							
						endcase
					end
					
					
				//next state 
				always @(posedge clk)
					begin
						case (state)
								//idle
								idle:
									if (left && right)
										state = err;
									else if(left)
										state = l11;
									else if(right)
										state = r11;
									else
										state = idle;
										
								//right light 1
								r11:
									state = r12;
								r12:
									state = r13;
								r13:
									if (left && right)
										state = err;
									else if(right)
										state = r21;
									else
										state = idle;
										
								//right light 2
								r21:
									state = r22;
								r22:
									state = r23;
								r23:
									if (left && right)
										state = err;
									else if(right)
										state = r31;
									else
										state = idle;
										
								//right light 3
								r31: 
									state = r32;
								r32:
									state  = r33;
								r33:
									if (left && right)
										state = err;
									else
										state = idle;
										
								//left light 1
								l11:
									state = l12;
								l12:
									state = l13;
								l13:
									if (left && right)
										state = err;
									else if(left)
										state = l21;
									else
										state = idle;
										
								//left light 2
								l21:
									state = l22;
								l22:
									state = l23;
								l23:
									if (left && right)
										state = err;
									else if(left)
										state = l31;
									else
										state = idle;
										
								//left light 3
								l31: 
									state = l32;
								l32:
									state  = l33;
								l33:
									if (left && right)
										state = err;
									else
										state = idle;
										
								//error
								err:
									if(left && right)
										state = err;
									else 
										state = idle;
										
							endcase
				end
endmodule