`timescale 1ns/1ps

module lab2_moore #(
    parameter integer STABLE_CYCLES = 20
)(
    input  wire       clk,
    input  wire       rst,
    input  wire       button,
    input  wire [7:0] sw,
    output wire [7:0] led
);

    wire reset, press;
    wire [7:0] switches;
    wire [1:0] value;

    input_frontend #(
        .STABLE_CYCLES(STABLE_CYCLES)
    ) inputs (
        .clk(clk), .rst(rst), .button(button), .sw(sw),
        .reset(reset), .press(press), .switches(switches)
    );

    moore_cycle core (
        .clk(clk),
        .rst(reset),
        .enable(press),
        .advance(switches[7]),
        .value(value)
    );

    assign led = {6'b000000, value};

endmodule