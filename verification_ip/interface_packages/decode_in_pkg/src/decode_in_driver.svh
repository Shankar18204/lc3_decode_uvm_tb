class decode_in_driver extends uvm_driver #(decode_in_transaction);
    
    `uvm_component_utils(decode_in_driver)

    virtual decode_in_driverBFM vif;

    function new(string name = "decode_in_driver", uvm_component parent = null);
        super.new(name, parent);
    endfunction

    virtual function void build_phase(uvm_phase phase);
        super.build_phase(phase);
        if (vif == null) begin
            `uvm_info("DRV", "Virtual interface will be assigned by Agent Config", UVM_HIGH)
        end
    endfunction

    virtual task run_phase(uvm_phase phase);
        forever begin
            seq_item_port.get_next_item(req);
            vif.drive_data(req.dout, req.npc_in);

            seq_item_port.item_done();
        end
    endtask

endclass
