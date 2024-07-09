/////////////////////////////////////////////////////////////////////////////////////////////////////
// PROJECT NAME : Dual Port RAM
// FILE_NAME    : pkg.sv
// AUTHOR       : Bhadresh.v
// MODULE NAME  : Package
// DSCRIPTION   :
// VERSION      :
// DATE         :
/////////////////////////////////////////////////////////////////////////////////////////////////////
`ifndef RAM_PKG_SV
`define RAM_PKG_SV
`include "interface.sv"
package pkg;
    `include "define.sv"
// Enviroment member file
    `include "transaction.sv"
    `include "generator.sv"
    `include "driver.sv"
    `include "monitor.sv"
    `include "reference.sv"
    `include "coverage.sv"
    `include "scoreboard.sv"
// Test case file
    `include "read_test.sv"
    `include "sim_test.sv"
    `include "b2b_test.sv"
    `include "rst_test.sv"
    `include "sanity_test.sv"
    `include "enviroment.sv"
    `include "test.sv"
endpackage
`endif
