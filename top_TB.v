module Top_tb( );

	parameter CLKPERIODE = 60;
	
	// declarations
	wire  [31:0] DATA_MEM_RD;
	wire  [31:0] DATA_MEM_WR;
	wire  [31:0] ADR;
	wire         ready;
	wire         ram_wr_en;
	wire         ram_rd_en;

	reg          clk, reset;
	reg          load;
	reg			 scan_en;
	reg    [4:0] scan_state;
   
	//RAM
	Cov_MEM MEM_i(
     .ADR(ADR),
     .DIN(DATA_MEM_WR),
     .DOUT(DATA_MEM_RD),
     .clk(clk),
     .wr_en(ram_wr_en),
     .rd_en(ram_rd_en)
   );
	
	//DUT
	Cov_Top DUT(
		.EDB_I(DATA_MEM_RD),
		.EAB(ADR),
		.EDB_O(DATA_MEM_WR),
		.clk(clk),
		.load(load),
		.reset(reset),
		.scan_en(scan_en),
		.scan_state(scan_state),
		.ram_rd_en(ram_rd_en),
		.ram_wr_en(ram_wr_en),
		.ready(ready)
		);
	
	initial clk = 1'b1;
	always #(CLKPERIODE/2) clk = !clk;
	
	//Reset
	initial begin
		reset = 1'b1;
		#33
		reset = 1'b0;
	end 
	
	// Load-Signal   
   initial begin
	 scan_en = 1'b0;
     load = 0;
     #(CLKPERIODE)
     load = 1;
     #(CLKPERIODE*1.3)
     load = 0;
     #(4*CLKPERIODE)
	 
	 while (ready == 0) begin
       #(CLKPERIODE);
       load = 0;
     end
	 
     $finish;
   end
endmodule

// Delay Annotation
// initial begin
// $sdf_annotate("/home2/vlsi00/prz-root/ICPRO/ice/tutorial/units/sdf/ALU_FIXED32.sdf",DUT.Datenpfad.ALU,,);
// end 