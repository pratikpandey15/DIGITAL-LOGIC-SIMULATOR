module register_file (
    input wire clk,
    input wire write_en,
    input wire [1:0] write_addr,
    input wire [1:0] read_addr,
    input wire [3:0] data_in,
    output reg [3:0] data_out
);

    reg [3:0] registers [0:3];

    always @(posedge clk) begin
        if (write_en)
            registers[write_addr] <= data_in;
    end

    always @(*) begin
        data_out = registers[read_addr];
    end

endmodule
