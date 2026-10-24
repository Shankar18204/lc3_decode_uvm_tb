module hvl_top;
    import uvm_pkg::*;
    `include "uvm_macros.svh"

    import decode_test_pkg::*;

    initial begin
        run_test("test_top");
    end
endmodule
