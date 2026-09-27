module decoder_tb;
    reg [1:0] in;
    wire [3:0] y;
    integer i;

    decoder_2to4 dut (.in(in), .y(y));

    initial begin
        $dumpfile("decoder_wave.vcd");
        $dumpvars(0, decoder_tb);
        for (i = 0; i < 4; i = i + 1) begin
            in = i[1:0];
            #1;
            $display("in=%b y=%b", in, y);
            if (i == 0 && y !== 4'b0001) $display("FAIL 00");
            if (i == 1 && y !== 4'b0010) $display("FAIL 01");
            if (i == 2 && y !== 4'b0100) $display("FAIL 10");
            if (i == 3 && y !== 4'b1000) $display("FAIL 11");
        end
        $display("DECODER TEST COMPLETE");
        $finish;
    end
endmodule
