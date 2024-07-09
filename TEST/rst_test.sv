/////////////////////////////////////////////////////////////////////////////////////////////////////
// PROJECT NAME :   Dual Port RAM
// FILE_NAME    :   rst_data.sv
// AUTHOR       :   Bhadresh.v
// MODULE NAME  :   Test case
// DSCRIPTION   :
// VERSION      :
// DATA         :
/////////////////////////////////////////////////////////////////////////////////////////////////////
`ifndef RAM_RST_GEN_SV
`define RAM_RST_GEN_SV
class rst_txn extends generator;
  function new(mailbox #(transaction) gen2drv,event drv_done);  //Call from env
    super.new(gen2drv,drv_done);
  endfunction
  task run();
    trans = new();
    repeat(15) begin
      if (!trans.randomize() with {trans.kind == WRITE;
                                     trans.wr_data inside {0,50,135,170,255};
                                  }
      )
        $error("[ GENERATOR ]Randomization Failed !");
        super.put2trans();
    end

    for(int i =0; i<= 100; i++) begin
      if (!trans.randomize() with {trans.kind == READ;})
        $error("[ GENERATOR ]Randomization Failed !");
      else
        super.put2trans();
      if(i>=5 && i<=10) begin
        transaction::reset = 1'b1;
        #(CYCLE*2);
        transaction::reset = 1'b0;
        #(CYCLE*2);
      end
    end
  endtask
endclass
`endif
