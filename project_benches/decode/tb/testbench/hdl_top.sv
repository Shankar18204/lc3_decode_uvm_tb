module hdl_top;
    import uvm_pkg::*;
    `include "uvm_macros.svh"

    bit clock;
    bit reset;

    initial begin
        clock = 0;
        forever #10 clock = ~clock;
    end

    initial begin
        reset = 1;
        #25 reset = 0;
    end

    decode_in_if in_if(
        .clock(clock), 
        .reset(reset),
        .npc_in(), 
        .dout(), 
        .enable_decode()
    );

    decode_in_monitorBFM mon_bfm(in_if);
    decode_in_driverBFM drv_bfm(in_if);

   
    decode_out_if out_if(
        .clock(clock),
        .ir(),
        .npc_out(),
        .e_control(),
        .w_control(),
        .mem_control()
    );

    decode_out_monitorBFM out_mon_bfm(out_if);

   
    Decode dut (
        .clock(clock),
        .reset(reset),
        .npc_in(in_if.npc_in),
        .dout(in_if.dout),
        .enable_decode(in_if.enable_decode),
        .IR(out_if.ir),
        .npc_out(out_if.npc_out),
        .E_Control(out_if.e_control),
        .W_Control(out_if.w_control),
        .Mem_Control(out_if.mem_control)
    );

    
   
    initial begin
        uvm_config_db#(virtual decode_in_driverBFM)::set(null, "BFM", "decode_in_driverBFM", drv_bfm);
        uvm_config_db#(virtual decode_in_monitorBFM)::set(null, "BFM", "decode_in_monitorBFM", mon_bfm);
        uvm_config_db#(virtual decode_out_monitorBFM)::set(null, "BFM", "decode_out_monitorBFM", out_mon_bfm);
        
        //setting both string paths just in case
        uvm_config_db#(virtual decode_in_driverBFM)::set(null, "*", "decode_in_if", drv_bfm);
        uvm_config_db#(virtual decode_in_monitorBFM)::set(null, "*", "decode_in_if", mon_bfm);
        uvm_config_db#(virtual decode_out_monitorBFM)::set(null, "*", "decode_out_if", out_mon_bfm);
    end

endmodule
