`timescale 1ns / 1ps


module LCD_Driver_main(first_line, second_line, clk, lcd_e, lcd_w, lcd_rs, data);

    //Input
    input [127:0] second_line;
    input [127:0] first_line;
    input clk;

    //Output
    output lcd_e, lcd_w, lcd_rs;
    output [3:0] data;
    reg lcd_e, lcd_w, lcd_rs;
    reg [3:0] data;

    //Internal Variables
    reg [20:0] counter;
    reg [2:0] state;
    reg [1:0] steps;
    reg [2:0] line_break_steps;
    reg [7:0] index1,first_line_index,second_line_index;

    initial 
    begin
        steps = 0;
        state = 0;
        counter = 0;
        index1 = 55; 
        first_line_index = 127;
        second_line_index = 127; 
        line_break_steps = 0;
    end

    wire[55:0] config_data;
    assign config_data=56'h333228060C0180;

    always @(posedge clk)
    begin
        //Increment the Counter
        if(counter == 1000000)
        begin
        counter <= 0;

        //Step 1 : Initialize the LCD
        if(state==3'b000)
        begin
            if(steps == 2'b00)
            begin
                lcd_e <= 0;
                steps <= steps + 1;
            end
            
            else if(steps == 2'b01)
            begin
                lcd_rs <= 0;
                lcd_w <= 0;
                data[3] <= config_data[index1];
                data[2] <= config_data[index1-1];
                data[1] <= config_data[index1-2];
                data[0] <= config_data[index1-3];
                steps <= steps + 1;	
            end

            else if(steps == 2'b10)
            begin
                
                if (index1 == 3)
                begin
                    state <= 3'b001;
                    steps <= 0;
                end

                lcd_e <= 1;
                steps <= 0;
                index1 <= index1-4;
            end
        end

        else if(state == 3'b001)
        begin

            if(steps == 2'b00)
            begin
                lcd_e <= 0;
                steps <= steps + 1;
            end

            else if(steps == 2'b01)
            begin
                lcd_rs <= 1;
                lcd_w <= 0;
                data[3] <= first_line[first_line_index];
                data[2] <= first_line[first_line_index - 1];
                data[1] <= first_line[first_line_index - 2];
                data[0] <= first_line[first_line_index - 3];
                steps <= steps + 1;
            end

            else if(steps == 2'b10)
            begin
                //End of First Line
                if (first_line_index == 3)
                begin
                    state <= 3'b010;
                    steps <= 0;
                    line_break_steps <= 0;
                end
                lcd_e <= 1;
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
                lcd_e <= 0;
                line_break_steps <= 1;
            end

            else if(line_break_steps == 1)
            begin
                {lcd_rs, lcd_w, data[3], data[2], data[1], data[0]} <= 6'h0c;
                line_break_steps <= 2;
            end

            else if(line_break_steps == 2)
            begin
                lcd_e <= 1;
                line_break_steps <= 3;
            end

            else if(line_break_steps == 3)
            begin
                lcd_e <= 0;
                line_break_steps <= 4;
            end

            else if(line_break_steps == 4)
            begin
                {lcd_rs, lcd_w, data[3], data[2], data[1], data[0]} <= 6'h00;
                line_break_steps <= 5;
            end

            else if(line_break_steps == 5)
            begin
                lcd_e <= 0;
                state <= 3'b011;
                line_break_steps <= 6;
            end
        end


        //Second Line
        else if(state == 3'b011 )
        begin
            if(steps == 2'b00)
            begin
                lcd_e <= 0;
                steps <= steps+1;
            end
            else if(steps == 2'b01)
            begin
                lcd_rs <= 1;
                lcd_w <= 0;
                data[3] <= second_line[second_line_index];
                data[2] <= second_line[second_line_index-1];
                data[1] <= second_line[second_line_index-2];
                data[0] <= second_line[second_line_index-3];
                steps <= steps+1;	
            end
            else if(steps == 2'b10)
            begin
                if (second_line_index == 3)
                begin
                    state <= 3'b100;
                end
                lcd_e <= 1;
                steps <= 0;
                second_line_index <= second_line_index-4;
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




