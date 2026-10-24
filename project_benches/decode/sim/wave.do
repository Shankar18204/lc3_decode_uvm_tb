# wave.do

# 1. Add the physical hardware pins to verify the raw data
add wave -noupdate /hdl_top/in_if/*

# 2. Add the UVM transaction stream you just created in decode_in_monitor.sv
# (The path maps to test_top -> agent -> monitor -> txn_stream)
add wave -noupdate /uvm_root/uvm_test_top/env/in_agent/monitor/txn_stream

# 3. Optional: auto-fit the waveform view
WaveRestoreZoom {0 ns} {1000 ns}
