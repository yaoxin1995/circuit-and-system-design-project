//Verilog HDL for "ICE_Example", "Sort_Memory" "functional"


module Memory ( DIN, DOUT, ADR, clk, wr_en, rd_en );

   input         clk;
   input         wr_en;
   input         rd_en;
   input  [31:0] DIN;
   input  [31:0] ADR;
   output [31:0] DOUT;
// RAM
   reg    [31:0] ram [0:1023];
   reg    [31:0] DOUT;
   wire   [31:0] ram_add0 = ram[0];
   wire   [31:0] ram_add1 = ram[1];
   wire   [31:0] ram_add2 = ram[2];
   wire   [31:0] ram_add3 = ram[3];
   wire   [31:0] ram_add4 = ram[4];
   wire   [31:0] ram_add5 = ram[5];
   wire   [31:0] ram_add6 = ram[6];
   wire   [31:0] ram_add7 = ram[7];

    
   always @ (posedge clk)
     begin
       if (wr_en) 
         ram[ADR[9:0]] <= DIN;
       else
         if (rd_en) 
           DOUT <= ram[ADR[9:0]];

     end // always

     initial $readmemh("../mem_data.txt",ram);

endmodule
