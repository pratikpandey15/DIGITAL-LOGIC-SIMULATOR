module alu (
    input wire [3:0] a,
    input wire [3:0] b,
    input wire [1:0] sel,
    output reg [3:0] out,
    output reg carry
);

    always @(*) begin
        case (sel)
            2'b00: begin {carry, out} = a + b; end
            2'b01: begin {carry, out} = a - b; end
            2'b10: begin out = a & b; carry = 1'b0; end
            2'b11: begin out = a | b; carry = 1'b0; end
            default: begin out = 4'b0000; carry = 1'b0; end
        endcase
    end

endmodule
