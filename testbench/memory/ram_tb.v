module ram_tb;
    reg clk, write_en;
    reg [2:0] addr;
    reg [3:0] data_in;
    wire [3:0] data_out;

    ram_8x4 dut (.clk(clk), .write_en(write_en), .addr(addr), .data_in(data_in), .data_out(data_out));

    always #5 clk = ~clk;

    initial begin
        $dumpfile("ram_wave.vcd");
        $dumpvars(0, ram_tb);
        clk = 0; write_en = 0; addr = 3'b000; data_in = 4'b0000;
        #10; write_en = 1; data_in = 4'b1010; addr = 3'b001; #10;
        write_en = 0; addr = 3'b001; #10;
        write_en = 1; data_in = 4'b0110; addr = 3'b010; #10;
        $display("RAM TEST COMPLETE");
        $finish;
    end
endmodule
