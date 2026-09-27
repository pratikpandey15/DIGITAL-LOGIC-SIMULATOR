module full_adder_tb;
    reg a, b, cin;
    wire sum, cout;
    integer tests, passed;

    full_adder dut (.a(a), .b(b), .cin(cin), .sum(sum), .cout(cout));

    task check_case;
        input expected_sum, expected_cout;
        begin
            if ((sum === expected_sum) && (cout === expected_cout)) begin
                passed = passed + 1;
            end else begin
                $display("FAIL: a=%b b=%b cin=%b -> sum=%b cout=%b expected sum=%b cout=%b", a, b, cin, sum, cout, expected_sum, expected_cout);
            end
            tests = tests + 1;
        end
    endtask

    initial begin
        $dumpfile("full_adder_wave.vcd");
        $dumpvars(0, full_adder_tb);
        tests = 0;
        passed = 0;

        {a, b, cin} = 3'b000;
        #1 check_case(1'b0, 1'b0);
        {a, b, cin} = 3'b001;
        #1 check_case(1'b1, 1'b0);
        {a, b, cin} = 3'b010;
        #1 check_case(1'b1, 1'b0);
        {a, b, cin} = 3'b011;
        #1 check_case(1'b0, 1'b1);
        {a, b, cin} = 3'b100;
        #1 check_case(1'b1, 1'b0);
        {a, b, cin} = 3'b101;
        #1 check_case(1'b0, 1'b1);
        {a, b, cin} = 3'b110;
        #1 check_case(1'b0, 1'b1);
        {a, b, cin} = 3'b111;
        #1 check_case(1'b1, 1'b1);

        $display("========================================");
        $display("FULL ADDER TEST");
        $display("========================================");
        $display("Tests Run : %0d", tests);
        $display("Passed    : %0d", passed);
        $display("Failed    : %0d", tests - passed);
        if (passed == tests) $display("STATUS    : PASS"); else $display("STATUS    : FAIL");
        $display("========================================");
        $finish;
    end

endmodule
