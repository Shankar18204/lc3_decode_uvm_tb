`uvm_analysis_imp_decl(_expected)
`uvm_analysis_imp_decl(_actual)

class decode_scoreboard extends uvm_component;
    `uvm_component_utils(decode_scoreboard)

    uvm_analysis_imp_expected #(decode_out_transaction, decode_scoreboard) expected_export;
    uvm_analysis_imp_actual   #(decode_out_transaction, decode_scoreboard) actual_export;

    decode_out_transaction expected_q[$];

    int expected_count;
    int compare_count;

    function new(string name = "decode_scoreboard", uvm_component parent = null);
        super.new(name, parent);
        expected_count = 0;
        compare_count = 0;
    endfunction

    virtual function void build_phase(uvm_phase phase);
        super.build_phase(phase);
        expected_export = new("expected_export", this);
        actual_export   = new("actual_export", this);
    endfunction

    virtual function void write_expected(decode_out_transaction t);
        expected_q.push_back(t);
        expected_count++;
    endfunction

    virtual function void write_actual(decode_out_transaction actual_t);
        decode_out_transaction expected_t;

        if (expected_q.size() == 0) begin
            `uvm_error("SCOREBOARD", "Received actual transaction but expected queue is empty!")
            return;
        end

        expected_t = expected_q.pop_front();

        if (actual_t.compare(expected_t)) begin
            `uvm_info("SCOREBOARD", "Transaction Match!", UVM_MEDIUM)
        end else begin
            `uvm_error("SCOREBOARD", $sformatf("Transaction Mismatch! Expected: %s, Actual: %s", expected_t.convert2string(), actual_t.convert2string()))
        end

        compare_count++;
    endfunction

    virtual function void report_phase(uvm_phase phase);
        super.report_phase(phase);
        `uvm_info("SCOREBOARD_REPORT", "-----------------------------------------", UVM_LOW)
        `uvm_info("SCOREBOARD_REPORT", $sformatf("Expected Transactions Received : %0d", expected_count), UVM_LOW)
        `uvm_info("SCOREBOARD_REPORT", $sformatf("Total Comparisons Made         : %0d", compare_count), UVM_LOW)
        `uvm_info("SCOREBOARD_REPORT", "-----------------------------------------", UVM_LOW)
    endfunction

endclass
