class decode_env_configuration extends uvm_object;
    `uvm_object_utils(decode_env_configuration)

    decode_in_configuration in_config;
    decode_out_configuration out_config; 

    function new(string name = "decode_env_configuration");
        super.new(name);
    endfunction

    function void initialize(uvm_component parent, string in_if_name, string out_if_name, uvm_active_passive_enum in_activity, uvm_active_passive_enum out_activity);
        
        in_config = decode_in_configuration::type_id::create("in_config");
        in_config.initialize(parent, {parent.get_full_name(), ".in_agent"}, in_if_name, in_activity);

       
           out_config = decode_out_configuration::type_id::create("out_config");
           out_config.initialize(parent, {parent.get_full_name(), ".out_agent"}, out_if_name, out_activity);
    endfunction
endclass
