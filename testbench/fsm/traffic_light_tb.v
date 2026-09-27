module traffic_light_tb;
    reg clk, rst;
    wire [2:0] lights;

    traffic_light_controller dut (.clk(clk), .rst(rst), .lights(lights));

    always #5 clk = ~clk;

    initial begin
        $dumpfile("traffic_light_wave.vcd");
        $dumpvars(0, traffic_light_tb);
        clk = 0; rst = 0;
        #2 rst = 1; #12 rst = 0;
        #60;
        $display("TRAFFIC LIGHT TEST COMPLETE");
        $finish;
    end
endmodule
