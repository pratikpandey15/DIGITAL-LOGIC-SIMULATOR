module rom (
    input wire [2:0] addr,
    output reg [3:0] data_out
);

    reg [3:0] memory [0:7];

    initial begin
        memory[0] = 4'b0000;
        memory[1] = 4'b0001;
        memory[2] = 4'b0010;
        memory[3] = 4'b0011;
        memory[4] = 4'b0100;
        memory[5] = 4'b0101;
        memory[6] = 4'b0110;
        memory[7] = 4'b0111;
    end

    always @(*) begin
        data_out = memory[addr];
    end

endmodule
