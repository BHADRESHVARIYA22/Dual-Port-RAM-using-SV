#makefile

RTL=../RTL/design.sv
PKG = ../ENV/package.sv
TOP=../TOP/top.sv
ENV_INC = +incdir+../ENV
TEST_INC = +incdir+../TEST
TOP_NAME=top
COMP_COV = -coveropt 3 +acc +cover
RUN_TER = -c -do "run -all; exit"
TC_0 = SANITY
TC_1 = READ
TC_2 = SIM
TC_3 = B2B
TC_4 = RST
COV_DIR_NAME = coverage_report
REPORT_NAME = merge_report


#runall:	merge html

reg: lib comp testx1 testx2 testx3 testx4 merge html


lib :
	vlib work

comp:
	vlog -coveropt 3 +acc +cover $(RTL) $(PKG) $(TOP) $(ENV_INC) $(TEST_INC)	


testx1:
	vsim -novopt -coverage $(TOP_NAME) -c -do "coverage save -onexit -directive -cvg -codeall $(TC_1).ucdb;run -all;exit" +$(TC_1)


testx2:
	vsim -novopt -coverage $(TOP_NAME) -c -do "coverage save -onexit -directive -cvg -codeall $(TC_2).ucdb;run -all;exit" +$(TC_2)
	
testx3:
	vsim -novopt -coverage $(TOP_NAME) -c -do "coverage save -onexit -directive -cvg -codeall $(TC_3).ucdb;run -all;exit" +$(TC_3)
	
testx4:
	vsim -novopt -coverage $(TOP_NAME) -c -do "coverage save -onexit -directive -cvg -codeall $(TC_4).ucdb;run -all;exit" +$(TC_4)

sim:
	vsim -vopt -coverage $(TOP_NAME) -c -do "coverage save -onexit -directive -cvg -codeall RAM_COV.ucdb;run -all;exit"

merge:
	vcover merge $(REPORT_NAME).ucdb $(TC_1).ucdb $(TC_2).ucdb $(TC_3).ucdb $(TC_4).ucdb	

html:
	vcover report -html -htmldir $(COV_DIR_NAME) $(REPORT_NAME).ucdb	
