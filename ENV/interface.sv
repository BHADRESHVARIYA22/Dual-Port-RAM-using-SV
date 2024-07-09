/////////////////////////////////////////////////////////////////////////////////////////////////////
// PROJECT NAME : Dual Port RAM
// FILE_NAME    : interface.sv 
// AUTHOR       : Bhadresh.v
// MODULE NAME  : Interface 
// DSCRIPTION   : 
// VERSION      : 1.0 
// DATA         : 23/04/2024
/////////////////////////////////////////////////////////////////////////////////////////////////////
`ifndef RAM_INTF_SV
`define RAM_INTF_SV
interface intf(input logic clk,rst);
    logic wr_enb;
    logic [3:0] wr_addr;
    logic [7:0] wr_data;
    logic rd_enb;
    logic [3:0] rd_addr;
    logic [7:0] rd_data;

    clocking cb_drv @(posedge clk); // Clocking block for Driver
            default input #1 output #1;
            output rd_enb;
            output wr_enb;
            output wr_addr;
            output wr_data;
            output rd_addr;
    endclocking

    clocking cb_mon @(posedge clk); // Clocking block for Monitor  
            default input #1 output #1;
            input rd_enb;
            input wr_enb;
            input rd_addr;
            input wr_addr;
            input wr_data;
            input rd_data;
    endclocking

    modport mod_drv(clocking cb_drv,input rst,clk); // Driver Modport
    modport mod_mon(clocking cb_mon,input clk,rst); // Monitor Modport
endinterface
`endif
