interface decode_out_monitorBFM(decode_out_if dif);
    import decode_out_pkg::*;
    decode_out_monitor proxy;

  
    logic delayed_enable;

    always @(posedge dif.clock) begin
       
        delayed_enable <= hdl_top.in_if.enable_decode;

        if (delayed_enable === 1'b1) begin
            decode_out_transaction tx;
            tx = decode_out_transaction::type_id::create("tx");
            tx.ir = dif.ir;
            tx.npc_out = dif.npc_out;
            tx.e_control = dif.e_control;
            tx.w_control = dif.w_control;
            tx.mem_control = dif.mem_control;

            if (proxy != null) begin
                proxy.notify_transaction(tx);
            end
        end
    end
endinterface
