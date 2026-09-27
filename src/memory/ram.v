module ram_8x4 (
    input wire clk,
    input wire write_en,
    input wire [2:0] addr,
    input wire [3:0] data_in,
    output reg [3:0] data_out
);

    reg [3:0] memory [0:7];

    always @(posedge clk) begin
        if (write_en)
            memory[addr] <= data_in;
        data_out <= memory[addr];
    end

endmodule
