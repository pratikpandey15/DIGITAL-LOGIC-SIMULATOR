module demux_tb;
    reg in, sel;
    wire [1:0] y;

    demux_1to2 dut (.in(in), .sel(sel), .y(y));

    initial begin
        $dumpfile("demux_wave.vcd");
        $dumpvars(0, demux_tb);

        in = 1'b1; sel = 1'b0; #1;
        if (y !== 2'b01) $display("FAIL sel=0, in=1 -> y=%b", y);

        in = 1'b1; sel = 1'b1; #1;
        if (y !== 2'b10) $display("FAIL sel=1, in=1 -> y=%b", y);

        in = 1'b0; sel = 1'b0; #1;
        if (y !== 2'b00) $display("FAIL sel=0, in=0 -> y=%b", y);

        $display("DEMUX TEST COMPLETE");
        $finish;
    end
endmodule
