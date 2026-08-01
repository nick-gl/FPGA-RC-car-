`timescale 1ns/1ps

module test;

    reg clk = 0;
    reg rst = 0;
    reg [7:0] position = 0;
    wire servo;

    // DUT
    servo_controller uut (
        .clk(clk),
        .rst(rst),
        .position(position),
        .servo(servo)
    );

    // -------------------------
    // SLOW CLOCK FOR DEBUGGING
    // (NOT real hardware clock)
    // -------------------------
    always #500 clk = ~clk;  // slow sim clock (~1 MHz)

    // -------------------------
    // Debug print
    // -------------------------
    
    initial begin
        $monitor("t=%0t | pos=%d | ctr=%d | servo=%b",
                 $time, position, uut.ctr_q, servo);
    end

    initial begin
        $dumpfile("servo.vcd");
        $dumpvars(0, test);

        // -------------------------
        // RESET
        // -------------------------
        rst = 1;
        #2000;
        rst = 0;

        // -------------------------
        // TEST FULL RANGE
        // -------------------------

        position = 8'd0;
        #2_000_000;

        position = 8'd64;
        #2_000_000;

        position = 8'd128;
        #2_000_000;

        position = 8'd192;
        #2_000_000;

        position = 8'd255;
        #2_000_000;

        // -------------------------
        // RESET AGAIN
        // -------------------------
        rst = 1;
        #2000;
        rst = 0;

        #2_000_000;

        $finish;
    end

endmodule