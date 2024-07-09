/////////////////////////////////////////////////////////////////////////////////////////////////////
// PROJECT NAME : Dual Port RAM
// FILE_NAME    : coverage.sv
// AUTHOR       : Bhadresh V.
// MODULE NAME  : Coverage 
// DSCRIPTION   : 
//        
// VERSION      :
// DATE         :
/////////////////////////////////////////////////////////////////////////////////////////////////////
`ifndef RAM_COV_SV
`define RAM_COV_SV
class coverage;
 //Hanlde of transaction class
 transaction trans_c;

 covergroup cvg;
    option.comment = "CG : cvg";
    // COVER POINT FOR WR_ADDR
        WR_ADDR_CP : coverpoint trans_c.wr_addr {
        option.comment = "CP : WR_ADDR";
                bins first_wra = {4'h0};
                bins low_wra = {[4'h0:4'h4]};
                bins mid_wra = {[4'h5:4'ha]};
                bins high_wra= {[4'hb:4'he]};
                bins last_wra  = {4'hf};
            }
    // COVER POINT FOR RD_ADDD
        RD_ADDR_CP : coverpoint trans_c.rd_addr {
        option.comment = "CP : RD_ADDR";
                bins first_rda = {4'h0};
                bins low_rda = {[4'h0:4'h4]};
                bins mid_rda = {[4'h5:4'ha]};
                bins high_rda = {[4'hb:4'he]};
                bins last_rda  = {4'hf};
            }
  // COVER POINT FOR WR_DATA
        WR_DATA_CP : coverpoint trans_c.wr_data {
        option.comment = "CP : WR_DATA";
                bins first_wrd = {8'h0};
                bins low_wrd = {[8'h0:8'h55]};
                bins mid_wrd = {[8'h56:8'ha1]};
                bins high_wrd= {[8'ha2:8'hfe]};
                bins last_wrd  = {8'hff};
            }
  // COVER POINT FOR KIND
        KIND_CP : coverpoint trans_c.kind {
        option.comment = "CP  : KIND";
              bins wr_cb = {WRITE};
              bins rd_cb = {READ};
              bins sim_cb = {SIM};
              bins b2b_cb = (WRITE => READ => WRITE => READ);
            }
  // RESET
       RESET_CP : coverpoint trans_c.reset{
       option.comment = "CP : RESET";
             bins rst_b2b = (0 => 1 =>0 =>1);
             bins rst1 = {1};
             bins rst0 = {0};
            }

  // RD_DATA
       RD_DATA_CP : coverpoint trans_c.rd_data {
       option.comment = "CP : RD_DATA";
                bins first_rd = {8'h0};
                bins low_rd = {[8'h0:8'h55]};
                bins mid_rd = {[8'h56:8'ha1]};
                bins high_rd= {[8'ha2:8'hfe]};
                bins last_rd  = {8'hff};

       }
   //COSS KIND with WR_ADDR & WR_DATA
       CXWR    : cross KIND_CP,WR_DATA_CP,WR_ADDR_CP{
             option.comment = "CP : CX_WR";
             ignore_bins b1 = binsof(KIND_CP.b2b_cb);
             ignore_bins b2 = binsof(KIND_CP.rd_cb);
            }
   //CROSS KIND with RD_ADDR & RD_DATA
      CXRD    : cross KIND_CP,RD_DATA_CP,RD_ADDR_CP{
           option.comment = "CP : CX_RD";
           ignore_bins bx1 = binsof(KIND_CP.b2b_cb);
           ignore_bins bx2 = binsof(KIND_CP.wr_cb);
            }
  endgroup
/*+----------------------------------------------------------------------------------------+
  | TASK : put_covg ()  :: Get data from scoreboard and sample it for coverage             |
  +----------------------------------------------------------------------------------------+*/
  task put_covg(transaction transx);
    this.trans_c = transx;
    cvg.sample();
    $display("Coverage = %f",cvg.get_coverage());
  endtask

    function new();
      this.cvg = new();
    endfunction
endclass
`endif


