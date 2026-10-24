class decode_in_transaction extends uvm_sequence_item;
    `uvm_object_utils(decode_in_transaction)

    
    rand bit [15:0] dout;
    rand bit [15:0] npc_in;

    constraint valid_opcode_c {
        dout[15:12] inside {4'h0, 4'h1, 4'h2, 4'h3, 4'h5, 4'h6, 4'h7, 4'h9, 4'hA, 4'hB, 4'hC, 4'hE};
    }

    function new(string name = "decode_in_transaction");
        super.new(name);
    endfunction

    virtual function string convert2string();
        return $sformatf("INSTR: 16'h%04x (Opcode: 4'b%04b) | NPC_IN: 16'h%04x", 
                          dout, dout[15:12], npc_in);
    endfunction

    virtual function void wave_view(int transaction_viewing_stream_h);
        int transaction_view_h; 
        
        `uvm_info("[WAVE_VIEW]", $sformatf("Transaction: %s", convert2string()), UVM_HIGH)
        
        transaction_view_h = $begin_transaction(transaction_viewing_stream_h, "decode_in_transaction", $realtime);
	$add_attribute(transaction_view_h, dout, "dout");
        $add_attribute(transaction_view_h, npc_in, "npc_in");
        
        $end_transaction(transaction_view_h, $realtime);
	$free_transaction(transaction_view_h);
    endfunction

endclass
