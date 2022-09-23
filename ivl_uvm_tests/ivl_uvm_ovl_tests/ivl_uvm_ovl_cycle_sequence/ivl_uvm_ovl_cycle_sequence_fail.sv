`timescale 1ns/1ns

module test;

   wire clk;
   reg rst_n;
   logic [3:0] data;

   // Check wr_val is not same as wr_done
   ovl_cycle_sequence #(.num_cks(4)) u_chk_ovl_cycle_sequence ( 
			     .clock     (clk),
			     .reset     (rst_n), 
			     .enable    (1'b1),
			     .event_sequence (data)
			     );

   initial begin
      // Dump waves
      $dumpfile("dump.vcd");
      $dumpvars(1, test);

      // Initialize values.
      rst_n = 0;
      data  = 4'b0000;

      wait_clks(3);
      rst_n = 1;
      wait_clks(2);
      data  = 4'b1000;
      $display("checking event_sequence(data = %0b) after 2 clk cycles",data);

      wait_clks(2);
      data  = 4'b1100;
      $display("checking event_sequence(data = %0b) after 2 clk cycles",data);

      wait_clks(2);
      data  = 4'b1110;
      $display("checking event_sequence(data = %0b) after 2 clk cycles",data);

      wait_clks(2);
      data  = 4'b1111;
      $display("checking event_sequence(data = %0b) after 2 clk cycles",data);

      /*alw_high_sig = 1;
      $display({"ovl_always does not fire ",
                "when alw_high_sig is FALSE"});

      wait_clks(10);*/

      $finish;
   end

   task wait_clks (input int num_clks = 1);
      repeat (num_clks) @(posedge clk);
   endtask : wait_clks

  ivl_uvm_ovl_clk_gen #(.FREQ_IN_MHZ(100)) u_clk_100 (clk);

endmodule


