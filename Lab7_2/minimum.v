module minimum(a,b,c,d,minimum);
    //Inputs
    input [2:0] a;
    input [2:0] b;
    input [2:0] c;
    input [2:0] d;

    //Outputs
    output [1:0] minimum;
    reg [1:0] minimum;

    always@(a,b,c,d) begin
        if(a < b && a < c && a < d) begin
            minimum <= 0;
        end
        else if(b < a && b < c && b < d) begin
            minimum <= 1;
        end
        else if(c < a && c < b && c < d) begin
            minimum <= 2;
        end
        else begin
            minimum <= 3;
        end
    end
endmodule