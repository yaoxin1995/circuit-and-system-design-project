//Verilog HDL for "praktikum", "FSM" "functional"



module FSM (clk, flag_z1, flag_s1, load, reset, scan_en, scan_state,  state
);
			
	parameter IDLE = 5'b00000;

	parameter INIT1 = 5'b00001;
	parameter INIT2 = 5'b00010;
	parameter INIT3 = 5'b00011;
	parameter INIT4 = 5'b00100;

	parameter CHECK1 = 5'b00101;
	parameter CHECK2 = 5'b00110;
	parameter CHECK3 = 5'b00111;		
	parameter CHECK4 = 5'b01000;		
	parameter CHECK5 = 5'b01001;		
	parameter CHECK6 = 5'b01010;
	parameter CHECK7 = 5'b01011;
	parameter CHECK8 = 5'b01100;

	parameter EXCHANGE1 = 5'b01101;		
	parameter EXCHANGE2 = 5'b01110;		
	parameter EXCHANGE3 = 5'b01111;

	parameter PRELOOP1 = 5'b10000;		
	parameter PRELOOP2 = 5'b10001;

	parameter LOOP1 = 5'b10010;
	parameter LOOP2 = 5'b10011;
    parameter LOOP3 = 5'b10100;
    parameter LOOP4 = 5'b10101;
    parameter LOOP5 = 5'b10110;
    parameter LOOP6 = 5'b10111;
    parameter LOOP7 = 5'b11000;
    parameter LOOP8 = 5'b11001;
    parameter LOOP9 = 5'b11010;
    parameter LOOP10 = 5'b11011;
    parameter LOOP11 = 5'b11100;

    parameter END1 = 5'b11101;
    parameter END2 = 5'b11110;

	
	input clk;
	input reset;
	input load;
    input flag_z1;
	input flag_s1;
	input scan_en;
	input [4:0] scan_state;
	
	output [4:0] state;
	
	reg [4:0] state;
	reg [4:0] next_state;
	
	//current_state(state register)
	always @(posedge clk or posedge reset)
		if(reset) begin
			state <= IDLE;
		end
		else if(scan_en) begin
			state <= scan_state;
		end
		else begin
			state <= next_state;
		end
		
	//next_state logic
	always @(state or load or flag_s1 or flag_z1)
		case(state)
			IDLE: 	if(load) begin
						next_state = INIT1;
					end
					else begin
						next_state = IDLE;
					end
			INIT1:	next_state = INIT2;
			INIT2: 	next_state = INIT3;
			INIT3:	next_state = INIT4;
			INIT4:	if(flag_s1) begin
						next_state = IDLE;
					end
					else begin
						next_state = CHECK1;
					end

			CHECK1:	next_state = CHECK2;
			CHECK2:	if(flag_s1) begin
						next_state = IDLE;
					end
					else begin
						next_state = CHECK3;
					end

			CHECK3:	next_state = CHECK4;
			CHECK4:	if(flag_z1) begin
						next_state = END2;
					end
					else begin
						next_state = CHECK5;
					end
            
			CHECK5:next_state = CHECK6;
			CHECK6:if(flag_z1) begin
						next_state = END2;
					end
					else begin
						next_state = CHECK7;
					end
            
			CHECK7:next_state = CHECK8;
			CHECK8:if(flag_s1) begin
						next_state = EXCHANGE1;
					end
					else begin
						next_state = PRELOOP1;
					end
            
            EXCHANGE1:next_state = EXCHANGE2;
            EXCHANGE2:next_state = EXCHANGE3;
            EXCHANGE3:next_state = PRELOOP1;

            PRELOOP1:next_state = PRELOOP2;
            PRELOOP2:next_state = LOOP1;
            LOOP1:next_state = LOOP2;
            LOOP2:next_state = LOOP3;
            LOOP3:next_state = LOOP4;
            LOOP4:next_state = LOOP5;
            LOOP5:next_state = LOOP6;

			LOOP6:if(flag_z1) begin
						next_state = LOOP7;
					end
					else begin
						next_state = LOOP1;
					end
            LOOP7: next_state = LOOP8;
            LOOP8: next_state = LOOP9;
            LOOP9: next_state = LOOP10;
            LOOP10: next_state = LOOP11;
            LOOP11: if(flag_z1) begin
						next_state = END1;
					end
					else begin
						next_state = LOOP1;
					end
            END1: next_state = IDLE;
            END2: next_state = IDLE;

            
			default: begin 
					next_state = IDLE;
					end
		endcase
	
	
endmodule
