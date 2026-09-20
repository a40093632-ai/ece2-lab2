`timescale 1ns/1ps

module mealy_toggle (
    input  wire       clk,
    input  wire       rst,
    input  wire       enable,
    input  wire       bit_in,
    output reg        state,
    output reg  [1:0] value
);

    always @(posedge clk) begin
        if (rst)
            state <= 1'b0;
        else if (enable && bit_in)
            state <= ~state;
    end

    always @(*) begin
        if (!bit_in)
            value = 2'b00;
        else if (state)
            value = 2'b01;
        else
            value = 2'b10;
    end

endmodule