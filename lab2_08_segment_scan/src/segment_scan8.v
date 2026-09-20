`timescale 1ns/1ps

module segment_scan8 (
    input  wire        clk,
    input  wire        rst,
    input  wire        enable,
    input  wire [31:0] digits,
    output reg  [7:0]  select,
    output reg  [7:0]  segments,
    output reg  [2:0]  index
);

    reg blank;
    reg [3:0] digit;

    always @(posedge clk) begin
        if (rst) begin
            index <= 0;
            blank <= 1;
        end else if (enable) begin
            blank <= ~blank;

            if (!blank)
                index <= index + 1'b1;
        end
    end

    always @(*) begin
        case (index)
            3'd0: digit = digits[3:0];
            3'd1: digit = digits[7:4];
            3'd2: digit = digits[11:8];
            3'd3: digit = digits[15:12];
            3'd4: digit = digits[19:16];
            3'd5: digit = digits[23:20];
            3'd6: digit = digits[27:24];
            default: digit = digits[31:28];
        endcase

        if (blank)
                 select = 8'b00000000;
            else
                     select = 8'b00000001 << index;

        case (digit)
            4'h0: segments = 8'hfc;
            4'h1: segments = 8'h60;
            4'h2: segments = 8'hda;
            4'h3: segments = 8'hf2;
            4'h4: segments = 8'h66;
            4'h5: segments = 8'hb6;
            4'h6: segments = 8'hbe;
            4'h7: segments = 8'he0;
            4'h8: segments = 8'hfe;
            4'h9: segments = 8'hf6;
            4'ha: segments = 8'hee;
            4'hb: segments = 8'h3e;
            4'hc: segments = 8'h9c;
            4'hd: segments = 8'h7a;
            4'he: segments = 8'h9e;
            default: segments = 8'h8e;
        endcase
    end

endmodule