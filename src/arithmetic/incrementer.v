module incrementer (
    input wire [3:0] a,
    output wire [3:0] out,
    output wire carry
);

    assign {carry, out} = a + 4'b0001;

endmodule
