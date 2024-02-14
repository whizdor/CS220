module LCD_Driver(first_line, second_line, clk, LCD_e, LCD_w, LCD_rs, data);
    //Input
    input [127:0] first_line;
    input [127:0] second_line;
    input clk;

    //Output
    output clk, LCD_e, LCD_w, LCD_rs;
    output [3:0] data;

    wire clk, LCD_e, LCD_w, LCD_rs;
    wire [3:0] data;

    reg [32:0] counter;
    reg [2:0] state;

    reg lcd_e_r, lcd_w_r, lcd_rs_r;
    reg [3:0] data_r;
    reg [1:0] steps;
    reg [7:0] index1,index2,index3,index4;

    initial 
    begin
	    steps = 0;
	    state = 0;
	    counter = 0;
	    lcd_e_r = 0;
	    lcd_w_r = 0;
	    lcd_rs_r = 0;
	    index1 = 55; 
	    index2 = 127;
	    index3 = 7;
	    index4 = 127;   
    end


    wire[55:0] config_data;
wire[7:0] br;
assign config_data=56'h333228060C0180;
assign br =  8'hC0;

always @(posedge clk)
begin
	counter = counter + 1;
	if(counter == 1000000 && state==3'b000)
	begin
		if(steps==2'b00)
		begin
			lcd_e_r=0;
			steps = steps+1;
		end
		else if(steps == 2'b01)
		begin
			data_r[3] = config_data[index1];
			data_r[2] = config_data[index1-1];
			data_r[1] = config_data[index1-2];
			data_r[0] = config_data[index1-3];
			steps=steps+1;	
		end
		else if(steps == 2'b10)
		begin
			
			if (index1 == 3)
			begin
				state = 3'b001;
				steps=0;
			end
			lcd_e_r=1;
			steps = 0;
			index1 = index1-4;
		end
		counter = 0;
	end
	else if(state == 3'b001 && counter == 1000000)
	begin
		
		if(steps==2'b00)
		begin
			lcd_e_r=0;
			steps = steps+1;
		end
		else if(steps == 2'b01)
		begin
			lcd_rs_r =1;
			lcd_w_r =0;
			data_r[3] = line1[index2];
			data_r[2] = line1[index2-1];
			data_r[1] = line1[index2-2];
			data_r[0] = line1[index2-3];
			steps=steps+1;
			
		end
		else if(steps == 2'b10)
		begin
			if (index2 ==3)
			begin
				state = 3'b010;
				steps=0;
			end
			lcd_e_r=1;
			steps = 0;
			index2 = index2-4;
		end
		counter = 0;
	end
	else if(state == 3'b010 && counter == 1000000)
	begin
		
		if(steps == 2'b00)
		begin
			lcd_e_r=0;
			steps = steps+1;
		end
		else if(steps == 2'b01)
		begin
			lcd_rs_r=0;
			lcd_w_r=0;
			data_r[3] = br[index3];
			data_r[2] = br[index3-1];
			data_r[1] = br[index3-2];
			data_r[0] = br[index3-3];
			steps=steps+1;
		end
		else if(steps == 2'b10)
		begin
			if (index3 ==3)
			begin
				state = 3'b011;
				steps=0;
			end
			lcd_e_r=1;
			steps = 0;
			index3 = index3-4;
		end
		counter = 0;
	end
	else if(state == 3'b011 && counter == 1000000)
	begin
		if(steps==2'b00)
		begin
			lcd_e_r=0;
			steps = steps+1;
		end
		else if(steps == 2'b01)
		begin
			lcd_rs_r=1;
			lcd_w_r=0;
			data_r[3] = line2[index4];
			data_r[2] = line2[index4-1];
			data_r[1] = line2[index4-2];
			data_r[0] = line2[index4-3];
			steps=steps+1;	
		end
		else if(steps == 2'b10)
		begin
			if (index4 ==3)
			begin
				state = 3'b100;
			end
			lcd_e_r=1;
			steps = 0;
			index4 = index4-4;
		end
		counter = 0;
	end	
end


assign data[3:0] = data_r[3:0];
assign lcd_e = lcd_e_r;
assign lcd_w = lcd_w_r;
assign lcd_rs = lcd_rs_r; 
endmodule
