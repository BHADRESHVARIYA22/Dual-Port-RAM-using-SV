vlog ../RTL/design.sv ../TEST/package.sv ../TOP/top.sv +incdir+../ENV +incdir+../TEST

vsim -voptargs=+acc top -c -do "run -all; exit" +RST_DATA

add wave -position insertpoint  \
sim:/top/dut/clk \
sim:/top/dut/rst \
sim:/top/dut/wr_enb \
sim:/top/dut/rd_enb \
sim:/top/dut/wr_addr \
sim:/top/dut/rd_addr \
sim:/top/dut/wr_data \
sim:/top/dut/rd_data \
sim:/top/dut/i \
sim:/top/dut/ram

restart
run -all
