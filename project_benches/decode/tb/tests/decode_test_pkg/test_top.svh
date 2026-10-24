class test_top extends uvm_test;
    `uvm_component_utils(test_top)

    decode_environment env;
    decode_env_configuration   env_config;
    decode_in_random_sequence seq;

    function new(string name = "test_top", uvm_component parent = null);
        super.new(name, parent);
    endfunction

    virtual function void build_phase(uvm_phase phase);
        super.build_phase(phase);

	env_config = decode_env_configuration::type_id::create("env_config");
	env_config.initialize(this, "decode_in_if", "decode_out_if", UVM_ACTIVE, UVM_PASSIVE);
     
        //config_obj = decode_in_configuration::type_id::create("config_obj");


        uvm_config_db #(decode_env_configuration)::set(this, "*", "config", env_config);

        //agent = decode_in_agent::type_id::create("agent", this);

	   env = decode_environment::type_id::create("env", this);
    endfunction

    virtual task run_phase(uvm_phase phase);
        seq = decode_in_random_sequence::type_id::create("seq");
        
        phase.raise_objection(this, "Starting Sequence");
        seq.start(env.in_agent.sequencer);

	#50;

        phase.drop_objection(this, "Finished Sequence");
    endtask
endclass
