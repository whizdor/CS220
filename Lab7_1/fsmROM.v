module fsmROM(clk, y, current_state, final_state)
    //Inputs
    input clk;
    input [1:0]y;
    input [3:0]current_state;

    //Outputs
    output [3:0]final_state;
    reg [3:0]final_state;

    //Microcode ROM
    //12 rows, and 3 bit outputs.
    reg [2:0] microcode_rom[12:0];

    //Dispatch ROM (2 needed for states S3 and S10)
    reg [3:0] dispatch_rom1[3:0]; 
    reg [3:0] dispatch_rom2[3:0]; 

    reg counter = 0;

    initial begin
        dispatch_rom1[0] <= 4'b0100;
        dispatch_rom1[1] <= 4'b0101;
        dispatch_rom1[2] <= 4'b0110;
        dispatch_rom1[3] <= 4'b0110;

        dispatch_rom2[0] <= 4'b1011;
        dispatch_rom2[1] <= 4'b1100;
        dispatch_rom2[2] <= 4'b1100;
        dispatch_rom2[3] <= 4'b1100;

        //Incrementer
        microcode_rom[0] <= 3'b000;
        microcode_rom[1] <= 3'b000;
        microcode_rom[2] <= 3'b000;
        microcode_rom[6] <= 3'b000;
        microcode_rom[7] <= 3'b000;
        microcode_rom[8] <= 3'b000;
        microcode_rom[9] <= 3'b000;
        //Dispatch ROMS
        microcode_rom[3] <= 3'b001;
        microcode_rom[10] <= 3'b010;
        //Default States
        microcode_rom[4] <= 3'b011;
        microcode_rom[5] <= 3'b011;
        microcode_rom[11] <= 3'b100;
        microcode_rom[12] <= 3'b100;
    end

    always @(posedge clk) begin
        if(microcode_rom[current_state] == 3'b000) begin
            final_state <= current_state + 1;
        end
        else if(microcode_rom[current_state] == 3'b001) begin
            final_state <= dispatch_rom1[y];
        end
        else if(microcode_rom[current_state] == 3'b010) begin
            final_state <= dispatch_rom2[y];
        end
        else if(microcode_rom[current_state] == 3'b011) begin
            final_state <= 4'b0111;
        end
        else if(microcode_rom[current_state] == 3'b100) begin
            final_state <= 4'b0000;
        end
    end

endmodule