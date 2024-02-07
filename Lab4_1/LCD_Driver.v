module LCD_Driver(a,b);
    input a;
    reg LCD_E;
    reg LCD_RS;
    reg LCD_W;
    reg [3:0] data;
    output b;
    wire b;

    initial begin
        LCD_E = 0;
        LCD_RS = 0;
        LCD_W = 0;
        data = 3'b000;
        #20;
        LCD_E = 1;
        #20;

        LCD_E = 0;
        LCD_RS = 0;
        LCD_W = 0;
        data = 3'b000;
        #20;
        LCD_E = 1;
        #20;

        LCD_E = 0;
        LCD_RS = 0;
        LCD_W = 0;
        data = 3'b000;
        #20;
        LCD_E = 1;
        #20;

        LCD_E = 0;
        #20;
        LCD_RS = 0;
        LCD_W = 0;
        data = 2'b00;
        #20;
        LCD_E = 1;
        #20;

        //Function Set Command
        LCD_E = 0;
        #20;
        LCD_RS = 0;
        LCD_W = 0;
        data = 2'b00;
        #20;
        LCD_E = 1;
        #20;
        LCD_E = 0;
        #20;
        LCD_RS = 0;
        LCD_W = 0;
        data = 8'b0;
        #20;
        LCD_E = 1;
        #20;

        //Entry Mode Set
        
    end
endmodule