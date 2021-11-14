
//Verilog HDL for "Cov_Top", "Cov_Controllogic" "functional"


module Cov_Controllogic(
           state, ready, ram_rd_en, ram_wr_en, 
           EN_ALU, EN_DIV,
		   EN_m, EN_n, EN_i, EN_temp,
		   MX_A, MX_B, MX_EAB, MX_EDB,
		   SET_S1, SET_Z1, SUB1);
		   
		   
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



	input [4:0] state;
	output ready;
	output ram_rd_en;
	output ram_wr_en;

    output EN_ALU;
    output EN_DIV;

    output EN_m;
    output EN_n;
    output EN_i;
    output EN_temp;

	output [2:0] MX_A; 
    output [1:0] MX_B; 
    output [1:0] MX_EAB; 
    output MX_EDB; 

	output SET_S1;
    output SET_Z1;  
	output SUB1; 
   
		   
	reg ready;
	reg ram_rd_en;
	reg ram_wr_en;

	reg EN_ALU;
    reg EN_DIV;

    reg EN_m;
    reg EN_n;
    reg EN_i;
    reg EN_temp;

    reg [2:0] MX_A;
    reg [1:0] MX_B;
    reg [1:0] MX_EAB;
    reg MX_EDB;

    reg SET_S1;
    reg SET_Z1;
    reg SUB1;


		   
	always @ (state)
		begin
			ready = 1'b0;
			ram_rd_en = 1'b0;
			ram_wr_en = 1'b0;

            EN_ALU = 1'b0;
            EN_DIV = 1'b0;

            EN_m = 1'b0;
            EN_n = 1'b0;
            EN_i = 1'b0;
            EN_temp = 1'b0;

			MX_A = 3'b000; 
            MX_B = 2'b00;
            MX_EAB = 2'b00;
            MX_EDB = 1'b0;

			SET_S1 = 1'b0; 
			SET_Z1 = 1'b0; 
			SUB1 = 1'b0; 
		
		// case statement
		case (state)
			IDLE: begin
					ready = 1'b1;	// ready if FSM returns to idle state
				  end


			INIT1: begin
					MX_EAB = 2'b00;	// selEAB 0 K0->EAB
					ram_rd_en = 1'b1;	// read MEM
				   end

			INIT2: begin
					MX_A = 3'b110;	// selA 6 MEM->BusA
					EN_m = 1'b1;	// capture data to register m
				   end
				   
			INIT3: begin

                    MX_EAB = 2'b01;      // selEAB 1 K1->EAB
                    ram_rd_en = 1'b1;	// read MEM

                    MX_A = 3'b000;  // selA 0 REG m-> ALU(-)
                    MX_B = 2'b00;   // selB 0 K0 -> ALU(-)

                    EN_ALU = 1'b1;  // ALU enable
                    SUB1 = 1'b1;    // ALU substract
                    SET_S1 = 1'b1; // check flag_s1
				   end
			INIT4: begin
                    MX_A = 3'b110;	// selA 6 MEM->BusA
                    EN_n = 1'b1;  // capture data to register n
				   end

 
			CHECK1: begin
                    MX_A = 3'b001; // selA 1 REG n->BUSA
                    MX_B = 2'b00; //selB 0 K0 ->BUSB

                    EN_ALU = 1'b1;  // ALU enable
                    SUB1 = 1'b1;    // ALU substract
                    SET_S1 = 1'b1; // check flag_s1

				   end

            CHECK2: begin
				    end

			
			CHECK3: begin
                    MX_A = 3'b001; // selA 1 REG n ->BUSA
                    MX_B = 2'b00; // selB 0 K0 -> BUSB

                    EN_ALU = 1'b1;  // ALU enable
                    SUB1 = 1'b1;    // ALU substract
                    SET_Z1 = 1'b1; // check flag_z1
					end

            CHECK4: begin
				    end


            CHECK5: begin
                    MX_A = 3'b000; // selA 0 REG m ->BUSA
                    MX_B = 2'b00; // selB 0 K0 -> BUSB

                    EN_ALU = 1'b1;  // ALU enable
                    SUB1 = 1'b1;    // ALU substract
                    SET_Z1 = 1'b1; // check flag_z1
				    end

            CHECK6: begin
				    end   


            CHECK7: begin
                    MX_A = 3'b000; //selA 0 REG m -> BUSA
                    MX_B = 2'b11; //selB 3 REG n -> BUSB

                    EN_ALU = 1'b1;  // ALU enable
                    SUB1 = 1'b1;    // ALU substract
                    SET_S1 = 1'b1; // check flag_z1
				    end 
            
            CHECK8: begin
				    end

            
            EXCHANGE1: begin
                    MX_A = 3'b000; //selA 0  REG m->BUSA
                    EN_temp = 1'b1; // capture data to REG temp
				    end
            EXCHANGE2: begin
                    MX_A = 3'b001; //selA 1 REG n-> BUSA
                    EN_m = 1'b1; //capture data to REG m
                    end
            EXCHANGE3: begin
                    MX_A = 3'b011; //selA 3 REG temp-> BUSA
                    EN_n = 1'b1; //capture data to REG n
                    end  

            PRELOOP1: begin
                    MX_A = 3'b000; //selA 0 REG m-> BUSA
                    MX_B = 2'B01; //selB 1 k1 -> BUSB

                    EN_ALU = 1'b1;  // ALU enable
                    SUB1 = 1'b1;    // ALU substract
                    end
            PRELOOP2: begin
                    MX_A = 3'b100; //selA 4 ALU->BUSA
                    EN_i = 1'b1; // capture data to REG i  
                    end 

            LOOP1: begin
                    MX_A = 3'b010; //selA 2 REG i ->BUSA
                    MX_B = 2'b01; //selB 1 K1-> BUSB

                    EN_ALU = 1'b1;  // ALU enable
                    end
            LOOP2: begin
                    MX_A = 3'b100; //selA 4 ALU->BUSA
                    EN_i = 1'b1; //capture data to REG i

                    MX_B = 2'b10; //selB 2 selB REG m->BUSB

                    EN_DIV = 1'b1; // DIV enable
                    end
            LOOP3: begin
				    end
            LOOP4: begin
				    end
            LOOP5: begin
                    MX_A = 3'b101; //selA 5 DIV<31:0> ->BUSA
                    MX_B = 2'b00; //selB 0 K0 -> BUSB

                    EN_ALU = 1'b1;  // ALU enable
                    SUB1 = 1'b1;    // ALU substract
                    SET_S1 = 1'b1; // check flag_z1
				    end
            LOOP6: begin
				    end
            
            LOOP7: begin
                    MX_A = 3'b010; //selA 2 REG i->BUSA
                    MX_B = 2'b11; //selB 3 REG n->BUSB

                    EN_DIV = 1'b1; // DIV enable

				    end

            LOOP8: begin
				    end

            LOOP9: begin
				    end
            LOOP10: begin
                    MX_A = 3'b101; //selA 5 DIV-> BUSA
                    MX_B = 2'b00; //selB K0->BUSB

                    EN_ALU = 1'b1;  // ALU enable
                    SUB1 = 1'b1;    // ALU substract
                    SET_Z1 = 1'b1; // check flag_z1
				    end
            LOOP11: begin
				    end

            
            END1: begin
                    MX_EAB = 2'b10; //selEAB 2 K2->EAB
                    MX_EDB = 1'b1; //selEDB REG i->EDB

                    ram_wr_en = 1'b1;	// write MEM
                
                    end
            END2: begin
                    MX_EAB = 2'b10; //selEAB 2 K2->EAB
                    MX_EDB = 1'b0; //selEDB REG i->EDB
                    
                    ram_wr_en = 1'b1;	// write MEM
                    end

		endcase
	end
endmodule



