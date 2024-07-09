/////////////////////////////////////////////////////////////////////////////////////////////////////
// PROJECT NAME : Dual Port RAM
// FILE_NAME    : test.sv
// AUTHOR       : Bhadresh.v
// MODULE NAME  : Test case
// DSCRIPTION   :
// VERSION      :
// DATE         :
/////////////////////////////////////////////////////////////////////////////////////////////////////
`ifndef RAM_TEST_SV
`define RAM_TEST_SV
class test;
  enviroment env;
  virtual intf.mod_drv vif;
  virtual intf vifm;

  // Test case handles
  sanity_txn sanity_h;
  read_txn read_h;
  sim_txn sim_h;
  b2b_txn b2b_h;
  rst_txn rst_h;

  function new (virtual intf.mod_drv vif, virtual intf.mod_mon vifm);
    this.vif = vif;
    this.vifm = vifm;
  endfunction

  task run();
    env = new (vif,vifm);
    //Test cases
    if($test$plusargs("SANITY"))begin
        sanity_h = new(env.gen2drv,env.drv_done);
        env.gen = sanity_h;
    end
    if($test$plusargs("RST"))begin
        rst_h = new(env.gen2drv,env.drv_done);
        env.gen = rst_h;
    end
    if($test$plusargs("READ"))begin
        read_h = new(env.gen2drv,env.drv_done);
        env.gen = read_h;
    end
    if($test$plusargs("SIM"))begin
        sim_h = new(env.gen2drv,env.drv_done);
        env.gen = sim_h;
    end
    if($test$plusargs("B2B"))begin
        b2b_h = new(env.gen2drv,env.drv_done);
        env.gen = b2b_h;
    end
    env.built();
    env.start();
    $finish;
  endtask
endclass
`endif
