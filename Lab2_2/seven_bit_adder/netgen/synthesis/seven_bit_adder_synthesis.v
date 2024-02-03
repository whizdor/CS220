////////////////////////////////////////////////////////////////////////////////
// Copyright (c) 1995-2013 Xilinx, Inc.  All rights reserved.
////////////////////////////////////////////////////////////////////////////////
//   ____  ____
//  /   /\/   /
// /___/  \  /    Vendor: Xilinx
// \   \   \/     Version: P.20131013
//  \   \         Application: netgen
//  /   /         Filename: seven_bit_adder_synthesis.v
// /___/   /\     Timestamp: Wed Jan 24 15:33:49 2024
// \   \  /  \ 
//  \___\/\___\
//             
// Command	: -intstyle ise -insert_glbl true -w -dir netgen/synthesis -ofmt verilog -sim seven_bit_adder.ngc seven_bit_adder_synthesis.v 
// Device	: xc3s500e-4-fg320
// Input file	: seven_bit_adder.ngc
// Output file	: /media/aditikh22/HP USB20FD/CS220/Lab2_2/seven_bit_adder/netgen/synthesis/seven_bit_adder_synthesis.v
// # of Modules	: 1
// Design Name	: seven_bit_adder
// Xilinx        : /opt/Xilinx/14.7/ISE_DS/ISE/
//             
// Purpose:    
//     This verilog netlist is a verification model and uses simulation 
//     primitives which may not represent the true implementation of the 
//     device, however the netlist is functionally correct and should not 
//     be modified. This file cannot be synthesized and should only be used 
//     with supported simulation tools.
//             
// Reference:  
//     Command Line Tools User Guide, Chapter 23 and Synthesis and Simulation Design Guide, Chapter 6
//             
////////////////////////////////////////////////////////////////////////////////

`timescale 1 ns/1 ps

module seven_bit_adder (
  cout, PB1, PB2, PB3, PB4, sum, a
);
  output cout;
  input PB1;
  input PB2;
  input PB3;
  input PB4;
  output [6 : 0] sum;
  input [3 : 0] a;
  wire PB1_BUFGP_1;
  wire PB2_BUFGP_3;
  wire PB3_BUFGP_5;
  wire PB4_BUFGP_7;
  wire a_0_IBUF_12;
  wire a_1_IBUF_13;
  wire a_2_IBUF_14;
  wire a_3_IBUF_15;
  wire cout_OBUF_22;
  wire sum_0_OBUF_30;
  wire sum_1_OBUF_31;
  wire sum_2_OBUF_32;
  wire sum_3_OBUF_33;
  wire sum_4_OBUF_34;
  wire sum_5_OBUF_35;
  wire sum_6_OBUF_36;
  wire [5 : 1] cintermediate;
  wire [6 : 0] x;
  wire [6 : 0] y;
  FD   x_2 (
    .C(PB1_BUFGP_1),
    .D(a_2_IBUF_14),
    .Q(x[2])
  );
  FD   x_3 (
    .C(PB1_BUFGP_1),
    .D(a_3_IBUF_15),
    .Q(x[3])
  );
  FD   x_1 (
    .C(PB1_BUFGP_1),
    .D(a_1_IBUF_13),
    .Q(x[1])
  );
  FD   x_0 (
    .C(PB1_BUFGP_1),
    .D(a_0_IBUF_12),
    .Q(x[0])
  );
  FD   x_4 (
    .C(PB2_BUFGP_3),
    .D(a_0_IBUF_12),
    .Q(x[4])
  );
  FD   x_6 (
    .C(PB2_BUFGP_3),
    .D(a_2_IBUF_14),
    .Q(x[6])
  );
  FD   x_5 (
    .C(PB2_BUFGP_3),
    .D(a_1_IBUF_13),
    .Q(x[5])
  );
  FD   y_3 (
    .C(PB3_BUFGP_5),
    .D(a_3_IBUF_15),
    .Q(y[3])
  );
  FD   y_2 (
    .C(PB3_BUFGP_5),
    .D(a_2_IBUF_14),
    .Q(y[2])
  );
  FD   y_6 (
    .C(PB4_BUFGP_7),
    .D(a_2_IBUF_14),
    .Q(y[6])
  );
  FD   y_1 (
    .C(PB3_BUFGP_5),
    .D(a_1_IBUF_13),
    .Q(y[1])
  );
  FD   y_0 (
    .C(PB3_BUFGP_5),
    .D(a_0_IBUF_12),
    .Q(y[0])
  );
  FD   y_5 (
    .C(PB4_BUFGP_7),
    .D(a_1_IBUF_13),
    .Q(y[5])
  );
  FD   y_4 (
    .C(PB4_BUFGP_7),
    .D(a_0_IBUF_12),
    .Q(y[4])
  );
  LUT2 #(
    .INIT ( 4'h6 ))
  \FA0/Mxor_sum_xo<0>1  (
    .I0(x[0]),
    .I1(y[0]),
    .O(sum_0_OBUF_30)
  );
  LUT4 #(
    .INIT ( 16'h9666 ))
  \FA1/Mxor_sum_xo<0>1  (
    .I0(y[1]),
    .I1(x[1]),
    .I2(x[0]),
    .I3(y[0]),
    .O(sum_1_OBUF_31)
  );
  LUT3 #(
    .INIT ( 8'h96 ))
  \FA2/Mxor_sum_xo<0>1  (
    .I0(cintermediate[1]),
    .I1(x[2]),
    .I2(y[2]),
    .O(sum_2_OBUF_32)
  );
  LUT3 #(
    .INIT ( 8'h96 ))
  \FA3/Mxor_sum_xo<0>1  (
    .I0(cintermediate[2]),
    .I1(x[3]),
    .I2(y[3]),
    .O(sum_3_OBUF_33)
  );
  LUT3 #(
    .INIT ( 8'h96 ))
  \FA4/Mxor_sum_xo<0>1  (
    .I0(cintermediate[3]),
    .I1(x[4]),
    .I2(y[4]),
    .O(sum_4_OBUF_34)
  );
  LUT3 #(
    .INIT ( 8'h96 ))
  \FA5/Mxor_sum_xo<0>1  (
    .I0(cintermediate[4]),
    .I1(x[5]),
    .I2(y[5]),
    .O(sum_5_OBUF_35)
  );
  LUT3 #(
    .INIT ( 8'hE8 ))
  \FA6/cout1  (
    .I0(x[6]),
    .I1(y[6]),
    .I2(cintermediate[5]),
    .O(cout_OBUF_22)
  );
  LUT3 #(
    .INIT ( 8'hE8 ))
  \FA5/cout1  (
    .I0(x[5]),
    .I1(y[5]),
    .I2(cintermediate[4]),
    .O(cintermediate[5])
  );
  LUT3 #(
    .INIT ( 8'hE8 ))
  \FA4/cout1  (
    .I0(x[4]),
    .I1(y[4]),
    .I2(cintermediate[3]),
    .O(cintermediate[4])
  );
  LUT3 #(
    .INIT ( 8'hE8 ))
  \FA3/cout1  (
    .I0(x[3]),
    .I1(y[3]),
    .I2(cintermediate[2]),
    .O(cintermediate[3])
  );
  LUT3 #(
    .INIT ( 8'hE8 ))
  \FA2/cout1  (
    .I0(x[2]),
    .I1(y[2]),
    .I2(cintermediate[1]),
    .O(cintermediate[2])
  );
  LUT3 #(
    .INIT ( 8'h96 ))
  \FA6/Mxor_sum_xo<0>1  (
    .I0(cintermediate[5]),
    .I1(x[6]),
    .I2(y[6]),
    .O(sum_6_OBUF_36)
  );
  LUT4 #(
    .INIT ( 16'hEA80 ))
  \FA1/cout1  (
    .I0(x[1]),
    .I1(x[0]),
    .I2(y[0]),
    .I3(y[1]),
    .O(cintermediate[1])
  );
  IBUF   a_3_IBUF (
    .I(a[3]),
    .O(a_3_IBUF_15)
  );
  IBUF   a_2_IBUF (
    .I(a[2]),
    .O(a_2_IBUF_14)
  );
  IBUF   a_1_IBUF (
    .I(a[1]),
    .O(a_1_IBUF_13)
  );
  IBUF   a_0_IBUF (
    .I(a[0]),
    .O(a_0_IBUF_12)
  );
  OBUF   cout_OBUF (
    .I(cout_OBUF_22),
    .O(cout)
  );
  OBUF   sum_6_OBUF (
    .I(sum_6_OBUF_36),
    .O(sum[6])
  );
  OBUF   sum_5_OBUF (
    .I(sum_5_OBUF_35),
    .O(sum[5])
  );
  OBUF   sum_4_OBUF (
    .I(sum_4_OBUF_34),
    .O(sum[4])
  );
  OBUF   sum_3_OBUF (
    .I(sum_3_OBUF_33),
    .O(sum[3])
  );
  OBUF   sum_2_OBUF (
    .I(sum_2_OBUF_32),
    .O(sum[2])
  );
  OBUF   sum_1_OBUF (
    .I(sum_1_OBUF_31),
    .O(sum[1])
  );
  OBUF   sum_0_OBUF (
    .I(sum_0_OBUF_30),
    .O(sum[0])
  );
  BUFGP   PB1_BUFGP (
    .I(PB1),
    .O(PB1_BUFGP_1)
  );
  BUFGP   PB3_BUFGP (
    .I(PB3),
    .O(PB3_BUFGP_5)
  );
  BUFGP   PB2_BUFGP (
    .I(PB2),
    .O(PB2_BUFGP_3)
  );
  BUFGP   PB4_BUFGP (
    .I(PB4),
    .O(PB4_BUFGP_7)
  );
endmodule


`ifndef GLBL
`define GLBL

`timescale  1 ps / 1 ps

module glbl ();

    parameter ROC_WIDTH = 100000;
    parameter TOC_WIDTH = 0;

//--------   STARTUP Globals --------------
    wire GSR;
    wire GTS;
    wire GWE;
    wire PRLD;
    tri1 p_up_tmp;
    tri (weak1, strong0) PLL_LOCKG = p_up_tmp;

    wire PROGB_GLBL;
    wire CCLKO_GLBL;

    reg GSR_int;
    reg GTS_int;
    reg PRLD_int;

//--------   JTAG Globals --------------
    wire JTAG_TDO_GLBL;
    wire JTAG_TCK_GLBL;
    wire JTAG_TDI_GLBL;
    wire JTAG_TMS_GLBL;
    wire JTAG_TRST_GLBL;

    reg JTAG_CAPTURE_GLBL;
    reg JTAG_RESET_GLBL;
    reg JTAG_SHIFT_GLBL;
    reg JTAG_UPDATE_GLBL;
    reg JTAG_RUNTEST_GLBL;

    reg JTAG_SEL1_GLBL = 0;
    reg JTAG_SEL2_GLBL = 0 ;
    reg JTAG_SEL3_GLBL = 0;
    reg JTAG_SEL4_GLBL = 0;

    reg JTAG_USER_TDO1_GLBL = 1'bz;
    reg JTAG_USER_TDO2_GLBL = 1'bz;
    reg JTAG_USER_TDO3_GLBL = 1'bz;
    reg JTAG_USER_TDO4_GLBL = 1'bz;

    assign (weak1, weak0) GSR = GSR_int;
    assign (weak1, weak0) GTS = GTS_int;
    assign (weak1, weak0) PRLD = PRLD_int;

    initial begin
	GSR_int = 1'b1;
	PRLD_int = 1'b1;
	#(ROC_WIDTH)
	GSR_int = 1'b0;
	PRLD_int = 1'b0;
    end

    initial begin
	GTS_int = 1'b1;
	#(TOC_WIDTH)
	GTS_int = 1'b0;
    end

endmodule

`endif

