class decode_predictor extends uvm_subscriber #(decode_in_transaction);
    `uvm_component_utils(decode_predictor)

    uvm_analysis_port #(decode_out_transaction) ap;

    function new(string name = "decode_predictor", uvm_component parent = null);
        super.new(name, parent);
    endfunction

    virtual function void build_phase(uvm_phase phase);
        super.build_phase(phase);
        ap = new("ap", this);
    endfunction

    virtual function void write(decode_in_transaction t);
        decode_out_transaction expected_tx;
        bit status;
        
        expected_tx = decode_out_transaction::type_id::create("expected_tx");

      
        status = decode_model(
            t.dout,                 // input: instr_dout
            t.npc_in,               // input: npc_in
            expected_tx.ir,         // output: ir
            expected_tx.npc_out,    // output: npc_out
            expected_tx.e_control,  // output: e_control
            expected_tx.w_control,  // output: w_control
            expected_tx.mem_control // output: mem_control
        );

        ap.write(expected_tx);
    endfunction

endclass
