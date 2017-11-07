`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date:    02:11:31 06/22/2016 
// Design Name: 
// Module Name:    project2 
// Project Name: 
// Target Devices: 
// Tool versions: 
// Description: 
//
// Dependencies: 
//
// Revision: 
// Revision 0.01 - File Created
// Additional Comments: 
//
//////////////////////////////////////////////////////////////////////////////////
module project2(btn, switches, enable, DIP, clk, led, cathodes, anode, rst);
input [3:0] btn;
input enable;
input DIP;
output [7:0] led;
input clk, rst;
input [3:0] switches;
output [6:0] cathodes;
output [3:0] anode;

reg [6:0] temp_cathode=7'b1111111;
reg [7:0] temp_led=8'b00000000; 


reg [6:0] ssd_1=7'b1111111;
reg [6:0] ssd_2=7'b1111111;
reg [6:0] ssd_3=7'b1111111;
reg [6:0] ssd_4=7'b1111111;

reg [3:0] an=7'b1111111;
reg [3:0] cstate, nstate;



integer temp=0;
integer temp1=0;
integer temp2=0;
integer status=0;
integer firstpress=0;

reg slow_clk;
integer clk_count=0;
//reg [1:0] status = 2'b00;

always @(posedge clk or negedge rst)
 begin
 if (~rst) cstate<=11; 
 else cstate<=nstate;

end 

always @(posedge clk)


begin
            if(enable==0 && temp==0 && DIP==0) begin temp=1;end
            if (enable==1 && temp==1  && DIP==0)begin temp=2;end
            if (enable==0 && temp==2 && DIP==0)begin temp=3;end
            if(enable==1 && temp1==0 && temp==3 && DIP==0) begin temp=4;end 
            if(enable==0 && temp1==0 && temp==4 && DIP==0) begin temp=5;end
				if(enable==1 && temp1==0 && temp==5 && DIP==0) begin temp=6;end
				if(enable==0 && temp1==0 && temp==6 && DIP==0) begin temp=1; firstpress=1; end
				if(enable==0 && temp1==0 && temp==3 && DIP==1) begin temp=7;end
				if(enable==0 && temp1==0 && temp==7 && DIP==0) begin temp=8;end
			
end

 always @(posedge clk)
 begin
  if (firstpress==0)
   status=0;
	if (firstpress==1 && status==0)
	status=1;
  end	
	


 
always @(posedge clk)
begin
case (temp)
1: begin
   if(btn== 4'b0001) begin nstate=3; end // Button 3 pressed
   if(btn== 4'b0010) begin nstate=2;end // Button 2 pressed
   if(btn== 4'b0100) begin nstate=1;end // Button 1 pressed
   if(btn== 4'b1000) begin nstate=0;end // Button 0 pressed
   if(btn== 4'b0000) begin nstate=cstate; end // No button pressed
   end
2: begin
      if(btn== 4'b0000) begin nstate=4;end
   end
3: begin
      if(btn== 4'b0000) begin nstate=5;end	
	end
4: begin
      if(btn== 4'b0000) begin nstate=6;end
   end
  // end 	
5: begin
   if(status==0) 
		    begin
		        if(btn==4'b0001) begin nstate=7; end //Button 3 pressed
		        if(btn==4'b0010) begin nstate=8; end //Button 2 pressed
		        if(btn==4'b0100) begin nstate=9;end // Button 1 pressed
              if(btn==4'b1000) begin nstate=10;end // Button 0 pressed
		        if(btn==4'b0000) begin nstate=cstate; end //No button pressed
          end
	
	if(status==1)
          	begin
	           if(btn==4'b0001) begin nstate=12; end //Button 3 pressed
		        if(btn==4'b0010) begin nstate=13; end //Button 2 pressed
		        if(btn==4'b0100) begin nstate=14;end // Button 1 pressed
              if(btn==4'b1000) begin nstate=15;end // Button 0 pressed
		        if(btn==4'b0000) begin nstate=cstate; end //No button pressed
            end
	end
6: begin
      if(btn== 4'b0000) begin nstate=6;end
	end
7: begin
      if(btn== 4'b0000) begin nstate=4;end
   end
8: begin
      if(btn== 4'b0000) begin nstate=11;end
   end

endcase
end

always @ (posedge clk) 
begin	
	if(clk_count> 100000) //slowing down 50MHz to 500Hz
	begin 
		clk_count = 0; 
		slow_clk = ~slow_clk; 
	end
	clk_count = clk_count + 1;
end

always @(posedge clk)
	
begin

case (cstate)
 3: begin // Button 3 pressed
  if (switches[3:0]==4'b0000) begin an=4'b0111; temp_cathode = 7'b1000000; temp_led=8'b00000000;end
  else if (switches[3:0]==4'b0001) begin an=4'b0111;temp_cathode = 7'b1111001; temp_led=8'b00000000; end
  else if (switches[3:0]==4'b0010) begin an=4'b0111;temp_cathode = 7'b0100100; temp_led=8'b00000000;end
  else if (switches[3:0]==4'b0011) begin an=4'b0111;temp_cathode = 7'b0110000; temp_led=8'b00000000;end
  else if (switches[3:0]==4'b0100) begin an=4'b0111;temp_cathode = 7'b0011001; temp_led=8'b00000000;end
  else if (switches[3:0]==4'b0101) begin an=4'b0111;temp_cathode = 7'b0010010; temp_led=8'b00000000;end
  else if (switches[3:0]==4'b0110) begin an=4'b0111;temp_cathode = 7'b0000010; temp_led=8'b00000000;end
  else if (switches[3:0]==4'b0111) begin an=4'b0111;temp_cathode = 7'b1111000; temp_led=8'b00000000;end
  else if (switches[3:0]==4'b1000) begin an=4'b0111;temp_cathode = 7'b0000000; temp_led=8'b00000000;end
  else if (switches[3:0]==4'b1001) begin an=4'b0111;temp_cathode = 7'b0010000; temp_led=8'b00000000;end
  else if (switches[3:0]==4'b1010) begin an=4'b0111;temp_cathode = 7'b0001000; temp_led=8'b00000000;end
  else if (switches[3:0]==4'b1011) begin an=4'b0111;temp_cathode = 7'b0000011; temp_led=8'b00000000;end
  else if (switches[3:0]==4'b1100) begin an=4'b0111;temp_cathode = 7'b0100111; temp_led=8'b00000000;end
  else if (switches[3:0]==4'b1101) begin an=4'b0111;temp_cathode = 7'b0100001; temp_led=8'b00000000;end
  else if (switches[3:0]==4'b1110) begin an=4'b0111;temp_cathode = 7'b0000110; temp_led=8'b00000000;end
  else if (switches[3:0]==4'b1111) begin an=4'b0111;temp_cathode = 7'b0001110; temp_led=8'b00000000;end

 end
 2: begin // Button 2 pressed
  if (switches[3:0]==4'b0000) begin an=4'b1011; temp_cathode = 7'b1000000; temp_led=8'b00000000;end
 else if (switches[3:0]==4'b0001) begin an=4'b1011; temp_cathode = 7'b1111001; temp_led=8'b00000000;end
 else if (switches[3:0]==4'b0010) begin an=4'b1011;temp_cathode = 7'b0100100; temp_led=8'b00000000;end
  else if (switches[3:0]==4'b0011) begin an=4'b1011;temp_cathode = 7'b0110000; temp_led=8'b00000000;end
  else if (switches[3:0]==4'b0100) begin an=4'b1011;temp_cathode = 7'b0011001; temp_led=8'b00000000;end
  else if (switches[3:0]==4'b0101) begin an=4'b1011;temp_cathode = 7'b0010010; temp_led=8'b00000000;end
  else if (switches[3:0]==4'b0110) begin an=4'b1011;temp_cathode = 7'b0000010; temp_led=8'b00000000;end
  else if (switches[3:0]==4'b0111) begin an=4'b1011;temp_cathode = 7'b1111000; temp_led=8'b00000000;end
  else if (switches[3:0]==4'b1000) begin an=4'b1011;temp_cathode = 7'b0000000; temp_led=8'b00000000;end
  else if (switches[3:0]==4'b1001) begin an=4'b1011;temp_cathode = 7'b0010000; temp_led=8'b00000000;end
  else if (switches[3:0]==4'b1010) begin an=4'b1011;temp_cathode = 7'b0001000; temp_led=8'b00000000;end
  else if (switches[3:0]==4'b1011) begin an=4'b1011;temp_cathode = 7'b0000011; temp_led=8'b00000000;end
  else if (switches[3:0]==4'b1100) begin an=4'b1011;temp_cathode = 7'b0100111; temp_led=8'b00000000;end
  else if (switches[3:0]==4'b1101) begin an=4'b1011;temp_cathode = 7'b0100001; temp_led=8'b00000000;end
  else if (switches[3:0]==4'b1110) begin an=4'b1011;temp_cathode = 7'b0000110; temp_led=8'b00000000;end
  else if (switches[3:0]==4'b1111) begin an=4'b1011;temp_cathode = 7'b0001110; temp_led=8'b00000000;end
 end
 1: begin // Button 1 pressed
if (switches[3:0]==4'b0000) begin an=4'b1101; temp_cathode = 7'b1000000; temp_led=8'b00000000;end
 else if (switches[3:0]==4'b0001) begin an=4'b1101; temp_cathode = 7'b1111001; temp_led=8'b00000000;end
 else if (switches[3:0]==4'b0010) begin an=4'b1101;temp_cathode = 7'b0100100; temp_led=8'b00000000;end
  else if (switches[3:0]==4'b0011) begin an=4'b1101;temp_cathode = 7'b0110000; temp_led=8'b00000000;end
  else if (switches[3:0]==4'b0100) begin an=4'b1101;temp_cathode = 7'b0011001; temp_led=8'b00000000;end
  else if (switches[3:0]==4'b0101) begin an=4'b1101;temp_cathode = 7'b0010010; temp_led=8'b00000000;end
  else if (switches[3:0]==4'b0110) begin an=4'b1101;temp_cathode = 7'b0000010; temp_led=8'b00000000;end
  else if (switches[3:0]==4'b0111) begin an=4'b1101;temp_cathode = 7'b1111000; temp_led=8'b00000000;end
  else if (switches[3:0]==4'b1000) begin an=4'b1101;temp_cathode = 7'b0000000; temp_led=8'b00000000;end
  else if (switches[3:0]==4'b1001) begin an=4'b1101;temp_cathode = 7'b0010000; temp_led=8'b00000000;end
  else if (switches[3:0]==4'b1010) begin an=4'b1101;temp_cathode = 7'b0001000; temp_led=8'b00000000;end
  else if (switches[3:0]==4'b1011) begin an=4'b1101;temp_cathode = 7'b0000011; temp_led=8'b00000000;end
  else if (switches[3:0]==4'b1100) begin an=4'b1101;temp_cathode = 7'b0100111; temp_led=8'b00000000;end
  else if (switches[3:0]==4'b1101) begin an=4'b1101;temp_cathode = 7'b0100001; temp_led=8'b00000000;end
  else if (switches[3:0]==4'b1110) begin an=4'b1101;temp_cathode = 7'b0000110; temp_led=8'b00000000;end
  else if (switches[3:0]==4'b1111) begin an=4'b1101;temp_cathode = 7'b0001110; temp_led=8'b00000000;end
 end
 0: begin // Button 0 pressed
if (switches[3:0]==4'b0000) begin an=4'b1110; temp_cathode = 7'b1000000; temp_led=8'b00000000;end
 else if (switches[3:0]==4'b0001) begin an=4'b1110; temp_cathode = 7'b1111001; temp_led=8'b00000000;end
 else if (switches[3:0]==4'b0010) begin an=4'b1110;temp_cathode = 7'b0100100;  temp_led=8'b00000000;end
  else if (switches[3:0]==4'b0011) begin an=4'b1110;temp_cathode = 7'b0110000; temp_led=8'b00000000;end
  else if (switches[3:0]==4'b0100) begin an=4'b1110;temp_cathode = 7'b0011001; temp_led=8'b00000000;end
  else if (switches[3:0]==4'b0101) begin an=4'b1110;temp_cathode = 7'b0010010; temp_led=8'b00000000;end
  else if (switches[3:0]==4'b0110) begin an=4'b1110;temp_cathode = 7'b0000010; temp_led=8'b00000000;end
  else if (switches[3:0]==4'b0111) begin an=4'b1110;temp_cathode = 7'b1111000; temp_led=8'b00000000;end
  else if (switches[3:0]==4'b1000) begin an=4'b1110;temp_cathode = 7'b0000000; temp_led=8'b00000000;end
  else if (switches[3:0]==4'b1001) begin an=4'b1110;temp_cathode = 7'b0010000; temp_led=8'b00000000;end
  else if (switches[3:0]==4'b1010) begin an=4'b1110;temp_cathode = 7'b0001000; temp_led=8'b00000000;end
  else if (switches[3:0]==4'b1011) begin an=4'b1110;temp_cathode = 7'b0000011; temp_led=8'b00000000;end
  else if (switches[3:0]==4'b1100) begin an=4'b1110;temp_cathode = 7'b0100111; temp_led=8'b00000000;end
  else if (switches[3:0]==4'b1101) begin an=4'b1110;temp_cathode = 7'b0100001; temp_led=8'b00000000;end
  else if (switches[3:0]==4'b1110) begin an=4'b1110;temp_cathode = 7'b0000110; temp_led=8'b00000000;end
  else if (switches[3:0]==4'b1111) begin an=4'b1110;temp_cathode = 7'b0001110; temp_led=8'b00000000;end
 end

 4: begin temp_cathode = 7'b1111111; temp_led=8'b00000000; end

 5: begin  an=4'b1110; temp_cathode=7'b1000110; temp_led=8'b11111111; end
 
 6: begin temp_cathode = 7'b1111111; temp_led=8'b00000000; end
 
 7: begin // Button 3 pressed
        if (switches[3:0]==4'b0010) 
		          begin an=4'b0111;temp_cathode = 7'b0100100;temp_led=8'b00000010;ssd_1=7'b0010010;  end
        else
         		  begin an=4'b1111;temp_cathode = 7'b1111111;  end//ssd_1=7'b0010010; 
    end
	 
 8: begin // Button 2 pressed
          if (switches[3:0]==4'b1000) 
			         begin an=4'b1011;temp_cathode = 7'b0000000;temp_led=8'b00001000;ssd_2=7'b0010000; end //ssd_2=7'b0010000; 
          else 
			         begin an=4'b1111;temp_cathode = 7'b1111111; end
    end
	 
 9: begin // Button 1 pressed
       if (switches[3:0]==4'b1001) 
		            begin an=4'b1101;temp_cathode = 7'b0010000;temp_led=8'b00001001;ssd_3=7'b0000000; end //ssd_2=7'b0010000; 
       else 
		            begin temp_cathode = 7'b1111111; end
    end
	 
 10: begin // Button 0 pressed
       if (switches[3:0]==4'b0101) 
		            begin an=4'b1110;temp_cathode = 7'b0010010;temp_led=8'b11111111;ssd_4=7'b0100100;end//ssd_3=7'b0000000;
       else 
		             begin temp_cathode = 7'b1111111; temp_led=8'b00000000;end
     end
 11: begin  an=4'b1110; temp_cathode=7'b1000111;end
  12: begin // Button 3 pressed
  if (switches[3:0]==4'b0000) begin an=4'b0111; temp_cathode = 7'b1111111; temp_led=8'b00000001;end
  else if (switches[3:0]==4'b0001) begin an=4'b0111;temp_cathode = 7'b1111111; temp_led=8'b00000001; end
  else if (switches[3:0]==4'b0011) begin an=4'b0111;temp_cathode = 7'b1111111; temp_led=8'b00000001;end
  else if (switches[3:0]==4'b0100) begin an=4'b0111;temp_cathode = 7'b1111111; temp_led=8'b00000001;end
  else if (switches[3:0]==4'b0101) begin an=4'b0111;temp_cathode = 7'b1111111; temp_led=8'b00000001;end
  else if (switches[3:0]==4'b0110) begin an=4'b0111;temp_cathode = 7'b1111111; temp_led=8'b00000001;end
  else if (switches[3:0]==4'b0111) begin an=4'b0111;temp_cathode = 7'b1111111; temp_led=8'b00000001;end
  else if (switches[3:0]==4'b1000) begin an=4'b0111;temp_cathode = 7'b1111111; temp_led=8'b00000001;end
  else if (switches[3:0]==4'b1001) begin an=4'b0111;temp_cathode = 7'b1111111; temp_led=8'b00000001;end
  else if (switches[3:0]==4'b1010) begin an=4'b0111;temp_cathode = 7'b1111111; temp_led=8'b00000001;end
  else if (switches[3:0]==4'b1011) begin an=4'b0111;temp_cathode = 7'b1111111; temp_led=8'b00000001;end
  else if (switches[3:0]==4'b1100) begin an=4'b0111;temp_cathode = 7'b1111111; temp_led=8'b00000001;end
  else if (switches[3:0]==4'b1101) begin an=4'b0111;temp_cathode = 7'b1111111; temp_led=8'b00000001;end
  else if (switches[3:0]==4'b1110) begin an=4'b0111;temp_cathode = 7'b1111111; temp_led=8'b00000001;end
  else if (switches[3:0]==4'b1111) begin an=4'b0111;temp_cathode = 7'b1111111; temp_led=8'b00000001;end

 end
 13: begin // Button 2 pressed
  if (switches[3:0]==4'b0000) begin an=4'b1011;temp_cathode = 7'b1111111; temp_led=8'b00000010;end
 else if (switches[3:0]==4'b0001) begin an=4'b1011; temp_cathode = 7'b1111111; temp_led=8'b00000010;end
 else if (switches[3:0]==4'b0010) begin an=4'b1011;temp_cathode = 7'b1111111;temp_led=8'b00000010;end
  else if (switches[3:0]==4'b0011) begin an=4'b1011;temp_cathode = 7'b1111111; temp_led=8'b00000010;end
  else if (switches[3:0]==4'b0101) begin an=4'b1011;temp_cathode =7'b1111111; temp_led=8'b00000010;end
  else if (switches[3:0]==4'b0110) begin an=4'b1011;temp_cathode = 7'b1111111; temp_led=8'b00000010;end
  else if (switches[3:0]==4'b0111) begin an=4'b1011;temp_cathode = 7'b1111111; temp_led=8'b00000010;end
  else if (switches[3:0]==4'b1000) begin an=4'b1011;temp_cathode = 7'b1111111; temp_led=8'b00000010;end
  else if (switches[3:0]==4'b1001) begin an=4'b1011;temp_cathode = 7'b1111111; temp_led=8'b00000010;end
  else if (switches[3:0]==4'b1010) begin an=4'b1011;temp_cathode = 7'b1111111; temp_led=8'b00000010;end
  else if (switches[3:0]==4'b1011) begin an=4'b1011;temp_cathode = 7'b1111111; temp_led=8'b00000010;end
  else if (switches[3:0]==4'b1100) begin an=4'b1011;temp_cathode = 7'b1111111; temp_led=8'b00000010;end
  else if (switches[3:0]==4'b1101) begin an=4'b1011;temp_cathode = 7'b1111111; temp_led=8'b00000010;end
  else if (switches[3:0]==4'b1110) begin an=4'b1011;temp_cathode = 7'b1111111; temp_led=8'b00000010;end
  else if (switches[3:0]==4'b1111) begin an=4'b1011;temp_cathode = 7'b1111111; temp_led=8'b00000010;end
 end
 14: begin // Button 1 pressed
if (switches[3:0]==4'b0000) begin an=4'b1101; temp_cathode = 7'b1111111; temp_led=8'b00000100;end
 else if (switches[3:0]==4'b0001) begin an=4'b1101; temp_cathode = 7'b1111111; temp_led=8'b00000100;end
 else if (switches[3:0]==4'b0010) begin an=4'b1101;temp_cathode = 7'b1111111; temp_led=8'b00000100;end
  else if (switches[3:0]==4'b0011) begin an=4'b1101;temp_cathode = 7'b1111111; temp_led=8'b00000100;end
  else if (switches[3:0]==4'b0100) begin an=4'b1101;temp_cathode = 7'b1111111; temp_led=8'b00000100;end
  else if (switches[3:0]==4'b0101) begin an=4'b1101;temp_cathode = 7'b1111111; temp_led=8'b00000100;end
  else if (switches[3:0]==4'b0110) begin an=4'b1101;temp_cathode = 7'b1111111; temp_led=8'b00000100;end
  else if (switches[3:0]==4'b0111) begin an=4'b1101;temp_cathode = 7'b1111111; temp_led=8'b00000100;end
  else if (switches[3:0]==4'b1000) begin an=4'b1101;temp_cathode = 7'b1111111; temp_led=8'b00000100;end
  else if (switches[3:0]==4'b1010) begin an=4'b1101;temp_cathode = 7'b1111111; temp_led=8'b00000100;end
  else if (switches[3:0]==4'b1011) begin an=4'b1101;temp_cathode = 7'b1111111; temp_led=8'b00000100;end
  else if (switches[3:0]==4'b1100) begin an=4'b1101;temp_cathode = 7'b1111111; temp_led=8'b00000100;end
  else if (switches[3:0]==4'b1101) begin an=4'b1101;temp_cathode = 7'b1111111; temp_led=8'b00000100;end
  else if (switches[3:0]==4'b1110) begin an=4'b1101;temp_cathode = 7'b1111111; temp_led=8'b00000100;end
  else if (switches[3:0]==4'b1111) begin an=4'b1101;temp_cathode = 7'b1111111; temp_led=8'b00000100;end
 end
 15: begin an = 4'b1110; temp_cathode= 7'b0001100; end

 	endcase
 end



assign cathodes= temp_cathode;
assign anode=an;
assign led=temp_led;


endmodule 