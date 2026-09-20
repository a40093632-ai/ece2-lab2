`timescale 1ns/1ps

module lab2_piso #(
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
    wire serial_out;
    wire [3:0] value;

    input_frontend #(
        .STABLE_CYCLES(STABLE_CYCLES)
    ) inputs (
        .clk(clk), .rst(rst), .button(button), .sw(sw),
        .reset(reset), .press(press), .switches(switches)
    );

    piso4 core (
        .clk(clk),
        .rst(reset),
        .load(press && switches[0]),
        .enable(press && !switches[0]),
        .data_in(switches[7:4]),
        .serial_out(serial_out),
        .value(value)
    );

    assign led = {value, 3'b000, serial_out};

endmodule