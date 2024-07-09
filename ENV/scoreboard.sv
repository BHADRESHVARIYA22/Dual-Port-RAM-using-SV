/////////////////////////////////////////////////////////////////////////////////////////////////////
// PROJECT NAME : Dual Port RAM
// FILE_NAME    : scoreboard.sv
// AUTHOR       : Bhadresh V.
// MODULE NAME  : Envoroment 
// DSCRIPTION   : Get data from monitor and Transaction class though different mailbox and compare it 
//                and Print it
// VERSION      :
// DATE         :
/////////////////////////////////////////////////////////////////////////////////////////////////////
`ifndef RAM_SCB_SV
`define RAM_SCB_SV

class scoreboard;
  //Handles
  coverage c1;                      // Handle of coverage class
  transaction trans_act;            // For store Actual data
  transaction trans_exp;            // For store Expec. data
  mailbox #(transaction) mon2scb;   // For get data from mon
  mailbox #(transaction) ref2scb;   // For get data from ref
 
  // Constructor
  function new(mailbox #(transaction) mon2scb, mailbox #(transaction) ref2scb);
    this.mon2scb = mon2scb;
    this.ref2scb = ref2scb;
  endfunction

/*+----------------------------------------------------------------------------------------+
  | TASK : run()  :: Get data from monitor and reference though mailbox,compare it and     |
  |                  Print the Result                                                      |
  +----------------------------------------------------------------------------------------+*/ 
  task run();
    c1 = new();
    forever begin
      mon2scb.get(trans_act);
      ref2scb.get(trans_exp);
      check_data(trans_act,trans_exp);
      c1.put_covg(trans_exp);
    end
  endtask

/*+----------------------------------------------------------------------------------------+
  | TASK :check_datan()  :: Compare ACT and EXP rd_data and Print message w.r.t Result     |
  +----------------------------------------------------------------------------------------+*/ 
  task check_data(transaction trans_act,transaction trans_exp);
   if (trans_act.rd_data == trans_exp.rd_data)
      begin
        trans_exp.display("SCB : EXP",trans_exp.count);
        trans_act.display("SCB : ACT",trans_act.count);
        $display("|\tRESULTS :: PASS !!! ::\t|\n+-----------------------------+");
      end 
    else
      begin
        trans_exp.display("SCB : EXP",trans_exp.count);
        trans_act.display("SCB : ACT",trans_act.count);
        $display("|\tRESULTS :: FAILED !!! ::\n+-----------------------------+");
      end 
  endtask
endclass
`endif
