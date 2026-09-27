module shift_register (
    input wire clk,
    input wire rst,
    input wire d,
    output reg [3:0] q
);

    always @(posedge clk or posedge rst) begin
        if (rst)
            q <= 4'b0000;
        else begin
            q[3] <= q[2];
            q[2] <= q[1];
            q[1] <= q[0];
            q[0] <= d;
        end
    end

endmodule
