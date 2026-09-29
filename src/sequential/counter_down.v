module counter_down (
    input wire clk,
    input wire rst,
    output reg [3:0] count
);

    always @(posedge clk or posedge rst) begin
        if (rst)
            count <= 4'b1111;
        else
            count <= count - 4'b0001;
    end

endmodule
