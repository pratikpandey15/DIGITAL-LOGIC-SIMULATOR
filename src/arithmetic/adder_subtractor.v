module adder_subtractor (
    input wire [3:0] a,
    input wire [3:0] b,
    input wire add_sub,
    output wire [3:0] result,
    output wire cout
);

    wire [3:0] b_mod;
    wire c0;

    assign b_mod[0] = b[0] ^ add_sub;
    assign b_mod[1] = b[1] ^ add_sub;
    assign b_mod[2] = b[2] ^ add_sub;
    assign b_mod[3] = b[3] ^ add_sub;

    ripple_carry_adder rca (
        .a(a),
        .b(b_mod),
        .cin(add_sub),
        .sum(result),
        .cout(cout)
    );

endmodule
