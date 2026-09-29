module vending_machine (
    input wire clk,
    input wire rst,
    input wire coin_5,
    input wire coin_10,
    input wire select_item,
    output reg dispense,
    output reg [3:0] balance
);

    always @(posedge clk or posedge rst) begin
        if (rst) begin
            balance <= 4'b0000;
            dispense <= 1'b0;
        end else begin
            dispense <= 1'b0;
            if (coin_5)
                balance <= balance + 4'b0101;
            if (coin_10)
                balance <= balance + 4'b1010;
            if (select_item && (balance >= 4'b0101)) begin
                dispense <= 1'b1;
                balance <= balance - 4'b0101;
            end
        end
    end

endmodule
