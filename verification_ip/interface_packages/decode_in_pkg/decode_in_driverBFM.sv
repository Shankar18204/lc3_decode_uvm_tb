interface decode_in_driverBFM(decode_in_if dif);

    import uvm_pkg::*;

    logic [15:0] internal_dout; 
    logic [15:0] internal_npc;
    logic        internal_enable_decode;

    assign dif.dout = internal_dout;
    assign dif.npc_in  = internal_npc;
    assign dif.enable_decode = internal_enable_decode;

    task drive_data(input bit [15:0] dout_val, input bit [15:0] npc_val);
	@(posedge dif.clock);

	internal_enable_decode = 1'b1;
	internal_dout = dout_val;
	internal_npc  = npc_val;
 
	@(posedge dif.clock);
	internal_enable_decode = 1'b0;
    endtask
endinterface

