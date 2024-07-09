/////////////////////////////////////////////////////////////////////////////////////////////////////
// PROJECT NAME : Dual Port RAM
// FILE_NAME    : monitor.sv 
// AUTHOR       : Bhadresh V.
// MODULE NAME  : 
// DSCRIPTION   : Sample Data from DUT using Virtual Interface and put into mailbox (mon2scb & mon2ref)
//                which is get by scoreboard and reference class
// VERSION      :
// DATE         :
/////////////////////////////////////////////////////////////////////////////////////////////////////
`ifndef RAM_MON_SV
`define RAM_MON_SV
class monitor;
  //Handles
  transaction trans_ref;        // Handle put(ref mailbox)
  transaction trans_scb;        // Handle put(scb mailbox)
  transaction trans;            // Handle store value from vifm
  mailbox #(transaction) mon2scb;   //Mailbox handle
  mailbox #(transaction) mon2ref;
  virtual intf.mod_mon vifm;    // Interface handle
  bit [1:0] enb;    // Use for storing wr_enb and rd_enb data

  //Constructor
  function new(mailbox #(transaction)mon2scb,mailbox #(transaction)mon2ref, virtual intf.mod_mon vifm);
     this.vifm =vifm;
     this.mon2scb =mon2scb;
     this.mon2ref =mon2ref;
  endfunction
   
 /*+----------------------------------------------------------------------------------------+
  | TASK : monitor()  :: Sample data from DUT using Interface and Store into the trans      |
  +----------------------------------------------------------------------------------------+*/ 
  task monitor();
        enb = {vifm.cb_mon.wr_enb, vifm.cb_mon.rd_enb};
        $cast(trans.kind,enb);
        @(vifm.cb_mon);
        if(trans.kind == READ || trans.kind == SIM)begin
            @(vifm.cb_mon);

            trans.rd_addr = vifm.cb_mon.rd_addr;
            trans.rd_data = vifm.cb_mon.rd_data;
        end
        if (trans.kind == WRITE || trans.kind == SIM)begin
          trans.wr_addr = vifm.cb_mon.wr_addr;
          trans.wr_data = vifm.cb_mon.wr_data;
        end
  endtask
/*+----------------------------------------------------------------------------------------+
  | TASK :run() :: Get Data from DUT using Interface and Put into the Mailbox (For.SCB,REF)|
  +----------------------------------------------------------------------------------------+*/ 
  task run();
    forever begin
      trans = new();
      monitor();
      trans_ref = new trans;
      trans_scb = new trans;
      mon2scb.put(trans_scb);
      mon2ref.put(trans_ref);
      trans.display("MONITOR",trans.count);
    end
  endtask

 endclass
`endif
