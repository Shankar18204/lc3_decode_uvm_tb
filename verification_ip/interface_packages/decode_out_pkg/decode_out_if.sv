interface decode_out_if(
    input bit clock,
    inout wire [15:0] ir,
    inout wire [15:0] npc_out,
    inout wire [5:0]  e_control,
    inout wire [1:0]  w_control,
    inout wire        mem_control
);
endinterface
