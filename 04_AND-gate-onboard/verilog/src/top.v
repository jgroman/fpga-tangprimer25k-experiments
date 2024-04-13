`default_nettype none

module top (
    input   wire    i_sw_s1,
    input   wire    i_sw_s2,
    output  wire    o_led_done,
    output  wire    o_led_ready
    );

    assign  o_led_ready = 0;  // Switch off LED READY
    assign  o_led_done = i_sw_s1 & i_sw_s2;

   initial begin
      $dumpfile("../logs/04.vcd");
      $dumpvars(0, top);
   end

endmodule
