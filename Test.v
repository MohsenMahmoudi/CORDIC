module test();
  
  reg start=0,clk=0,rst=0;
  
  reg [31:0] x0,y0,z0;
  
  reg [10:0] theta=0;
  
  wire done;
  wire [31:0] X,Y,Z;
  reg [31:0] Xn,Yn,Zn;

  always begin
    if(theta<=360) begin
      if(start==0)begin
      rst=1;
			#10;
			rst=0;
      
      
			x0='h26DD3B6A;
			y0=0;
			
			
			z0=theta;
			
			#10;
			start=1;
			#10;
			end
			else begin
			  if(done==1)begin
			      Xn=X;
   			      Yn=Y;
   			      Zn=Z;
        			theta=theta+1;
        			start=0;
      			end
    			else
    			  #100;
  end
  end
  else
    $stop;
end
  
  always begin
  #10 clk=~clk; 
  end
  
  Cordic_Ctrl cordicmoduletest(start,x0,y0,z0,clk,rst,done,X,Y,Z);
  
endmodule