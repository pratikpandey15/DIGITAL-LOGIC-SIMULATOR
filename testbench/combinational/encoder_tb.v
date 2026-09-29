module encoder_tb;
    reg [3:0] in;
    wire [1:0] out;
    wire valid;

    encoder_4to2 dut (.in(in), .out(out), .valid(valid));

    initial begin
        $dumpfile("encoder_wave.vcd");
        $dumpvars(0, encoder_tb);

        for (in = 0; in < 16; in = in + 1) begin
            #1;
            if (in == 4'b0001 && !(out === 2'b00 && valid === 1'b1)) $display("FAIL 0001");
            if (in == 4'b0010 && !(out === 2'b01 && valid === 1'b1)) $display("FAIL 0010");
            if (in == 4'b0100 && !(out === 2'b10 && valid === 1'b1)) $display("FAIL 0100");
            if (in == 4'b1000 && !(out === 2'b11 && valid === 1'b1)) $display("FAIL 1000");
            if (in == 4'b0000 && !(valid === 1'b0)) $display("FAIL 0000");
        end

        $display("ENCODER TEST COMPLETE");
        $finish;
    end
endmodule
