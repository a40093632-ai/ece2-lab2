`timescale 1ns/1ps

module tb_segment_scan8;

    reg clk = 0, rst = 1, enable = 0;
    reg [31:0] digits = 32'h76543210;

    wire [7:0] select, segments;
    wire [2:0] index;

    reg [7:0] expected [0:15];

    integer checks = 0;
    integer bank, lap, position;

    segment_scan8 dut (
        .clk(clk), .rst(rst), .enable(enable), .digits(digits),
        .select(select), .segments(segments), .index(index)
    );

    always #5 clk = ~clk;

    task step;
        begin @(posedge clk); #1; end
    endtask

    task check;
        input condition;
        begin
            checks = checks + 1;
            if (condition !== 1'b1) begin
                $display("LAB2_FAIL segment_scan time=%0t", $time);
                $fatal(1);
            end
        end
    endtask

    initial begin
        expected[0]=8'hfc; expected[1]=8'h60;
        expected[2]=8'hda; expected[3]=8'hf2;
        expected[4]=8'h66; expected[5]=8'hb6;
        expected[6]=8'hbe; expected[7]=8'he0;
        expected[8]=8'hfe; expected[9]=8'hf6;
        expected[10]=8'hee; expected[11]=8'h3e;
        expected[12]=8'h9c; expected[13]=8'h7a;
        expected[14]=8'h9e; expected[15]=8'h8e;

        $dumpfile("wave.vcd");
        $dumpvars(0, tb_segment_scan8);

        step;
        check(select === 0 && index === 0);
        rst = 0;

        for (bank = 0; bank < 2; bank = bank + 1) begin
            if (bank == 0)
                digits = 32'h76543210;
            else
                digits = 32'hfedcba98;

            for (lap = 0; lap < 2; lap = lap + 1) begin
                for (position = 0; position < 8;
                     position = position + 1) begin

                    enable = 1;
                    step;

                    check(index === position[2:0]);
                    check(select === (8'b1 << position));
                    check(segments === expected[bank*8+position]);

                    enable = 0;
                    step;
                    check(select === (8'b1 << position));

                    enable = 1;
                    step;
                    check(select === 0);

                    enable = 0;
                    step;
                    check(select === 0);
                end
            end
        end

        enable = 1;
        step;
        rst = 1;
        step;

        check(select === 0 && index === 0);

        $display("LAB2_PASS segment_scan8 checks=%0d", checks);
        $finish;
    end

endmodule