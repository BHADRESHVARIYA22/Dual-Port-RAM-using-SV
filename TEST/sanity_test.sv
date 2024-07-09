/////////////////////////////////////////////////////////////////////////////////////////////////////
// PROJECT NAME :   Dual Port RAM
// FILE_NAME    :   sanity_test.sv
// AUTHOR       :   Bhadresh.v
// MODULE NAME  :   Class
// DSCRIPTION   :
// VERSION      :
// DATA         :
/////////////////////////////////////////////////////////////////////////////////////////////////////
`ifndef RAM_SANITY_GEN_SV
`define RAM_SANITY_GEN_SV
class sanity_txn extends generator;
  function new(mailbox #(transaction) gen2drv,event drv_done);  //Call from env
    super.new(gen2drv,drv_done);
  endfunction
  task run();
    trans = new();
    repeat(10) begin
      if (!trans.randomize() with {trans.kind == WRITE;
                                   trans.wr_addr inside {0,4,8,12,15};
                                   trans.wr_data inside {0,50,100,200,255};
                                  }
      )
        $error("[ GENERATOR ]Randomization Failed !");
        super.put2trans();
    end
  endtask
endclass
`endif
