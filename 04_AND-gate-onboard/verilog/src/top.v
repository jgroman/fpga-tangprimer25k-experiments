`default_nettype none

`include "and.v"

module top (
    input   wire    i_sw_s1,
    input   wire    i_sw_s2,
    output  wire    o_led_done,
    output  wire    o_led_ready
    );

  assign  o_led_ready = 0;  // Switch off LED READY

  and2 and2_1(
   .i1 (i_sw_s1),
   .i2 (i_sw_s2),
   .o1 (o_led_done)
  );

   initial begin
      $dumpfile("../logs/04.vcd");
      $dumpvars(0, top);
   end

endmodule
