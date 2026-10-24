class decode_out_configuration extends uvm_object;
    `uvm_object_utils(decode_out_configuration)

    virtual decode_out_monitorBFM monitorBFM;
    uvm_active_passive_enum active = UVM_PASSIVE; // Output agent is always passive

    function new(string name = "decode_out_configuration");
        super.new(name);
    endfunction

    function void initialize(uvm_component parent, string path, string if_name, uvm_active_passive_enum activity);
        active = activity;
        if (!uvm_config_db #(virtual decode_out_monitorBFM)::get(null, "BFM", "decode_out_monitorBFM", monitorBFM)) begin
            `uvm_error("CONFIG", "Failed to retrieve decode_out_monitorBFM from database")
        end
    endfunction
endclass
