module tb_Cov_Controllogic ( );




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
	
 
    reg [4:0] state
    wire ready;
    wire ram_rd_en;
    wire ram_wr_en;

    wire EN_ALU;
    wire EN_DIV;

    wire EN_m;
    wire EN_n;
    wire EN_i;
    wire EN_temp;

    wire [2:0] MX_A;
    wire [1:0] MX_B;
    wire [1:0] MX_EAB;
    wire MX_EDB;

    wire SET_S1;
    wire SET_Z1;
    wire SUB1;


controllogic Controllogic_i(
        .state(state),
        .ready(ready),
        .ram_rd_en(ram_rd_en),
        .ram_wr_en(ram_wr_en),
        .EN_ALU(EN_ALU),
        .EN_DIV(EN_ALU2),

        .EN_m(EN_m),
        .EN_n(EN_n),

        .EN_i(EN_i),
        .EN_temp(EN_temp),

        .MX_A(MX_A),
        .MX_B(MX_B),
        .MX_EAB(MX_EAB),

        .MX_EDB(MX_EDB),

        .SET_S1(SET_S1),
        .SET_Z1(SET_Z1),
        .SUB1(SUB1),
    );
initial
begin
    state = IDLE;
    #(CLKPERIODE)

    state = INIT1;
    #(CLKPERIODE)

    state = INIT2;
    #(CLKPERIODE)

     state = INIT3;
    #(CLKPERIODE)

    state = INIT4;
    #(CLKPERIODE)

    state = CHECK1;
    #(CLKPERIODE)

    state = CHECK2;
    #(CLKPERIODE)

    state = CHECK3;
    #(CLKPERIODE)

    state = CHECK4;
    #(CLKPERIODE)

    state = CHECK5;
    #(CLKPERIODE)

    state = CHECK6;
    #(CLKPERIODE)

    state = CHECK7;
    #(CLKPERIODE)

    state = CHECK8;
    #(CLKPERIODE)

    state = EXCHANGE1;
    #(CLKPERIODE)

    state = EXCHANGE2;
    #(CLKPERIODE)

    state = EXCHANGE3;
    #(CLKPERIODE)

    state = PRELOOP1;
    #(CLKPERIODE)

    state = PRELOOP2;
    #(CLKPERIODE)

    state = LOOP1;
    #(CLKPERIODE)

    state = LOOP2;
    #(CLKPERIODE)

    state = LOOP3;
    #(CLKPERIODE)

    state = LOOP4;
    #(CLKPERIODE)

    state = LOOP5;
    #(CLKPERIODE)

    state = LOOP6;
    #(CLKPERIODE)

    state = LOOP7;
    #(CLKPERIODE)

    state = LOOP8;
    #(CLKPERIODE)


    state = LOOP9;
    #(CLKPERIODE)

    state = LOOP10;
    #(CLKPERIODE)

    state = LOOP11;
    #(CLKPERIODE)

    state = END1;
    #(CLKPERIODE)

    state = END2;
    #(CLKPERIODE)

    
    $finish;
end
endmodule