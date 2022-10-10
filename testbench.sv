`timescale 1ns/1ns
module threebitAdder_tb();
reg [2:0] a = 3'd0;
reg [2:0] b = 3'd0;
 wire [2:0] s;
  wire [2:0] c;
  
  wire [2:0] sum;
  wire [2:0] cout;
  
  halfAdder ha(
    .a(a[0]), 
    .b(b[0]),  
    .s(s[0]), 
    .carry(c[0])
  );

  
  fullAdder fa1 (
    .a(a[1]), 
    .b(b[1]),  
    .cin(c[0]),
    .sum(s[1]), 
    .cout(c[1])
  );

  fullAdder fa2 (
    .a(a[2]), 
    .b(b[2]),  
    .cin(c[1]),
    .sum(s[2]), 
    .cout(c[2])
  );
  
  threebitAdder tbA_tb(sum[0], sum[1], sum[2], cout[2], a[0], a[1], a[2], b[0], b[1], b[2]);


  integer c1,c2;
  reg comp[2:0];
initial begin
  $dumpfile("dump.vcd");
  $dumpvars(1,threebitAdder_tb);
  
  for (c1 = 0; c1 <= 4; c1 = c1 + 1) begin
    for (c2 = 0; c2 <= 4; c2 = c2 + 1) begin
      
          a = c1;
		  b = c2;
      comp[0] = ha;
      comp[1] = fa1;
      comp[2] = fa2;
      	#10
      $display("a = %d, b = %d, sum ", a, b, s);

          if (s ==0 && ( a == 0) && ( b == 0) ) begin 
             end
          else begin
           $error("Expected value is different from the value calculated");
           $finish;
            end
          end
    
    end
  end
endmodule

module three_b_comparator;  
   reg [2:0] t_a, t_b;  
 wire a_less_b, a_equal_b, a_greater_b;  

   thr_bit_comparator dut(t_a, t_b, a_less_b, a_equal_b, a_greater_b); 
   
 initial begin  
           t_a = 6;  
           t_b = 1;  
           #10;  
   $display("a=%d, b=%d, a<b =%d, a=b =%d, a>b =%d", t_a,t_b,a_less_b,a_equal_b,a_greater_b );
           t_a = 2;  
           t_b = 3;  
           #10; 
   $display("a=%d, b=%d, a<b =%d, a=b =%d, a>b =%d", t_a,t_b,a_less_b,a_equal_b,a_greater_b );
           t_a = 5;  
           t_b = 4;  
           #10;  
   $display("a=%d, b=%d, a<b =%d, a=b =%d, a>b =%d", t_a,t_b,a_less_b,a_equal_b, a_greater_b );   
   $display("Test completed!");
 end   
   
 endmodule   
