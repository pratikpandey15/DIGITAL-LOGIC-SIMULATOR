module comparator_tb;
    reg [3:0] a, b;
    wire eq, gt, lt;
    integer i, j;

    comparator_4bit dut (.a(a), .b(b), .eq(eq), .gt(gt), .lt(lt));

    initial begin
        $dumpfile("comparator_wave.vcd");
        $dumpvars(0, comparator_tb);
        for (i = 0; i < 16; i = i + 1) begin
            for (j = 0; j < 16; j = j + 1) begin
                a = i; b = j; #1;
                if ((a == b) && !eq) $display("FAIL eq");
                if ((a > b) && !gt) $display("FAIL gt");
                if ((a < b) && !lt) $display("FAIL lt");
            end
        end
        $display("COMPARATOR TEST COMPLETE");
        $finish;
    end
endmodule
