`default_nettype none

module and2 (
    input   wire    i1,
    input   wire    i2,
    output  wire    o1
);

assign o1 = i1 & i2;

initial begin
    // Empty
end

endmodule  // and2
