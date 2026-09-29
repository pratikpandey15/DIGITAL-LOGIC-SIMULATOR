module counter_up (
    input wire clk,
    input wire rst,
    output reg [3:0] count
);

    always @(posedge clk or posedge rst) begin
        if (rst)
            count <= 4'b0000;
        else
            count <= count + 4'b0001;
    end

endmodule
