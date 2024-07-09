/////////////////////////////////////////////////////////////////////////////////////////////////////
// PROJECT NAME :   Dual Port RAM
// FILE_NAME    :   read_data.sv
// AUTHOR       :   Bhadresh.v
// MODULE NAME  :   Test case
// DSCRIPTION   :
// VERSION      :
// DATA         :
/////////////////////////////////////////////////////////////////////////////////////////////////////
`ifndef RAM_READ_GEN_SV
`define RAM_READ_GEN_SV
class read_txn extends generator;
  function new(mailbox #(transaction) gen2drv,event drv_done);  //Call from env
    super.new(gen2drv,drv_done);
  endfunction
  task run();
    trans = new();
    repeat(15) begin
      if (!trans.randomize() with {trans.kind == READ;}) 
        $error("[ GENERATOR ]Randomization Failed !");
      super.put2trans();
    end
  endtask
endclass
`endif

