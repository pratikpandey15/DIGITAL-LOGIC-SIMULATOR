module gates_tb;
    reg a, b;
    wire and_out, or_out, not_out, nand_out, nor_out, xor_out, xnor_out, buffer_out;

    and_gate uut_and (.a(a), .b(b), .y(and_out));
    or_gate uut_or (.a(a), .b(b), .y(or_out));
    not_gate uut_not (.a(a), .y(not_out));
    nand_gate uut_nand (.a(a), .b(b), .y(nand_out));
    nor_gate uut_nor (.a(a), .b(b), .y(nor_out));
    xor_gate uut_xor (.a(a), .b(b), .y(xor_out));
    xnor_gate uut_xnor (.a(a), .b(b), .y(xnor_out));
    buffer_gate uut_buf (.a(a), .y(buffer_out));

    initial begin
        $dumpfile("gates_wave.vcd");
        $dumpvars(0, gates_tb);
        a = 1'b0; b = 1'b0;
        #5 a = 1'b0; b = 1'b1;
        #5 a = 1'b1; b = 1'b0;
        #5 a = 1'b1; b = 1'b1;
        #5;
        $display("GATES TEST COMPLETE");
        $finish;
    end

endmodule
