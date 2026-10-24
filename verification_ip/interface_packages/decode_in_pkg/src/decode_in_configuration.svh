class decode_in_configuration extends uvm_object;
    
    `uvm_object_utils(decode_in_configuration)

    virtual decode_in_driverBFM driverBFM;
    virtual decode_in_monitorBFM monitorBFM;
	
    uvm_active_passive_enum active; 	
    
    uvm_sequencer #(decode_in_transaction) sequencer;

    function new(string name = "decode_in_configuration");
        super.new(name);
    endfunction

    function void initialize(uvm_component parent, string path, string if_name, uvm_active_passive_enum activity);
	active = activity;

	if (!uvm_config_db #(virtual decode_in_driverBFM)::get(null, "BFM", "decode_in_driverBFM", driverBFM)) begin
		`uvm_error("CONFIG", "Failed to retrieve Driver BFM from database!")
	end

	if (!uvm_config_db #(virtual decode_in_monitorBFM)::get(null, "BFM", "decode_in_monitorBFM", monitorBFM)) begin
            `uvm_error("CONFIG", "Failed to retrieve Monitor BFM from database!")
        end
    endfunction

    virtual function string convert2string();
        return $sformatf("decode_in_configuration: Driver BFM is %s, Monitor BFM is %s",
			(driverBFM == null) ? "NOT CONNECTED" : "CONNECTED", 
                         (monitorBFM == null) ? "NOT CONNECTED" : "CONNECTED");
    endfunction

endclass
