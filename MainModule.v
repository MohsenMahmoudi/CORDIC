module CORDIC_Main(start,x0,y0,z0,clk,rst,done,X,Y,Z);

input start,clk,rst;
input [31:0] x0,y0,z0;//x0=k , y0=0 , z0=theta

reg signed [31:0] tx,ty,tz,d;

output reg done;
output reg [31:0] X,Y,Z;//X=sin , Y=cos

reg state=0;
reg [5:0] index;

reg [32:0] ctab_mem [0:31];


initial begin
ctab_mem[0]='h3243F6A8;
ctab_mem[1]='h1DAC6705;
ctab_mem[2]='h0FADBAFC;
ctab_mem[3]='h07F56EA6;
ctab_mem[4]='h03FEAB76;
ctab_mem[5]='h01FFD55B;
ctab_mem[6]='h00FFFAAA;
ctab_mem[7]='h007FFF55;
ctab_mem[8]='h003FFFEA;
ctab_mem[9]='h001FFFFD;
ctab_mem[10]='h000FFFFF;
ctab_mem[11]='h0007FFFF;
ctab_mem[12]='h0003FFFF;
ctab_mem[13]='h0001FFFF;
ctab_mem[14]='h0000FFFF;
ctab_mem[15]='h00007FFF;
ctab_mem[16]='h00003FFF;
ctab_mem[17]='h00001FFF;
ctab_mem[18]='h00000FFF;
ctab_mem[19]='h000007FF;
ctab_mem[20]='h000003FF;
ctab_mem[21]='h000001FF;
ctab_mem[22]='h000000FF;
ctab_mem[23]='h0000007F;
ctab_mem[24]='h0000003F;
ctab_mem[25]='h0000001F;
ctab_mem[26]='h0000000F;
ctab_mem[27]='h00000008;
ctab_mem[28]='h00000004;
ctab_mem[29]='h00000002;
ctab_mem[30]='h00000001;
ctab_mem[31]='h00000000;
end



always @(posedge clk,rst) begin
	
	if(rst)begin
		state=0;
	end
	else begin
	case(state)
	
		0:begin
				index=0;
				done=0;
				X=0;
				Y=0;
				Z=0;
				tx=x0;
				ty=y0;
				tz=z0;				
				
				
				if(start)
					state=1;
		end
		
		
		1:begin
				if(index<32) begin
				  
					d = tz >= 0 ? 1 : -1;
					

          
					X = tx - d*(ty>>>index);
					Y = ty + d*(tx>>>index);
					
					Z = tz - d*ctab_mem[index];
					
					
					tx = X;
					ty = Y;
					tz = Z;
					
					index=index+1;
					end
				else
					begin
						done=1;
					end
		end
	endcase
end

end
endmodule

