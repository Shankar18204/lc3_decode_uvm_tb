class decode_out_agent extends uvm_agent;
    `uvm_component_utils(decode_out_agent)

    decode_out_configuration config_obj;
    decode_out_monitor monitor;

    function new(string name = "decode_out_agent", uvm_component parent = null);
        super.new(name, parent);
    endfunction

    virtual function void build_phase(uvm_phase phase);
        super.build_phase(phase);
        if (!uvm_config_db #(decode_out_configuration)::get(this, "", "config", config_obj)) begin
            `uvm_fatal("AGENT", "Failed to get config")
        end
        
        monitor = decode_out_monitor::type_id::create("monitor", this);
        
      
        monitor.vif = config_obj.monitorBFM;
    endfunction

    virtual function void connect_phase(uvm_phase phase);
        super.connect_phase(phase);
    endfunction
endclass
