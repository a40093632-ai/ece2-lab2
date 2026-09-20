`timescale 1ns/1ps

module lab2_mealy #(
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
    wire state;
    wire [1:0] value;

    input_frontend #(
        .STABLE_CYCLES(STABLE_CYCLES)
    ) inputs (
        .clk(clk), .rst(rst), .button(button), .sw(sw),
        .reset(reset), .press(press), .switches(switches)
    );

    mealy_toggle core (
        .clk(clk),
        .rst(reset),
        .enable(press),
        .bit_in(switches[7]),
        .state(state),
        .value(value)
    );

    assign led = {5'b00000, state, value};

endmodule