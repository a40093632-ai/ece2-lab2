`timescale 1ns/1ps

module moore_cycle (
    input  wire       clk,
    input  wire       rst,
    input  wire       enable,
    input  wire       advance,
    output reg  [1:0] value
);

    localparam [1:0] S0 = 2'b00;
    localparam [1:0] S1 = 2'b01;
    localparam [1:0] S2 = 2'b10;

    reg [1:0] next_state;

    always @(*) begin
        case (value)
            S0: next_state = S1;
            S1: next_state = S2;
            S2: next_state = S0;
            default: next_state = S0;
        endcase
    end

    always @(posedge clk) begin
        if (rst)
            value <= S0;
        else if (enable && advance)
            value <= next_state;
    end

endmodule