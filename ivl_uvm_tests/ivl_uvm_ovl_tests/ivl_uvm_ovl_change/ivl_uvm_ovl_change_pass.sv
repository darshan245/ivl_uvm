`timescale 1ns/1ns

module test;

   wire clk;
   reg rst_n;
   logic sync;
   logic out;

   ovl_change u_chk_start_event ( 
			     .clock     (clk),
			     .reset     (rst_n), 
			     .enable    (1'b1),
			     .start_event(sync),
			     .test_expr (out)
			     );

      initial begin
      // Dump waves
      $dumpfile("dump.vcd");
      $dumpvars(1, test);

      // Initialize values.
      rst_n = 1;
      sync  = 0;
      out   = 0;
   
      $display("ovl_change does not fire at rst_n");
      rst_n = 0;
      wait_clks(10);
      $display("Out of reset");

      sync = 1;
      out = 1;
      $display("checking test_expr(out = %0d) without any delay",out);

      sync = 0;
      wait_clks(5);
      sync = 1;
      wait_clks(1);
      out = 1;
      $display("checking test_expr(out = %0d) when wait_clk is 1",out);
  
      sync = 0;
      wait_clks(5);
      sync = 1;
      wait_clks(2);
      out = 1;
      $display("checking test_expr(out = %0d) when wait_clk is 2",out);
     
      sync = 0;
      wait_clks(5);
      sync = 1;
      wait_clks(3);
      out = 1;
      $display("checking test_expr(out = %0d) when wait_clk is 3",out);

      sync = 0;
      $display("checking test_expr(out = %0d) when wait_clk is 20",out);
      wait_clks(20);
      out = 1;

      $finish;
   end

   task wait_clks (input int num_clks = 3);
      repeat (num_clks) @(posedge clk);
   endtask : wait_clks

  ivl_uvm_ovl_clk_gen #(.FREQ_IN_MHZ(100)) u_clk_100 (clk);

endmodule


