class decode_environment extends uvm_env;
    `uvm_component_utils(decode_environment)

    decode_env_configuration env_config;

    decode_in_agent in_agent;
    decode_out_agent out_agent;
    
    decode_predictor predictor;
    decode_scoreboard scoreboard;

    function new(string name = "decode_environment", uvm_component parent = null);
        super.new(name, parent);
    endfunction

    virtual function void build_phase(uvm_phase phase);
        super.build_phase(phase);

        if (!uvm_config_db #(decode_env_configuration)::get(this, "", "config", env_config)) begin
            `uvm_fatal("ENV", "Failed to retrieve environment configuration")
        end

     
        uvm_config_db #(decode_in_configuration)::set(this, "in_agent*", "config", env_config.in_config);
        uvm_config_db #(decode_out_configuration)::set(this, "out_agent*", "config", env_config.out_config);

       
        in_agent   = decode_in_agent::type_id::create("in_agent", this);
        out_agent  = decode_out_agent::type_id::create("out_agent", this);
        predictor  = decode_predictor::type_id::create("predictor", this);
        scoreboard = decode_scoreboard::type_id::create("scoreboard", this);
    endfunction

    virtual function void connect_phase(uvm_phase phase);
        super.connect_phase(phase);

        in_agent.monitor.ap.connect(predictor.analysis_export);

       
        predictor.ap.connect(scoreboard.expected_export);
        out_agent.monitor.ap.connect(scoreboard.actual_export);
    endfunction

endclass
