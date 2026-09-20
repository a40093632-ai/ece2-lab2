`timescale 1ns/1ps

module clock_divider #(
    parameter integer DIVISOR = 10
)(
    input  wire clk,
    input  wire rst,
    output reg  divided,
    output wire tick
);

    localparam integer WIDTH =
        (DIVISOR <= 2) ? 1 : $clog2(DIVISOR);

    reg [WIDTH-1:0] count;

    assign tick = !rst && (count == DIVISOR - 1);

    always @(posedge clk) begin
        if (rst) begin
            count <= 0;
            divided <= 0;
        end else begin
            if (count == DIVISOR - 1)
                count <= 0;
            else
                count <= count + 1'b1;

            if (count == DIVISOR/2-1)
                divided <= 1;
            else if (count == DIVISOR - 1)
                divided <= 0;
        end
    end

endmodule