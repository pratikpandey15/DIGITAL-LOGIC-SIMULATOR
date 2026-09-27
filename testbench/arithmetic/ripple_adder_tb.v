module ripple_adder_tb;
    reg [3:0] a, b;
    reg cin;
    wire [3:0] sum;
    wire cout;

    ripple_carry_adder dut (.a(a), .b(b), .cin(cin), .sum(sum), .cout(cout));

    initial begin
        $dumpfile("ripple_adder_wave.vcd");
        $dumpvars(0, ripple_adder_tb);

        a = 4'b0000; b = 4'b0000; cin = 1'b0; #1;
        a = 4'b0101; b = 4'b0011; cin = 1'b0; #1;
        a = 4'b1111; b = 4'b0001; cin = 1'b0; #1;
        a = 4'b1010; b = 4'b0101; cin = 1'b1; #1;

        $display("RIPPLE ADDER TEST COMPLETE");
        $finish;
    end
endmodule
