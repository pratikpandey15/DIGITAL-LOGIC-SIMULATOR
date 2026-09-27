module d_ff_tb;
    reg clk, rst, d;
    wire q;

    d_ff dut (.clk(clk), .rst(rst), .d(d), .q(q));

    always #5 clk = ~clk;

    initial begin
        $dumpfile("d_ff_wave.vcd");
        $dumpvars(0, d_ff_tb);
        clk = 0; rst = 0; d = 0;
        #2 rst = 1; #10 rst = 0;
        #5 d = 1; #10 d = 0; #10 d = 1;
        #20;
        $display("D FLIP-FLOP TEST COMPLETE");
        $finish;
    end
endmodule
