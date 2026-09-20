`timescale 1ns/1ps

module lab2_clock_divider #(
    parameter integer STABLE_CYCLES = 20,
    parameter integer DIVISOR = 1000
)(
    input  wire       clk,
    input  wire       rst,
    input  wire       button,
    input  wire [7:0] sw,
    output wire [7:0] led
);

    wire reset, press;
    wire [7:0] switches;
    wire divided, tick;
    wire div2, div10, div50;

    input_frontend #(
        .STABLE_CYCLES(STABLE_CYCLES)
    ) inputs (
        .clk(clk), .rst(rst), .button(button), .sw(sw),
        .reset(reset), .press(press), .switches(switches)
    );

    clock_divider #(.DIVISOR(2)) d2 (
        .clk(clk), .rst(reset), .divided(div2), .tick()
    );

    clock_divider #(.DIVISOR(10)) d10 (
        .clk(clk), .rst(reset), .divided(div10), .tick()
    );

    clock_divider #(.DIVISOR(50)) d50 (
        .clk(clk), .rst(reset), .divided(div50), .tick()
    );

    clock_divider #(.DIVISOR(DIVISOR)) main_divider (
        .clk(clk), .rst(reset), .divided(divided), .tick(tick)
    );

    assign led = {3'b000, tick, divided, div50, div10, div2};

endmodule