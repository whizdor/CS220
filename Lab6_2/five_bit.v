module five_bit_adder_subtractor(x,y,num,sum_x,sum_y)
    input [3:0] x,y;
    output [4:0] sum_x,sum_y;
    wire [4:0] sum_x.sum_y;

    wire op;
    reg[1:0] addx_r, addy_r;
    wire[1:0] addx,addy;
    wire[4:0] coutx, couty;

    assign op = num[1];
    always begin
        if(num[2] == 0) begin
            addx_r <= {0,0};
            addy_r <= {num[3],num[2]};
        end
        elseif (num[2] == 1) begin
            addy_r <= {0,0};
            addx_r <= {num[3],num[2]};
        end
    end

    assign addx = addx_r;
    assign addy = addy_r;

    full_operator FA0(x[0],addx[0],op, op,sum_x[0], coutx[0]);
    full_operator FA1(x[1],addx[1],coutx[0], op,sum_x[1], coutx[1]);
    full_operator FA2(x[2],1'b0,coutx[1], op,sum_x[2], coutx[2]);
    full_operator FA3(x[3],1'b0,coutx[2], op,sum_x[3], coutx[3]);
    full_operator FA4(1'b0,1'b0,coutx[3], op,sum_x[4], coutx[4]);


    full_operator FA5(x[0],addx[0],op, op,sum_x[0], coutx[0]);
    full_operator FA6(x[1],addx[1],coutx[0], op,sum_x[1], coutx[1]);
    full_operator FA7(x[2],1'b0,coutx[1], op,sum_x[2], coutx[2]);
    full_operator FA8(x[3],1'b0,coutx[2], op,sum_x[3], coutx[3]);
    full_operator FA9(1'b0,1'b0,coutx[3], op,sum_x[4], coutx[4]);




endmodule