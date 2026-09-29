module sequence_detector (
    input wire clk,
    input wire rst,
    input wire serial_in,
    output reg detected
);

    reg [2:0] state;
    parameter S0 = 3'b000;
    parameter S1 = 3'b001;
    parameter S2 = 3'b010;
    parameter S3 = 3'b011;

    always @(posedge clk or posedge rst) begin
        if (rst) begin
            state <= S0;
            detected <= 1'b0;
        end else begin
            case (state)
                S0: begin
                    detected <= 1'b0;
                    state <= serial_in ? S1 : S0;
                end
                S1: begin
                    detected <= 1'b0;
                    state <= serial_in ? S1 : S2;
                end
                S2: begin
                    detected <= 1'b0;
                    state <= serial_in ? S3 : S0;
                end
                S3: begin
                    detected <= serial_in;
                    state <= serial_in ? S1 : S0;
                end
                default: begin
                    detected <= 1'b0;
                    state <= S0;
                end
            endcase
        end
    end

endmodule
