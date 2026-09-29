module decrementer (
    input wire [3:0] a,
    output wire [3:0] out,
    output wire borrow
);

    assign {borrow, out} = a - 4'b0001;

endmodule
