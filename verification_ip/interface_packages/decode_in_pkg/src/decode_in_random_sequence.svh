class decode_in_random_sequence extends uvm_sequence #(decode_in_transaction);
    
    `uvm_object_utils(decode_in_random_sequence)

    function new(string name = "decode_in_random_sequence");
        super.new(name);
    endfunction

    virtual task body();
        decode_in_transaction req;
        
        repeat(50) begin
            req = decode_in_transaction::type_id::create("req");
            
            start_item(req);
            
            if (!req.randomize()) begin
                `uvm_fatal("SEQ", "Transaction randomization failed!")
            end
            
            `uvm_info("SEQ", {"Sending: ", req.convert2string()}, UVM_MEDIUM)
            finish_item(req);
        end
    endtask

endclass
