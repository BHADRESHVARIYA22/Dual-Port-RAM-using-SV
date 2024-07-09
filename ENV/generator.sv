/////////////////////////////////////////////////////////////////////////////////////////////////////
// PROJECT NAME : Dual Port RAM
// FILE_NAME    :   generator.sv
// AUTHOR       :   Bhadresh.v
// MODULE NAME  :   Class
// DSCRIPTION   :
// VERSION      :
// DATA         :
/////////////////////////////////////////////////////////////////////////////////////////////////////
`ifndef RAM_GEN_SV
`define RAM_GEN_SV
virtual class generator;
  transaction trans;                // Hanle for store randomize value
  transaction trans1;               // Hanle for put value to mailbox
  mailbox #(transaction) gen2drv;   // Mailbox handle
  event drv_done;                   // Event handle

  // Constructor
  function new(mailbox #(transaction) gen2drv,event drv_done);  //Call from env
    this.gen2drv = gen2drv;
    this.drv_done = drv_done;
  endfunction

  /*+---------------------------------------------------------------------------------------------------------------+
  | TASK : run()  :: Write body at extends testcase class, It randomize and constraint value of trans class members |
  +-----------------------------------------------------------------------------------------------------------------+*/
  pure virtual task run();

 /*+---------------------------------------------------------------------------------------------------------------+
  | TASK : put2trans() :: this task call from Extended testcase class, put value into mailbox and wait for event   |
  +----------------------------------------------------------------------------------------------------------------+*/
  protected task put2trans();
        trans1 = new trans;
        gen2drv.put(trans1);
        trans.display("GENERATOR",trans.count);
        trans.count++;
        @(drv_done);  // Waiting for Driver triggering
  endtask
endclass
`endif
