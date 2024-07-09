/////////////////////////////////////////////////////////////////////////////////////////////////////
// PROJECT NAME :   Dual Port RAM
// FILE_NAME    :   sim_case.sv
// AUTHOR       :   Bhadresh.v
// MODULE NAME  :   Test case
// DSCRIPTION   :   
// VERSION      :
// DATA         :
/////////////////////////////////////////////////////////////////////////////////////////////////////
`ifndef RAM_SIM_GEN_SV
`define RAM_SIM_GEN_SV
class sim_txn extends generator;
  function new(mailbox #(transaction) gen2drv,event drv_done);  //Call from env
    super.new(gen2drv,drv_done);
  endfunction
  task run();
    trans = new();
    repeat(400) begin
      if (!trans.randomize() with {trans.kind == SIM;
                                   trans.wr_data inside {0,50,135,170,255};
                                   trans.wr_addr inside {0,3,7,11,15};
                                   trans.rd_addr != trans.wr_addr;
                                  }
      ) $error("[ GENERATOR ]Randomization Failed !");
      else 
        super.put2trans();
    end
  endtask
endclass
`endif

