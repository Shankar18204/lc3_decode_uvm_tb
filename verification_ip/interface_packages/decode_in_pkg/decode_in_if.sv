interface decode_in_if(
     input bit clock,
     input bit reset,
     inout tri enable_decode,
     inout tri [15:0] dout,
     inout tri [15:0] npc_in
);

endinterface
