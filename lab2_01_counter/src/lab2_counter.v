`timescale 1ns/1ps

module lab2_counter #(
    parameter integer STABLE_CYCLES = 20
)(
    input  wire       clk,
    input  wire       rst,
    input  wire       button,
    input  wire [7:0] sw,
    output wire [7:0] led
);

    wire reset;
    wire press;
    wire [7:0] switches;
    wire [3:0] value;

    input_frontend #(
        .STABLE_CYCLES(STABLE_CYCLES)
    ) inputs (
        .clk(clk),
        .rst(rst),
        .button(button),
        .sw(sw),
        .reset(reset),
        .press(press),
        .switches(switches)
    );

    counter4 core (
        .clk(clk),
        .rst(reset),
        .enable(press),
        .down(switches[0]),
        .value(value)
    );

    assign led = {4'b0000, value};

endmodule