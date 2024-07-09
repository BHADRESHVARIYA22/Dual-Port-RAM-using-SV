/////////////////////////////////////////////////////////////////////////////////////////////////////
// PROJECT NAME : Dual Port RAM
// FILE_NAME    : transaction.sv 
// AUTHOR       : Bhadresh.v
// MODULE NAME  : Enviroment
// DSCRIPTION   :  
// VERSION      :
// DATE         :
/////////////////////////////////////////////////////////////////////////////////////////////////////
`ifndef RAM_TRANS_SV
`define RAM_TRANS_SV
class transaction;
  randc trans_kind kind;
  randc bit [3:0] wr_addr;
  randc bit [7:0] wr_data;
  randc bit [3:0] rd_addr;
  bit [7:0] rd_data;
  static logic reset;
  static int count;  // Need to work on that
  
/*+----------------------------------------------------------------------------------------+
  |FUNCTION : display()  :: Print Trancation class member value                            |
  +----------------------------------------------------------------------------------------+*/ 
  function void display(string name,int x=0);
    $display("+-------------+---------------+");
    $display("|[%s] \t|Tnx No. :%0d\t|",name,count);
    $display("+-------------+---------------+");
    $display("|time : %0t\t| Mode : %s\t|",$time,kind);
    $display("|wr_addr : %0d\t| wd_data : %0d\t|",wr_addr,wr_data);
    $display("|rd_addr : %0d\t| rd_data : %0d\t|",rd_addr,rd_data);
    $display("+-------------+---------------+");
  endfunction
endclass
`endif
