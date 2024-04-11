`default_nettype none

module top
    (
    input   wire    i_sw_s1,
    input   wire    i_sw_s2,
    output  wire    o_led_done,
    output  wire    o_led_ready
    );

    assign  o_led_ready = i_sw_s1;
    assign  o_led_done = ~i_sw_s2;

   initial begin
      $dumpfile("../logs/01.vcd");
      $dumpvars();
   end

endmodule
