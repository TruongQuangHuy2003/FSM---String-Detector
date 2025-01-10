`timescale 1ns/1ps
module test_bench;
	reg clk;
	reg rst_n;
	reg din;
	wire match;

parameter FSM_MEALY = 1;

string_detector #(FSM_MEALY) dut(
	.clk(clk),
	.rst_n(rst_n),
	.din(din),
	.match(match)
);

	task verify;
		input exp_match;
		begin
			$display("At time: %t, rst_n = 1'b%b", $time, rst_n);
			if (match == exp_match) begin
				$display("---------------------------------------------------------------------------------------------------------------------------");
				$display("PASSED: Expected match: 1'b%b, Got match: 1'b%b", exp_match, match);
				$display("---------------------------------------------------------------------------------------------------------------------------");
			end else begin
				$display("---------------------------------------------------------------------------------------------------------------------------");
				$display("FAILED: Expected match: 1'b%b, Got match: 1'b%b", exp_match, match);
				$display("---------------------------------------------------------------------------------------------------------------------------");
			end
		end
	endtask

	initial begin
		clk = 0;
		forever #5 clk = ~clk;
	end
		
	initial begin
		$dumpfile("test_bench.vcd");
		$dumpvars(0, test_bench);

		$display("---------------------------------------------------------------------------------------------------------------------------");
		$display("---------------------------------------------TESTBECNH FOR STRING DETECTOR-------------------------------------------------");
		$display("---------------------------------------------------------------------------------------------------------------------------");

		rst_n = 0;
		din = 0;
		@(posedge clk);
		verify(0);

		// Detecting string "101011011001011"
		rst_n = 1;
		din = 1;
		@(posedge clk);  // 1
		din = 0;
		@(posedge clk);  // 10
		verify(0);
		din = 1;
		@(posedge clk);  // 101
		din = 0;
		@(posedge clk);  // 10
		verify(0);
		din = 1;
		@(posedge clk); // 101
		verify(0);
		din = 1;
		@(posedge clk); // 1011
		verify(1);
		din = 0;
		@(posedge clk); // 10
		verify(0);
		din = 1;
		@(posedge clk); // 101
		verify(0);
		din = 1;
		@(posedge clk); // 1011
		verify(1);
		din = 0;
		@(posedge clk); // 10
		din = 0;
		@(posedge clk); // 0
		verify(0);
		din = 1;
		@(posedge clk) // 1;
		din = 0;
		@(posedge clk); // 10;
		din = 1;
		@(posedge clk); // 101;
		verify(0);
		din = 1;
		@(posedge clk); // 1011
		verify(1);

		#1;
		$finish;
	end
endmodule

