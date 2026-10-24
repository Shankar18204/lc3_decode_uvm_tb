class decode_in_coverage extends uvm_subscriber #(decode_in_transaction);
    
    `uvm_component_utils(decode_in_coverage)

    decode_in_transaction tx;

    covergroup opcode_cg;
        option.per_instance = 1;
        
        cp_opcode: coverpoint tx.dout[15:12] {
            illegal_bins invalid_op = {4, 8, 13, 15}; 
            
            bins valid_ops[] = {0, 1, 2, 3, 5, 6, 7, 9, 10, 11, 12, 14}; 
        }
    endgroup

    function new(string name = "decode_in_coverage", uvm_component parent = null);
        super.new(name, parent);
        opcode_cg = new(); 
    endfunction

    virtual function void write(decode_in_transaction t);
        tx = t;

        opcode_cg.sample();
    endfunction

endclass
