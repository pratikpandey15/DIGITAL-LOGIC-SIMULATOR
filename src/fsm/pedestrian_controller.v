module pedestrian_controller (
    input wire clk,
    input wire rst,
    input wire request,
    output reg [2:0] lights
);

    reg [1:0] state;
    parameter WALK = 2'b00;
    parameter STOP = 2'b01;
    parameter FLASH = 2'b10;

    always @(posedge clk or posedge rst) begin
        if (rst) begin
            state <= WALK;
            lights <= 3'b001;
        end else begin
            case (state)
                WALK: begin
                    lights <= 3'b001;
                    state <= request ? STOP : WALK;
                end
                STOP: begin
                    lights <= 3'b100;
                    state <= FLASH;
                end
                FLASH: begin
                    lights <= 3'b010;
                    state <= WALK;
                end
                default: begin
                    lights <= 3'b001;
                    state <= WALK;
                end
            endcase
        end
    end

endmodule
