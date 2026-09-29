module ring_counter (
    input wire clk,
    input wire rst,
    output reg [3:0] q
);

    always @(posedge clk or posedge rst) begin
        if (rst)
            q <= 4'b0001;
        else begin
            q[3] <= q[0];
            q[2] <= q[3];
            q[1] <= q[2];
            q[0] <= q[1];
        end
    end

endmodule
