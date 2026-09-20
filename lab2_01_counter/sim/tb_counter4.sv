`timescale 1ns/1ps

module tb_counter4;

    reg clk = 0;
    reg rst = 1;
    reg enable = 0;
    reg down = 0;

    wire [3:0] value;

    integer checks = 0;
    integer i;

    counter4 dut (
        .clk(clk),
        .rst(rst),
        .enable(enable),
        .down(down),
        .value(value)
    );

    always #5 clk = ~clk;

    task step;
    begin
        @(posedge clk);
        #1;
    end
    endtask

    task check;
        input condition;
        input [8*100-1:0] description;
    begin
        checks = checks + 1;

        if (condition !== 1'b1) begin
            $display(
                "LAB2_FAIL %0s time=%0t",
                description,
                $time
            );
            $fatal(1, "check failed");
        end
    end
    endtask

    initial begin
        $dumpfile("wave.vcd");
        $dumpvars(0, tb_counter4);
    end

    initial begin
        #100000;
        $fatal(1, "watchdog timeout");
    end

    initial begin
        step;
        check(value === 0, "reset");

        rst = 0;
        enable = 1;

        for (i = 1; i <= 16; i = i + 1) begin
            step;
            check(
                value === (i % 16),
                "up including 15 to 0"
            );
        end

        down = 1;

        for (i = 15; i >= 0; i = i - 1) begin
            step;
            check(
                value === i,
                "down including 0 to 15"
            );
        end

        enable = 0;
        step;
        check(value === 0, "hold");

        enable = 1;
        step;
        check(value === 15, "down wrap");

        rst = 1;
        step;
        check(value === 0, "reset beats enable");

        $display(
            "LAB2_PASS counter4 checks=%0d",
            checks
        );

        $finish;
    end

endmodule