`timescale 1ns / 1ps

module LCD_Driver(first_line, second_line, clk, LCD_E, LCD_W, LCD_RS, data);

    //Input
    input [127:0] second_line;
    input [127:0] first_line;
    input clk;

    //Output
    output LCD_E, LCD_W, LCD_RS;
    output [3:0] data;
    reg LCD_E, LCD_W, LCD_RS;
    reg [3:0] data;

    //Internal Variables
    reg [20:0] counter;
    reg [2:0] state;
    reg [1:0] steps;
    reg [2:0] line_break_steps;
    reg [7:0] index1,first_line_index,second_line_index;
    reg [3:0] init_ROM_index;
    reg [5:0] init_ROM [0:13];

    initial 
    begin
        steps = 0;
        state = 0;
        counter = 0;
        index1 = 55; 
        first_line_index = 127;
        second_line_index = 127; 
        line_break_steps = 0;
        init_ROM_index = 0;

        //Configuration ROM
		init_ROM[0] = 6'h03;
		init_ROM[1] = 6'h03;
		init_ROM[2] = 6'h03;
		init_ROM[3] = 6'h02;
		init_ROM[4] = 6'h02;
		init_ROM[5] = 6'h08;
		init_ROM[6] = 6'h00;
		init_ROM[7] = 6'h06;
		init_ROM[8] = 6'h00;
		init_ROM[9] = 6'h0c;
		init_ROM[10] = 6'h00;
		init_ROM[11] = 6'h01;
		init_ROM[12] = 6'h08;
		init_ROM[13] = 6'h00;
    end

    wire[55:0] config_data;
    assign config_data=56'h333228060C0180;

    always @(posedge clk)
    begin
        //Increment the Counter
        if(counter == 1000000)
        begin
        counter <= 0;

        //Initialize and Configure the LCD the LCD
        if(state == 3'b000)
        begin
            if(steps == 0)
            begin
                LCD_E <= 0;
                steps <= 1;
            end
            
            else if(steps == 1)
            begin
                {LCD_RS, LCD_W, data[3], data[2], data[1], data[0]} <= init_ROM[init_ROM_index];
                steps <= 2;	
            end

            else if(steps == 2)
            begin
                if (init_ROM_index == 14)
                begin
                    state <= 3'b001;
                    steps <= 0;
                end

                LCD_E <= 1;
                steps <= 0;
                init_ROM_index <= init_ROM_index + 1;
            end
        end

        else if(state == 3'b001)
        begin

            if(steps == 0)
            begin
                LCD_E <= 0;
                steps <= 1;
            end

            else if(steps == 1)
            begin
                {LCD_RS, LCD_W, data[3], data[2], data[1], data[0]} = {2'h2, first_line[first_line_index], first_line[first_line_index - 1], first_line[first_line_index - 2], first_line[first_line_index - 3]};
                steps <= 2;
            end

            else if(steps == 2)
            begin
                //End of First Line
                if (first_line_index == 3)
                begin
                    state <= 3'b010;
                    steps <= 0;
                    line_break_steps <= 0;
                end
                LCD_E <= 1;
                steps <= 0;
                first_line_index <= first_line_index - 4;
            end
            counter = 0;
        end


        //Line Break  
        else if(state == 3'b010)
        begin
            if(line_break_steps == 0)
            begin
                LCD_E <= 0;
                line_break_steps <= 1;
            end

            else if(line_break_steps == 1)
            begin
                {LCD_RS, LCD_W, data[3], data[2], data[1], data[0]} <= 6'h0c;
                line_break_steps <= 2;
            end

            else if(line_break_steps == 2)
            begin
                LCD_E <= 1;
                line_break_steps <= 3;
            end

            else if(line_break_steps == 3)
            begin
                LCD_E <= 0;
                line_break_steps <= 4;
            end

            else if(line_break_steps == 4)
            begin
                {LCD_RS, LCD_W, data[3], data[2], data[1], data[0]} <= 6'h00;
                line_break_steps <= 5;
            end

            else if(line_break_steps == 5)
            begin
                LCD_E <= 0;
                state <= 3'b011;
                line_break_steps <= 6;
            end
        end


        //Second Line
        else if(state == 3'b011 )
        begin
            if(steps == 0)
            begin
                LCD_E <= 0;
                steps <= 1;
            end

            else if(steps == 1)
            begin
                {LCD_RS, LCD_W, data[3], data[2], data[1], data[0]} = {2'h2, second_line[second_line_index], second_line[second_line_index-1], second_line[second_line_index-2], second_line[second_line_index-3]};
                steps <= 2;	
            end

            else if(steps == 2)
            begin
                if (second_line_index == 3)
                begin
                    state <= 3'b100;
                    steps <= 0;
                end
                LCD_E <= 1;
                steps <= 0;
                second_line_index <= second_line_index - 4;
            end
            counter <= 0;
        end	
        end
        else
        begin
            counter <= counter + 1;
        end
    end
endmodule




