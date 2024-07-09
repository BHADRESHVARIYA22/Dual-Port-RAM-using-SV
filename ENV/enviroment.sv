/////////////////////////////////////////////////////////////////////////////////////////////////////
// PROJECT NAME : Dual Port RAM
// FILE_NAME    : enviroment.sv
// AUTHOR       : Bhadresh V.
// MODULE NAME  : Enviroment 
// DSCRIPTION   : It have Generator,Driver,monitor,reference and scoreboard class object
//                1) Create an object of all class and call the run() task parallel
/////////////////////////////////////////////////////////////////////////////////////////////////////
`ifndef RAM_ENV_SV
`define RAM_ENV_SV
class enviroment;
  virtual intf.mod_drv vif;     //Interface for Driver
  virtual intf.mod_mon vifm;    //Interface Monitor
  event drv_done;               // Event for handshake between generator and driver 

  //All TB componetn instance handle
   generator  gen;
   driver     drv;
   monitor    mon;
   reference  rex;
   scoreboard scb;

   // Mmailbox 
   mailbox #(transaction) gen2drv =new();   // Connect generator and Driver
   mailbox #(transaction) mon2ref =new();   // Connect Monitor and Driver
   mailbox #(transaction) mon2scb =new();   // Connect Monitor and Scoreboard
   mailbox #(transaction) ref2scb =new();   // Connect Ref_model and Scoreboard
 
 function new(virtual intf vif,virtual intf vifm);
   this.vif  = vif;
   this.vifm = vifm;
 endfunction
 /*+----------------------------------------------------------------------------------------------+
  | TASK : built()  :: Create an object of all enviroment member object and pass arg respectively |
  +-----------------------------------------------------------------------------------------------+*/
 function void built();
   // gen = new(gen2drv,drv_done);  // We can't creat gen class obj. because its virtual
   drv = new(vif,gen2drv,drv_done);
   mon = new(mon2scb,mon2ref,vifm);
   rex = new(mon2ref,ref2scb);
   scb = new(mon2scb,ref2scb);
 endfunction
 /*+---------------------------------------------------------------------------------------------------------------+
  | TASK : run()  :: Call the task run() of all object it will run parallel if any one finish than all are disable |
  +----------------------------------------------------------------------------------------------------------------+*/

 virtual task start();
   fork
     gen.run();
     drv.run();
     mon.run();
     rex.run();
     scb.run();
   join_any
   disable fork;
 endtask 
endclass
`endif
