# Directory Variables
VERIF_IP = ../../../verification_ip/interface_packages/decode_in_pkg
OUT_PKG	 = ../../../verification_ip/interface_packages/decode_out_pkg
LC3_PKG  = ../../../verification_ip/environment_packages/lc3_prediction_pkg
TEST_PKG = ../tb/tests/decode_test_pkg
TB       = ../tb/testbench
ENV_PKG  = ../../../verification_ip/environment_packages/decode_env_pkg
RTL	 = ../rtl

# Target changed to p1_debug as required by Slide 6
p1_debug: clean
	qrun -64 -gui -coverage -onfinish stop -classdebug -uvmcontrol=all -msgmode both -l run.log \
	+incdir+$(VERIF_IP) $(VERIF_IP)/decode_in_pkg.sv \
	+incdir+$(TEST_PKG) $(TEST_PKG)/decode_test_pkg.sv \
	$(VERIF_IP)/decode_in_if.sv \
	$(VERIF_IP)/decode_in_driverBFM.sv \
	$(VERIF_IP)/decode_in_monitorBFM.sv \
	$(TB)/hdl_top.sv \
	$(TB)/hvl_top.sv \
	-do "set IterationLimit 140000; set NoQuitOnFinish 1; run 0; do wave.do; run -a;" \
	+UVM_TESTNAME=test_top \
	-top hvl_top -top hdl_top

# New Project 2 Target
p2_debug: clean
	qrun -64 -gui -coverage -onfinish stop -classdebug -uvmcontrol=all -msgmode both -l run_p2.log \
	+incdir+$(VERIF_IP) $(VERIF_IP)/decode_in_pkg.sv \
	+incdir+$(OUT_PKG) $(OUT_PKG)/decode_out_pkg.sv \
	+incdir+$(LC3_PKG) $(LC3_PKG)/lc3_prediction_pkg.sv \
	+incdir+$(ENV_PKG) $(ENV_PKG)/decode_env_pkg.sv \
	+incdir+$(TEST_PKG) $(TEST_PKG)/decode_test_pkg.sv \
	$(VERIF_IP)/decode_in_if.sv \
	$(OUT_PKG)/decode_out_if.sv \
	$(VERIF_IP)/decode_in_driverBFM.sv \
	$(VERIF_IP)/decode_in_monitorBFM.sv \
	$(OUT_PKG)/decode_out_monitorBFM.sv \
	$(RTL)/data_defs.v \
	$(RTL)/Decode_Pipelined.v \
	$(TB)/hdl_top.sv \
	$(TB)/hvl_top.sv \
	-do "set IterationLimit 140000; set NoQuitOnFinish 1; run 0; do wave.do; run -a;" \
	+UVM_TESTNAME=test_top \
	-top hvl_top -top hdl_top

clean:
	rm -f certe_dump.xml design.bin qwave.db run.log run_p2.log transaction.config transcript vsim.wlf modelsim.ini
	rm -rf qrun.out .visualizer work
