module LCD_Driver_top(clk, LCD_E, LCD_W, LCD_RS, data);
    //Input
    input clk;

    //Output
    output LCD_E,LCD_RS,LCD_W;  
    output [3:0] data;

    wire LCD_E,LCD_RS,LCD_W;  
    wire [3:0] data;

    LCD_Driver LCD("WELCOME TO CSE, ","IIT KANPUR      ", clk, LCD_E, LCD_W, LCD_RS, data);
endmodule