module counter_up_down (
    input wire clk,
    input wire rst,
    input wire up_down,
    output reg [3:0] count
);

    always @(posedge clk or posedge rst) begin
        if (rst)
            count <= 4'b0000;
        else if (up_down)
            count <= count + 4'b0001;
        else
            count <= count - 4'b0001;
    end

endmodule
