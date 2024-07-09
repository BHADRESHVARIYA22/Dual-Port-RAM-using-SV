/////////////////////////////////////////////////////////////////////////////////////////////////////
// PROJECT NAME :   Dual Port RAM
// FILE_NAME    :   b2b_data.sv
// AUTHOR       :   Bhadresh.v
// MODULE NAME  :   Test case
// DSCRIPTION   :
// VERSION      :
// DATA         :
/////////////////////////////////////////////////////////////////////////////////////////////////////
`ifndef RAM_B2B_GEN_SV
`define RAM_B2B_GEN_SV
class b2b_txn extends generator;
  function new(mailbox #(transaction) gen2drv,event drv_done);  //Call from env
    super.new(gen2drv,drv_done);
  endfunction
  task run();
    trans = new();
    repeat(300) begin
      if (!trans.randomize() with {trans.kind == WRITE;
                                   trans.wr_data inside {0,50,135,170,255};
                                   trans.wr_addr inside {0,3,7,11,15};
                                  }
      ) $error("[ GENERATOR ]Randomization Failed !");
      super.put2trans();

      if (!trans.randomize() with {trans.kind == READ;
                                   trans.rd_addr inside {0,3,7,11,15};
                                   }
      ) $error("[ GENERATOR ]Randomization Failed !");
      super.put2trans();
    end
  endtask
endclass
`endif

