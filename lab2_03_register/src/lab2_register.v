`timescale 1ns/1ps

module lab2_register #(
    parameter integer STABLE_CYCLES = 20
)(
    input wire clk,
    input wire rst,
    input wire button,
    input wire [7:0] sw,
    output wire [7:0] led
);

    wire reset;
    wire press;
    wire [7:0] switches;
    wire [3:0] stored;
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

    register_pair core (
        .clk(clk),
        .rst(reset),
        .load(press && switches[0]),
        .transfer(press && switches[1]),
        .data_in(switches[7:4]),
        .stored(stored),
        .value(value)
    );

    assign led = {stored, value};

endmodule