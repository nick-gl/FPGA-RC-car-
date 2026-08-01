module top (

   input clk,
   input rst,

   input forward,
   input reverse,
   input left,
   input right,
   output[5:0] led,

   output IN1, 
   output IN2,
   output IN3,
   output IN4,
   // output ENA, // dream BBQ
   output servo_pwm
);
   wire pwm;
   assign led[5] = servo_pwm;
   assign led[0] = !IN2;
   assign led[4] = !left;
   assign led[1] = !right;
   assign led[2] = !forward;
   assign led[3] = !reverse;
   assign IN3 = IN1;
   assign IN4 = IN2;

always @(*) begin
   if (forward) begin
      IN1 = 1'b1;
      IN2 = 1'b0; 
   end
   else begin
      // reverse
     IN1 = 1'b0;
      IN2 = 1'b1;
   end
end

   pwm_motor motor (
      .clk(clk),
      .on( forward | reverse),
      .speed(2'b00),
      .pwm(pwm) 
   ); 

   servo_controller servo (
      .clk(clk),
      .left(left),
      .right(right),
      .rst(0),
      .servo(servo_pwm)
   );

endmodule
