`default_nettype none

module top (
    input   wire [1:0]   i_button,
    output  wire [1:0]   o_led
    );

    assign  o_led[0] = i_button[0];
    assign  o_led[1] = ~i_button[1];

   initial begin
      $dumpfile("../logs/02.vcd");
      $dumpvars();
   end

endmodule
