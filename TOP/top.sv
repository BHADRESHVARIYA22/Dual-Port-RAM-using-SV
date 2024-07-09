/////////////////////////////////////////////////////////////////////////////////////////////////////
// PROJECT NAME : Dual Port RAM
// FILE_NAME    : top.sv
// AUTHOR       : Bhadresh.v
// MODULE NAME  : Test bench top
// DSCRIPTION   :
// VERSION      :
// DATE         :
/////////////////////////////////////////////////////////////////////////////////////////////////////
`ifndef RAM_TOP_SV
`define RAM_TOP_SV
import pkg::*;
module top;
    logic clk;
    logic rst;

    test t1;

   //Clock Generation
    initial begin
		clk = 1'b0;
		forever 
			#(CYCLE / 2) clk = ~clk;
	end

    //Reset generation
    initial begin
      rst =1;
      #(CYCLE * 2) rst = 0;
    end

    always@(*) begin
      if(transaction::reset)
        rst = 1;
      else 
        rst = 0;
    end

    //intsance of interface
    intf intf_i(clk,rst);

    //DUT instansiate
    ram dut(.clk(clk),
            .rst(intf_i.rst),
            .wr_enb(intf_i.wr_enb),
            .wr_addr(intf_i.wr_addr),
            .wr_data(intf_i.wr_data),
            .rd_enb(intf_i.rd_enb),
            .rd_addr(intf_i.rd_addr),
            .rd_data(intf_i.rd_data));

    initial begin
      t1 = new (intf_i.mod_drv,intf_i.mod_mon);
      t1.run();
    end
endmodule
`endif
