`timescale 1ns/1ps

module tb_clock_divider;

    reg clk = 0;
    reg rst = 1;

    wire divided, tick;
    wire div2, tick2;

    integer checks = 0;
    integer cycle;
    integer pulses = 0;

    clock_divider #(.DIVISOR(10)) dut (
        .clk(clk), .rst(rst), .divided(divided), .tick(tick)
    );

    clock_divider #(.DIVISOR(2)) minimum (
        .clk(clk), .rst(rst), .divided(div2), .tick(tick2)
    );

    always #5 clk = ~clk;

    always @(posedge clk)
        if (!rst && tick)
            pulses = pulses + 1;

    task step;
        begin
            @(posedge clk);
            #1;
        end
    endtask

    task check;
        input condition;
        begin
            checks = checks + 1;
            if (condition !== 1'b1) begin
                $display("LAB2_FAIL clock_divider time=%0t", $time);
                $fatal(1);
            end
        end
    endtask

    initial begin
        $dumpfile("wave.vcd");
        $dumpvars(0, tb_clock_divider);

        step;
        check({divided,tick,div2,tick2} === 4'b0000);

        rst = 0;

        for (cycle = 1; cycle <= 30; cycle = cycle + 1) begin
            step;
            check(divided === (cycle % 10 >= 5));
            check(tick === (cycle % 10 == 9));
            check(div2 === (cycle % 2 == 1));
            check(tick2 === (cycle % 2 == 1));
        end

        check(pulses == 3);

        repeat (7) step;

        rst = 1;
        #1;
        check(tick === 0);

        step;
        check(divided === 0);

        rst = 0;

        repeat (4) begin
            step;
            check(divided === 0);
        end

        step;
        check(divided === 1);

        $display("LAB2_PASS clock_divider checks=%0d", checks);
        $finish;
    end

endmodule