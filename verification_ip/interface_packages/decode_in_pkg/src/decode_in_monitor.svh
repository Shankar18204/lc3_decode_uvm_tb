class decode_in_monitor extends uvm_monitor;
    
    `uvm_component_utils(decode_in_monitor)

    
    uvm_analysis_port #(decode_in_transaction) ap;
	
	
    int txn_stream;

    
    virtual function void start_of_simulation_phase(uvm_phase phase);
        super.start_of_simulation_phase(phase);
        
        
	txn_stream = $create_transaction_stream({"..", get_full_name(), ".", "txn_stream"}, "TVM");
    endfunction

   
    virtual decode_in_monitorBFM vif;

    function new(string name = "decode_in_monitor", uvm_component parent = null);
        super.new(name, parent);
    endfunction

    virtual function void build_phase(uvm_phase phase);
        super.build_phase(phase);
        ap = new("ap", this);
        if (vif == null) begin
            `uvm_info("MON", "Virtual interface will be assigned by Agent Config", UVM_HIGH)
        end
    endfunction

     virtual function void connect_phase(uvm_phase phase);
	super.connect_phase(phase);
	vif.proxy = this;
     endfunction

     function void notify_transaction(logic [15:0] observed_dout, logic [15:0] observed_npc);
	decode_in_transaction tx;
	
	int txn_id;

	tx = decode_in_transaction::type_id::create("tx");
	tx.dout = observed_dout;
	tx.npc_in = observed_npc;

	txn_id = $begin_transaction(txn_stream, "Decode_Txn");
	tx.wave_view(txn_stream);
	
	$end_transaction(txn_id, tx);
	ap.write(tx);
     endfunction

endclass
