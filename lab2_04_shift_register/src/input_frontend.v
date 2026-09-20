`timescale 1ns/1ps

module input_frontend #(
    parameter integer STABLE_CYCLES = 20
)(
    input  wire       clk,
    input  wire       rst,
    input  wire       button,
    input  wire [7:0] sw,
    output wire       reset,
    output reg        press,
    output wire [7:0] switches
);

    localparam integer WIDTH =
        (STABLE_CYCLES < 2) ? 1 : $clog2(STABLE_CYCLES);

    reg [1:0] reset_sync;
    reg button_meta, button_sync;
    reg [7:0] switch_meta, switch_sync;
    reg [WIDTH-1:0] stable_count;
    reg button_state;

    assign reset = reset_sync[1];
    assign switches = switch_sync;

    always @(posedge clk or posedge rst) begin
        if (rst)
            reset_sync <= 2'b11;
        else
            reset_sync <= {reset_sync[0], 1'b0};
    end

    always @(posedge clk or posedge reset) begin
        if (reset) begin
            button_meta <= 0;
            button_sync <= 0;
            switch_meta <= 0;
            switch_sync <= 0;
        end else begin
            button_meta <= button;
            button_sync <= button_meta;
            switch_meta <= sw;
            switch_sync <= switch_meta;
        end
    end

    always @(posedge clk or posedge reset) begin
        if (reset) begin
            stable_count <= 0;
            button_state <= 0;
            press <= 0;
        end else begin
            press <= 0;

            if (button_sync == button_state) begin
                stable_count <= 0;
            end else if (stable_count == STABLE_CYCLES - 1) begin
                button_state <= button_sync;
                stable_count <= 0;

                if (button_sync)
                    press <= 1;
            end else begin
                stable_count <= stable_count + 1'b1;
            end
        end
    end

endmodule