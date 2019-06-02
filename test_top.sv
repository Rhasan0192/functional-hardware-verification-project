`include "interface.sv"
//`include"test.sv"
//"include "coverage.sv"

module test_top;

	parameter simulation_cycle = 100;
	bit clk,a_clk,b_clk,c_clk,scan_in,reset;
	//coverage cov=new();
	
	always #(simulation_cycle)
		clk=~clk;
		covergroup CovGrp @(posedge clk);
		cmd1: coverpoint vif.req1_cmd_in {
      bins Addition   = {4'b0001};
      bins Substraction    = {4'b0010};
      bins left_shift   = {4'b0101};
      bins right_shift   = {4'b0110};
      bins no_op  = default;
    }
cmd2: coverpoint vif.req2_cmd_in {
      bins Addition   = {4'b0001};
      bins Substraction    = {4'b0010};
      bins left_shift   = {4'b0101};
      bins right_shift   = {4'b0110};
      bins no_op  = default;
    }
cmd3: coverpoint vif.req3_cmd_in {
      bins Addition   = {4'b0001};
      bins Substraction    = {4'b0010};
      bins left_shift   = {4'b0101};
      bins right_shift   = {4'b0110};
      bins no_op  = default;
    }
cmd4: coverpoint vif.req4_cmd_in {
      bins Addition   = {4'b0001};
      bins Substraction    = {4'b0010};
      bins left_shift   = {4'b0101};
      bins right_shift   = {4'b0110};
      bins no_op  = default;
    }

    data1_1:coverpoint vif.req1_data_in ;
data1_2:coverpoint vif.req2_data_in ;
data1_3:coverpoint vif.req3_data_in ;
data1_4:coverpoint vif.req4_data_in ;


    all_cross: cross cmd1,cmd2,cmd3,cmd4,data1_1,data1_2,data1_3,data1_4;
  endgroup
CovGrp cg = new();

		
	//	cov.sample(tr);
		
		initial 
     begin
	  a_clk = 0;
      b_clk = 0;
      c_clk = 0;
      scan_in = 0;
    end
	
	
	initial 
	begin
   reset = 1;
  wait (3*simulation_cycle/2)  
   reset =0;
  end
//	always #(simulation_cycle/2)
		//c_clk=~c_clk;
		
		calc1_if vif(clk);		//interface
		test t1(vif);			//testbench
		 calc1_top calc1 (
		 .out_data1(vif.out_data1), 
		.out_data2(vif.out_data2), 
		.out_data3(vif.out_data3), 
		.out_data4(vif.out_data4), 
		.out_resp1(vif.out_resp1), 
		.out_resp2(vif.out_resp2), 
		.out_resp3(vif.out_resp3), 
		.out_resp4(vif.out_resp4), 
		
		
		.scan_out(vif.scan_out), 
	.a_clk(vif.a_clk), 
		.b_clk(vif.b_clk), 
		.c_clk(vif.clk), 
		.req1_cmd_in(vif.req1_cmd_in), 
		.req1_data_in(vif.req1_data_in),
		
		.req2_cmd_in(vif.req2_cmd_in), 
		.req2_data_in(vif.req2_data_in),
		
		.req3_cmd_in(vif.req3_cmd_in), 
		.req3_data_in(vif.req3_data_in), 
		
		.req4_cmd_in(vif.req4_cmd_in), 
		.req4_data_in(vif.req4_data_in),
		
		.reset(vif.reset),
		.scan_in(vif.scan_in)
		);
		 //enabling the wave dump
  initial begin 
    $dumpfile("dump.vcd"); $dumpvars;
  end


endmodule