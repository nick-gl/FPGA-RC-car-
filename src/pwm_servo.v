/*module servo_controller (
  input        clk,
  input        rst,
  input        left,
  input        right,
  input  [7:0] position,
  output       servo
);

  localparam PERIOD    = 20'd540_000;  // 20 ms
  localparam PULSE_MIN = 20'd27_000;   // 1 ms
  localparam PULSE_SCL = 20'd106;      // cycles per position step

  // When left=1, override to full-left position (0), otherwise use position input
  wire [7:0] pos_sel = left  ? 8'd255   :
                     right ? 8'd0 :
                             position;
  wire [19:0] threshold = PULSE_MIN + pos_sel * PULSE_SCL;

  reg [19:0] ctr_q;
  reg        pwm_q;

  always @(posedge clk) begin
    if (rst) begin
      ctr_q <= 20'd0;
      pwm_q <= 1'b0;
    end else begin
      ctr_q <= (ctr_q == PERIOD - 1) ? 20'd0 : ctr_q + 1'b1;
      pwm_q <= (ctr_q < threshold) ? 1'b1 : 1'b0;
    end
  end

  assign servo = pwm_q;
 
endmodule
*/
module servo_controller (
  input        clk,
  input        rst,
  input        left,
  input right, 
  output       servo
);

  localparam PERIOD    = 20'd540_000;
  localparam PULSE_MIN = 20'd27_000;
  localparam PULSE_SCL = 20'd106;



  // ── Servo logic ────────────────────────────────────────────────────────
  wire [7:0]  pos_sel   = left ? 8'd0 :
   right ? 8'd255 : 
          8'd128;
  wire [19:0] threshold = PULSE_MIN + pos_sel * PULSE_SCL;

  reg [19:0] ctr_q;
  reg        pwm_q;

  always @(posedge clk) begin
    if (rst) begin
      ctr_q <= 20'd0;
      pwm_q <= 1'b0;
    end else begin
      ctr_q <= (ctr_q == PERIOD - 1) ? 20'd0 : ctr_q + 1'b1;
      pwm_q <= (ctr_q < threshold) ? 1'b1 : 1'b0;
    end
  end

  assign servo = pwm_q;

endmodule