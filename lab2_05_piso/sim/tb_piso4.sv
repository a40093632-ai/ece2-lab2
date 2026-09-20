`timescale 1ns/1ps

module tb_piso4;

    reg clk = 0, rst = 1;
    reg load = 0, enable = 0;
    reg [3:0] data_in = 0;
    wire serial_out;
    wire [3:0] value;

    integer checks = 0;
    integer word, bit_number;

    piso4 dut (
        .clk(clk), .rst(rst), .load(load), .enable(enable),
        .data_in(data_in), .serial_out(serial_out), .value(value)
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
                $display("LAB2_FAIL piso time=%0t", $time);
                $fatal(1);
            end
        end
    endtask

    initial begin
        $dumpfile("wave.vcd");
        $dumpvars(0, tb_piso4);

        step;
        check(value === 0);
        rst = 0;

        for (word = 0; word < 16; word = word + 1) begin
            data_in = word[3:0];
            load = 1;
            enable = 1;
            step;
            check(value === word[3:0]);

            load = 0;
            enable = 0;
            step;
            check(value === word[3:0]);

            enable = 1;

            for (bit_number = 3;
                 bit_number >= 0;
                 bit_number = bit_number - 1) begin
                check(serial_out === word[bit_number]);
                step;
            end

            check(value === 0);
        end

        rst = 1;
        load = 1;
        data_in = 4'hf;
        step;
        check(value === 0);

        $display("LAB2_PASS piso4 checks=%0d", checks);
        $finish;
    end

endmodule