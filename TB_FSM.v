
//Verilog HDL for "Cov_Top", "tb_Cov_FSM" "functional"


module tb__FSM();
			
	parameter CLKPERIODE = 100;
	
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
	parameter unused1 = 5'b11111;
	
	wire [4:0] state;
	
	reg clk;
	reg flag_s1;
    reg flag_z1;
	reg reset;
	reg load;
	reg scan_en;
	reg [4:0] scan_state;

	initial clk = 1'b1;
	always #(CLKPERIODE/2) clk = !clk;
	
	//Reset
	initial begin
		reset = 1'b1;
		#60
		reset = 1'b0;
	end 
	
	FSM FSM_i(
		.clk(clk), 
		.reset(reset), 
		.load(load),
        .flag_z1(flag_z1), 
		.flag_s1(flag_s1),  
		.scan_en(scan_en), 
		.scan_state(scan_state),
		.state(state)
	);




	//load signal
	initial begin
		load = 0;
		flag_s1 = 0;
        flag_z1 = 0; 
		scan_en = 0;
		scan_state = 0;
		
		//IDLE TO INIT1
		#(2*CLKPERIODE)
		load = 1;
		#(CLKPERIODE)
		load = 0;
		
		//INIT1 TO INIT4
		#(3*CLKPERIODE)
		
		//INIT4 TO CHECK2
		#(2*CLKPERIODE)

		//CHECK2 TO CHECK4
		#(2*CLKPERIODE)

        //CHECK4 TO CHECK6
		#(2*CLKPERIODE)

        //CHECK6 TO CHECK8
		#(2*CLKPERIODE)

        //CHECK8 TO EXCHANG3
        flag_s1 = 1;
		#(3*CLKPERIODE)

        //EXCHANG3 TO PRELOOP1
		#(1*CLKPERIODE)

        //PRELOOP1 TO LOOP6
		#(7*CLKPERIODE)

        //LOOP6 TO LOOP11
        flag_z1 =1;
		#(5*CLKPERIODE)

        //LOOP11 TO END1 TO IDLE
        flag_z1 =1;
		#(2 *CLKPERIODE)


		//INT4 TO IDEL
        scan_en = 1;
		scan_state = INIT4;
		flag_s1 = 1;
		#(CLKPERIODE)
		scan_en = 0;
		#(CLKPERIODE)

        //CHECK2 TO IDEL
        scan_en = 1;
		scan_state = CHECK2;
		flag_s1 = 1;
		#(CLKPERIODE)
		scan_en = 0;
		#(CLKPERIODE)

        //CHECK4 TO END2 TO IDLE
        scan_en = 1;
		scan_state = CHECK4;
		flag_z1 = 1;
		#(CLKPERIODE)
		scan_en = 0;
		#(2*CLKPERIODE)

        //CHECK6 TO END2 TO IDLE
        scan_en = 1;
		scan_state = CHECK6;
		flag_z1 = 1;
		#(CLKPERIODE)
		scan_en = 0;
		#(2*CLKPERIODE)

        //CHECK8 TO PROLOOP1
        scan_en = 1;
		scan_state = CHECK8;
		flag_s1 = 0;
		#(CLKPERIODE)
		scan_en = 0;
		#(CLKPERIODE)

        //LOOP6 TO LOOP1
        scan_en = 1;
		scan_state = LOOP6;
		flag_z1 = 0;
		#(CLKPERIODE)
		scan_en = 0;
		#(CLKPERIODE)


        //LOOP11 TO LOOP1
        scan_en = 1;
		scan_state = LOOP11;
		flag_z1 = 0;
		#(CLKPERIODE)
		scan_en = 0;
		#(CLKPERIODE)

        //END2 TO IDLE
        scan_en = 1;
		scan_state = END2;
		#(CLKPERIODE)
		scan_en = 0;
		#(CLKPERIODE)
	
		//unused1 TO IDLE
		scan_en = 1;
		scan_state = unused1;
		#(CLKPERIODE)
		scan_en = 0;
		#(CLKPERIODE)


		$finish;

	end	
	
endmodule



