class decode_out_transaction extends uvm_transaction;
    `uvm_object_utils(decode_out_transaction)

    bit [15:0] ir;
    bit [15:0] npc_out;
    bit [5:0]  e_control;
    bit [1:0]  w_control;
    bit        mem_control;

    function new(string name = "");
        super.new(name);
    endfunction

    virtual function bit compare(decode_out_transaction rhs);
        if (rhs == null) return 0;
        return ((this.ir == rhs.ir) &&
                (this.npc_out == rhs.npc_out) &&
                (this.e_control == rhs.e_control) &&
                (this.w_control == rhs.w_control) &&
                (this.mem_control == rhs.mem_control));
    endfunction

    virtual function string convert2string();
        return $sformatf("ir:%h npc:%h e:%b w:%b mem:%b", ir, npc_out, e_control, w_control, mem_control);
    endfunction
endclass
