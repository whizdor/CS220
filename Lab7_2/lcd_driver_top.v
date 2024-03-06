module LCD_Driver_top(clk, x, PB1, PB2, PB3, PB4, LCD_E, LCD_W, LCD_RS, data);
    //Input
    input clk;
    input [2:0] x;
    input PB1,PB2,PB3,PB4;

    //Output
    output LCD_E,LCD_RS,LCD_W;  
    output [3:0] data;

    wire LCD_E,LCD_RS,LCD_W;  
    wire [3:0] data;

    //Internal
    reg [2:0] a, b, c, d;
    wire [1:0] min_pos;
    reg [127:0] first_line;
    reg [127:0] second_line;
    reg [9:0] ascii_rom[7:0];

    
    always@ (posedge PB1) begin
		a[2:0] <= x[2:0];
	end
    always@ (posedge PB2) begin
		b[2:0] <= x[2:0];
	end
    always@ (posedge PB3) begin
		c[2:0] <= x[2:0];
	end
    always@ (posedge PB4) begin
		d[2:0] <= x[2:0];
	end

    minimum M(a,b,c,d,min_pos);


    //ASCII ROM.
    iniial begin
        ascii[0] = 8'd48;
	    ascii[1] = 8'd49;
	    ascii[2] = 8'd50;
	    ascii[3] = 8'd51;
	    ascii[4] = 8'd52;
	    ascii[5] = 8'd53;
	    ascii[6] = 8'd54;
	    ascii[7] = 8'd55;
        ascii[8] = 8'd44; //comma
        ascii[9] = 8'd32; //white-space
    end



    always@ (posedge clk) begin
        first_line <= {ascii[a],ascii[9],ascii[8],ascii[b],ascii[9],ascii[8],ascii[c],ascii[9],ascii[8],ascii[d],ascii[9],ascii[8]};
        if(min_pos == 0) begin
            second_line <= "0              ";
        end
        else if(min_pos == 1) begin
            second_line <= "1              ";
        end
        else if(min_pos == 2) begin
            second_line <= "2              ";
        end
        else begin
            second_line <= "3              ";
        end
    end


    LCD_Driver LCD(clk, first_line,second_line,LCD_E, LCD_W, LCD_RS, data);
endmodule
