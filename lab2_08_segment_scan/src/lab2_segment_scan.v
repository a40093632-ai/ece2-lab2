`timescale 1ns/1ps

module lab2_segment_scan #(
    parameter integer STABLE_CYCLES = 20
)(
    input  wire       clk,
    input  wire       rst,
    input  wire       button,
    input  wire [7:0] sw,
    output wire [7:0] led,
    output wire [7:0] seg_data,
    output wire [7:0] seg_com
);

    wire reset, press;
    wire [7:0] switches;
    wire [7:0] selected;
    wire [7:0] segments;
    wire [2:0] index;
    wire [31:0] digits;

    assign digits = {28'h7654321, switches[7:4]};

    input_frontend #(
        .STABLE_CYCLES(STABLE_CYCLES)
    ) inputs (
        .clk(clk), .rst(rst), .button(button), .sw(sw),
        .reset(reset), .press(press), .switches(switches)
    );

    segment_scan8 core (
        .clk(clk),
        .rst(reset),
        .enable(1'b1),
        .digits(digits),
        .select(selected),
        .segments(segments),
        .index(index)
    );

    assign seg_com = ~{
        selected[0], selected[1], selected[2], selected[3],
        selected[4], selected[5], selected[6], selected[7]
    };

    assign seg_data = segments;
    assign led = {5'b00000, index};

endmodule