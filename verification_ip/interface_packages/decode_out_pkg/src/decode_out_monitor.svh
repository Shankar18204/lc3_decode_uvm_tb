class decode_out_monitor extends uvm_monitor;
    `uvm_component_utils(decode_out_monitor)

    uvm_analysis_port #(decode_out_transaction) ap;
    virtual decode_out_monitorBFM vif;

    function new(string name = "decode_out_monitor", uvm_component parent = null);
        super.new(name, parent);
    endfunction

    virtual function void build_phase(uvm_phase phase);
        super.build_phase(phase);
        ap = new("ap", this);
    endfunction

    virtual function void connect_phase(uvm_phase phase);
        super.connect_phase(phase);
        vif.proxy = this;
    endfunction

    function void notify_transaction(decode_out_transaction tx);
        ap.write(tx);
    endfunction
endclass
