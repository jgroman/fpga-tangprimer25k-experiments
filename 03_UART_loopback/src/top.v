`default_nettype none

module top (
    input   wire    i_uart_rx,
    output  wire    o_uart_tx,
    output  wire    o_led_done,
    output  wire    o_led_ready
    );

    assign  o_led_ready = 0;
    assign  o_led_done = ~i_uart_rx;
    assign  o_uart_tx = i_uart_rx;

   initial begin
      $dumpfile("../test/logs/03.vcd");
      $dumpvars(0, top);
   end

endmodule
