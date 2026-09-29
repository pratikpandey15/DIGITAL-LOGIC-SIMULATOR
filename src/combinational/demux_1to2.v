module demux_1to2 (
    input wire in,
    input wire sel,
    output reg [1:0] y
);

    always @(*) begin
        y = 2'b00;
        if (sel == 1'b0)
            y[0] = in;
        else
            y[1] = in;
    end

endmodule
