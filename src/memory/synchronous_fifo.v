module synchronous_fifo (
    input wire clk,
    input wire rst,
    input wire write_en,
    input wire read_en,
    input wire [3:0] data_in,
    output reg [3:0] data_out,
    output reg full,
    output reg empty
);

    reg [3:0] memory [0:7];
    reg [2:0] write_ptr;
    reg [2:0] read_ptr;

    always @(posedge clk or posedge rst) begin
        if (rst) begin
            write_ptr <= 3'b000;
            read_ptr <= 3'b000;
            full <= 1'b0;
            empty <= 1'b1;
            data_out <= 4'b0000;
        end else begin
            if (write_en && !full) begin
                memory[write_ptr] <= data_in;
                write_ptr <= write_ptr + 3'b001;
            end
            if (read_en && !empty) begin
                data_out <= memory[read_ptr];
                read_ptr <= read_ptr + 3'b001;
            end
            full <= (write_ptr == 3'b111);
            empty <= (write_ptr == read_ptr);
        end
    end

endmodule
