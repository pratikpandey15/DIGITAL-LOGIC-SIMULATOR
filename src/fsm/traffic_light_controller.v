module traffic_light_controller (
    input wire clk,
    input wire rst,
    output reg [2:0] lights
);

    reg [1:0] state;
    parameter S0 = 2'b00; // green
    parameter S1 = 2'b01; // yellow
    parameter S2 = 2'b10; // red

    always @(posedge clk or posedge rst) begin
        if (rst) begin
            state <= S0;
            lights <= 3'b001;
        end else begin
            case (state)
                S0: begin
                    state <= S1;
                    lights <= 3'b010;
                end
                S1: begin
                    state <= S2;
                    lights <= 3'b100;
                end
                S2: begin
                    state <= S0;
                    lights <= 3'b001;
                end
                default: begin
                    state <= S0;
                    lights <= 3'b001;
                end
            endcase
        end
    end

endmodule
