module mux_2to1 (
    input wire sel,
    input wire d0,
    input wire d1,
    output wire y
);

    assign y = sel ? d1 : d0;

endmodule
