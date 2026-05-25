`timescale 1ns / 1ps

module tb();

    // Testbench signals
    reg clk;
    reg reset;

    // Instantiate the Device Under Test (DUT)
    TOP dut(
        .clk(clk),
        .reset(reset)
    );

    // Clock Generation
    // Toggles every 5ns, creating a 10ns period (100 MHz clock)
    always begin
        #5 clk = ~clk;
    end

    initial begin

    clk = 0;
    reset = 1;

    #20;

    reset = 0;

    // run simulation
    #500;

    $finish;

end


endmodule