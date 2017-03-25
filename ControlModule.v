module Cordic_Ctrl (start,x0,y0,z0,clk,rst,done,X,Y,Z);
  input start,clk,rst;
  input [31:0] x0,y0,z0;//x0=k , y0=0 , z0=theta

  reg [31:0] theta=0;
  wire [31:0] tx,ty,tz;
  
  output wire done;
  output reg [31:0] X,Y,Z;//X=sin , Y=cos

  CORDIC_Main cordicmoduletest(start,x0,y0,theta,clk,rst,done,tx,ty,tz);

  integer magicnumber=18739777;
  
  
  always @(posedge clk) begin
    theta=(z0%90)*magicnumber;
  

  
    ///////////////1 - 90 Deg\\\\\\\\\\\\\\\\\\\\\\\
    if(z0>0 && z0<90)
      begin
        
        X=-ty;
        Y=-tx;
      end
    
    
    ///////////////91 - 90 Deg\\\\\\\\\\\\\\\\\\\\\\\
    if(z0>90 && z0<180)
      begin
        X=-tx;
        Y=ty;
      end
      
      

    ///////////////181 - 270 Deg\\\\\\\\\\\\\\\\\\\\\\\
    if(z0>180 && z0<270)
      begin
        X=ty;
        Y=tx;
      end
      
      
    ///////////////271 - 360 Deg\\\\\\\\\\\\\\\\\\\\\\\
    if(z0>270 && z0<360)
      begin
        X=tx;
        Y=-ty;
      end
  end
 


endmodule
