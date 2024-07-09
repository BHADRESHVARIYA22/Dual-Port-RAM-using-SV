/////////////////////////////////////////////////////////////////////////////////////////////////////
// PROJECT NAME : Dual Port RAM
// FILE_NAME    : reference.sv
// AUTHOR       : Bhadresh V.
// MODULE NAME  : Enviroment 
// DSCRIPTION   :
// VERSION      :
// DATA         :
/////////////////////////////////////////////////////////////////////////////////////////////////////
`ifndef RAM_REF_SV
`define RAM_REF_SV
class reference;
  mailbox #(transaction) mon2ref;
  mailbox #(transaction) ref2scb;
  transaction trans_r;

  //Reference ram
  reg [7:0] mem [15:0];

  // Constructor
  function new(mailbox #(transaction)mon2ref, mailbox #(transaction)ref2scb);
    this.mon2ref =mon2ref;
    this.ref2scb =ref2scb;
  endfunction
/*+----------------------------------------------------------------------------------------+
  | TASK :run() :: Get Data from    Monitor using mailbox and call task ref_model()        |
  +----------------------------------------------------------------------------------------+*/ 
  task run();
    forever begin
      mon2ref.get(trans_r);
      ref_model();
      ref2scb.put(trans_r);
    end
  endtask
/*+----------------------------------------------------------------------------------------+
  | TASK :ref_model() :: Creat reference memory                                            |
  +----------------------------------------------------------------------------------------+*/ 
  task ref_model();
      if (trans_r.reset) begin
           for(int i = 0; i<16; i++)
              mem[i] = 8'b00000000;
           trans_r.rd_data = 8'b00000000;
           trans_r.kind = IDLE;
      end 
      else begin 
         if(trans_r.kind == WRITE ||trans_r.kind == SIM) begin
               mem[trans_r.wr_addr] <= trans_r.wr_data;
         end
         if (trans_r.kind == READ ||trans_r.kind == SIM) begin
               trans_r.rd_data <= mem[trans_r.rd_addr];
         end
      end
  endtask
endclass
`endif
