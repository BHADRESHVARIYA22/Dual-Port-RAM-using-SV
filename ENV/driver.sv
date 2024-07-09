/////////////////////////////////////////////////////////////////////////////////////////////////////
// PROJECT NAME : Dual Port RAM
// FILE_NAME    : driver.sv 
// AUTHOR       : Bhadresh.v
// MODULE NAME  : Class
// DSCRIPTION   : Get Data from Generator class Using Mailbox and drive into the DUT using Interface
//                convert data packet level to pin level  
/////////////////////////////////////////////////////////////////////////////////////////////////////
`ifndef RAM_DRV_SV
`define RAM_DRV_SV
class driver;
  transaction trans_d;              //Handle of trans class
  virtual intf.mod_drv vif;         //Handle of Virtual Intefcae
  mailbox #(transaction) gen2drv;   //Handle of mailbox
  event drv_done;                   //Handle of event
  int count;                        //Local Variable :: Used to cout no. of transaction sent to dut

  //Constructor 
  function new (virtual intf.mod_drv vif, mailbox #(transaction) gen2drv,event drv_done);  // Call from Env
    this.vif = vif;
    this.gen2drv = gen2drv;
    this.drv_done = drv_done;
  endfunction

/*+----------------------------------------------------------------------------------------+
  | TASK : run ()  :: Get Data from generator via mailbox and sent it to DUT using Interface |
  +----------------------------------------------------------------------------------------+*/
   task run();
    forever begin
      gen2drv.get(trans_d);
      drive();
      trans_d.display("DRIVER",count);
      count++;
      ->drv_done;                   // Event triggered
    end
  endtask 

/*+----------------------------------------------------------------------------------------+
  | TASK : drive ()  :: Transfer Data from trans to Virtual Interface w.r.t Control Signal |
  +----------------------------------------------------------------------------------------+*/
  task drive();
    @(vif.cb_drv);       // Every posedge of clk data will drive to interface from trans class
    case(trans_d.kind)   // Any one case will select as per trans.kind data
      WRITE: begin
        vif.cb_drv.wr_enb <= 1'b1;
        vif.cb_drv.rd_enb <= 1'b0;
        vif.cb_drv.wr_addr <= trans_d.wr_addr;
        vif.cb_drv.wr_data <= trans_d.wr_data;
      end
      READ: begin
        @(vif.cb_drv); 
        vif.cb_drv.wr_enb <= 1'b0;
        vif.cb_drv.rd_enb <= 1'b1;
        vif.cb_drv.rd_addr <= trans_d.rd_addr;
      end
      SIM: begin
        vif.cb_drv.wr_enb <= 1'b1;
        vif.cb_drv.rd_enb <= 1'b1;
        vif.cb_drv.wr_addr <= trans_d.wr_addr;
        vif.cb_drv.wr_data <= trans_d.wr_data;
        @(vif.cb_drv);                              // Next posdedge data address will drive
        vif.cb_drv.rd_addr <= trans_d.rd_addr;
      end
      IDLE: begin
        vif.cb_drv.wr_enb <= 1'b0;
        vif.cb_drv.rd_enb <= 1'b0;
      end
    endcase
  endtask
   endclass
`endif
































/*
class driver;
  //handle of trans class
  transaction trans_d;

  //handle of "gen2drv" mailbox 
  mailbox #(transaction) gen2drv;

  //virtual interface 
  virtual intf.mod_drv vif;
  //event wr_ack;

  function new (mailbox #(transaction) gen2drv, virtual intf.mod_drv vif);
    this.gen2drv=gen2drv;
    this.vif=vif;
  endfunction

  virtual task run();
     repeat(10) begin
     //  forever begin
        gen2drv.get(trans_d);           //Get transaction from gen
        $display("d : trans wr data : %0h",trans_d.wr_data);
        $display("d : trans wr addr : %0h",trans_d.wr_addr);
       // @(vif.cb_drv);
        send2dut();         //Send data from trans to vif
        $display("d : vif wr data : %0h",vif.wr_data);
        $display("d : vif wr addr : %0h",vif.wr_addr);
        ->wr_ack;
        trans_d.display("DRIVER");  // Display data
       end
    // end
  endtask

  task send2dut();
    vif.wr_enb <= ((trans_d.kind == 2'b11) || (trans_d.kind == 2'b10)) ? 1'b1 : 1'b0;
    vif.rd_enb <= ((trans_d.kind == 2'b11) || (trans_d.kind == 2'b01)) ? 1'b1 : 1'b0;
    vif.wr_addr <= trans_d.wr_addr;
    vif.wr_data <= trans_d.wr_data;
    vif.rd_addr <= trans_d.rd_addr;
  endtask
endclass */
