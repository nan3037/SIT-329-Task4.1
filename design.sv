`timescale 1ns/1ns

module threebitAdder(s0, s1, s2, cout3, a1, a2, a3, b1, b2, b3);
  
  input a1, b1, a2, b2, a3, b3;
  output s2, s1, s0, cout3;
  
  wire cout1;
  halfAdder half1(a1, b1, s0, cout1);
  wire cout2;
  fullAdder full1(s1, cout2, a2, b2, cout1);
  fullAdder full2(s2, cout3, a3, b3, cout2);
  
endmodule


module halfAdder 
  (
   input a,
   input b,
   output reg s,
   output reg carry
   );
 
  always @(a|b) begin 
    s  = a ^ b;  //xor
 	carry = a & b;;  //and
  end
endmodule 

module fullAdder(sum, cout, a,b, cin);
  
  input a,b,cin;
  output reg sum;
  output reg cout;
  
  always @(a|b|cin) begin 
   sum = a^b^cin;
   cout = ((a&b)|(a&cin)|(b&cin));
  end
  
endmodule // full_adder

//two three comp

`timescale     1 ns/ 1 ns

module thr_bit_comparator (
  input [2:0] a, b, 
  output a_less_b, a_equal_b, a_greater_b);  
  
 wire tmp1,tmp2,tmp3,tmp4,tmp5, tmp6, tmp7, tmp8, tmp9, tmp10; 
  
  // a=b
  xnor u1(tmp9,a[2],b[2]); 
  xnor u1(tmp2,a[1],b[1]);  
  xnor u2(tmp1,a[0],b[0]);  
  and u3(a_equal_b,tmp9,tmp2,tmp1); 
  
  // a<b  
  assign tmp10 = (~a[2]& b[2]); 
  assign tmp4 = (~a[1])& b[1];  
  assign tmp5 = (~a[0])& b[0]; 
  assign a_less_b = tmp10 | (tmp9 & tmp4) | (tmp9 & tmp2 & tmp5);  
  
 // a>b  
  assign tmp7= a[2] & (~b[2]);
  assign tmp6 = (~b[0])& a[0];  
  assign tmp8 = (~b[1])& a[1];     
  assign a_greater_b = tmp7 | (tmp9&tmp8) | (tmp9&tmp2&tmp6);  
  
 endmodule   
 
 

