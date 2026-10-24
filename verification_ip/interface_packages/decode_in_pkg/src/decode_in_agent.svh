class decode_in_agent extends uvm_agent;
    
    `uvm_component_utils(decode_in_agent)

    // Sub-components
    decode_in_configuration                config_obj;
    uvm_sequencer #(decode_in_transaction) sequencer;
    decode_in_driver                       driver;
    decode_in_monitor                      monitor;
    decode_in_coverage                     coverage;

    uvm_analysis_port #(decode_in_transaction) ap;

    function new(string name = "decode_in_agent", uvm_component parent = null);
        super.new(name, parent);
    endfunction

    virtual function void build_phase(uvm_phase phase);
        super.build_phase(phase);

        if (!uvm_config_db #(decode_in_configuration)::get(this, "", "config", config_obj)) begin
            `uvm_fatal("AGENT", "Failed to retrieve decode_in_configuration from database!")
        end
        
        `uvm_info("AGENT", config_obj.convert2string(), UVM_LOW)

	ap = new("ap", this);

       if(get_is_active() == UVM_ACTIVE) begin 
        sequencer = uvm_sequencer#(decode_in_transaction)::type_id::create("sequencer", this);
        driver    = decode_in_driver::type_id::create("driver", this);
        driver.vif = config_obj.driverBFM;
	end

	config_obj.sequencer = sequencer;
        
	monitor   = decode_in_monitor::type_id::create("monitor", this);
        coverage  = decode_in_coverage::type_id::create("coverage", this);

        monitor.vif = config_obj.monitorBFM;
    endfunction

    virtual function void connect_phase(uvm_phase phase);
        super.connect_phase(phase);
        
        if(get_is_active() == UVM_ACTIVE) begin
        driver.seq_item_port.connect(sequencer.seq_item_export);
        end
        
        monitor.ap.connect(coverage.analysis_export);

	monitor.ap.connect(this.ap);
    endfunction

endclass
