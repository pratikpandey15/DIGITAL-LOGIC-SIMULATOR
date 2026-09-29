module encoder_4to2 (
    input wire [3:0] in,
    output reg [1:0] out,
    output reg valid
);

    always @(*) begin
        valid = 1'b0;
        out = 2'b00;

        case (in)
            4'b0001: begin out = 2'b00; valid = 1'b1; end
            4'b0010: begin out = 2'b01; valid = 1'b1; end
            4'b0100: begin out = 2'b10; valid = 1'b1; end
            4'b1000: begin out = 2'b11; valid = 1'b1; end
            default: begin out = 2'b00; valid = 1'b0; end
        endcase
    end

endmodule
