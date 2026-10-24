interface decode_in_monitorBFM(decode_in_if dif);
    import uvm_pkg::*;
    import decode_in_pkg::*;

    decode_in_monitor proxy;

    always@(posedge dif.clock) begin
        if(dif.enable_decode === 1'b1) begin
            if (proxy != null) begin
                proxy.notify_transaction(dif.dout, dif.npc_in);
            end
        end
    end
endinterface
