module pwm_motor (
    input  wire clk,
    input  wire on,
    input  wire [1:0] speed,
    output wire pwm
);

    reg [7:0] counter = 0;
    reg [7:0] duty;

    always @(posedge clk) begin
        counter <= counter + 1;
        case (speed)
            2'b00: duty <= 8'd64;   // 25%
            2'b01: duty <= 8'd128;  // 50%
            2'b10: duty <= 8'd192;  // 75%
            2'b11: duty <= 8'd255;  // ~100%
        endcase
    end

    assign pwm = on && (counter < duty);

endmodule