/////////////////////////////////////////////////////////////
// Created by: Synopsys DC Expert(TM) in wire load mode
// Version   : K-2015.06-SP1
// Date      : Thu Dec  1 13:11:40 2016
/////////////////////////////////////////////////////////////


module avalon_controller_DW01_add_0 ( A, B, CI, SUM, CO );
  input [10:0] A;
  input [10:0] B;
  output [10:0] SUM;
  input CI;
  output CO;
  wire   n1, n2, n3, n4;
  wire   [10:1] carry;

  FAX1 U1_9 ( .A(A[9]), .B(B[9]), .C(carry[9]), .YC(carry[10]), .YS(SUM[9]) );
  FAX1 U1_8 ( .A(A[8]), .B(B[8]), .C(carry[8]), .YC(carry[9]), .YS(SUM[8]) );
  FAX1 U1_7 ( .A(A[7]), .B(B[7]), .C(carry[7]), .YC(carry[8]), .YS(SUM[7]) );
  FAX1 U1_6 ( .A(A[6]), .B(B[6]), .C(carry[6]), .YC(carry[7]), .YS(SUM[6]) );
  FAX1 U1_5 ( .A(A[5]), .B(B[5]), .C(carry[5]), .YC(carry[6]), .YS(SUM[5]) );
  FAX1 U1_4 ( .A(A[4]), .B(B[4]), .C(carry[4]), .YC(carry[5]), .YS(SUM[4]) );
  FAX1 U1_3 ( .A(A[3]), .B(B[3]), .C(carry[3]), .YC(carry[4]), .YS(SUM[3]) );
  FAX1 U1_2 ( .A(A[2]), .B(B[2]), .C(n1), .YC(carry[3]), .YS(SUM[2]) );
  XOR2X1 U1 ( .A(A[10]), .B(carry[10]), .Y(SUM[10]) );
  INVX2 U2 ( .A(n3), .Y(n1) );
  INVX2 U3 ( .A(n4), .Y(n2) );
  AOI22X1 U4 ( .A(A[1]), .B(B[1]), .C(B[0]), .D(n2), .Y(n3) );
  OAI21X1 U5 ( .A(A[1]), .B(B[1]), .C(A[0]), .Y(n4) );
endmodule


module avalon_controller ( clk, n_rst, write, read, beginbursttransfer, 
        burstcount, address, writedata, done_calc, done_burst, readdatavalid, 
        writeresponsevalid, output_address, end_wait, count_ena, w_ena, 
        response );
  input [9:0] burstcount;
  input [10:0] address;
  input [31:0] writedata;
  output [10:0] output_address;
  output [1:0] response;
  input clk, n_rst, write, read, beginbursttransfer, done_calc, done_burst;
  output readdatavalid, writeresponsevalid, end_wait, count_ena, w_ena;
  wire   N91, N92, N93, N94, N95, N96, N97, N98, N99, n105, n106, n107, n108,
         n1, n2, n3, n4, n6, n7, n8, n9, n10, n11, n12, n13, n14, n15, n16,
         n17, n18, n34, n35, n36, n37, n38, n39, n40, n41, n42, n43, n44, n45,
         n46, n47, n48, n49, n50, n51, n52, n53, n54, n55, n56, n57, n58, n59,
         n60, n61, n62, n63, n64, n65, n66, n67, n68, n69, n70, n71, n72, n73,
         n74, n75, n76, n77, n78, n79, n80, n81, n82, n83, n84, n85, n86, n87,
         n88, n89, n90, n91, n92, n93, n94, n95, n96;
  wire   [4:0] state;
  wire   SYNOPSYS_UNCONNECTED__0, SYNOPSYS_UNCONNECTED__1;
  assign response[0] = 1'b0;
  assign response[1] = 1'b0;

  DFFSR \state_reg[0]  ( .D(n108), .CLK(clk), .R(n_rst), .S(1'b1), .Q(state[0]) );
  DFFSR \state_reg[1]  ( .D(n107), .CLK(clk), .R(n_rst), .S(1'b1), .Q(state[1]) );
  DFFSR \state_reg[3]  ( .D(n105), .CLK(clk), .R(n_rst), .S(1'b1), .Q(state[3]) );
  DFFSR \state_reg[2]  ( .D(n106), .CLK(clk), .R(n_rst), .S(1'b1), .Q(state[2]) );
  DFFSR \output_address_reg[0]  ( .D(n96), .CLK(clk), .R(n_rst), .S(1'b1), .Q(
        output_address[0]) );
  DFFSR \output_address_reg[1]  ( .D(n95), .CLK(clk), .R(n_rst), .S(1'b1), .Q(
        output_address[1]) );
  DFFSR \output_address_reg[2]  ( .D(n94), .CLK(clk), .R(n_rst), .S(1'b1), .Q(
        output_address[2]) );
  DFFSR \output_address_reg[3]  ( .D(n93), .CLK(clk), .R(n_rst), .S(1'b1), .Q(
        output_address[3]) );
  DFFSR \output_address_reg[4]  ( .D(n92), .CLK(clk), .R(n_rst), .S(1'b1), .Q(
        output_address[4]) );
  DFFSR \output_address_reg[5]  ( .D(n91), .CLK(clk), .R(n_rst), .S(1'b1), .Q(
        output_address[5]) );
  DFFSR \output_address_reg[6]  ( .D(n90), .CLK(clk), .R(n_rst), .S(1'b1), .Q(
        output_address[6]) );
  DFFSR \output_address_reg[7]  ( .D(n89), .CLK(clk), .R(n_rst), .S(1'b1), .Q(
        output_address[7]) );
  DFFSR \output_address_reg[8]  ( .D(n88), .CLK(clk), .R(n_rst), .S(1'b1), .Q(
        output_address[8]) );
  DFFSR \output_address_reg[9]  ( .D(n87), .CLK(clk), .R(n_rst), .S(1'b1), .Q(
        output_address[9]) );
  DFFSR \output_address_reg[10]  ( .D(n86), .CLK(clk), .R(n_rst), .S(1'b1), 
        .Q(output_address[10]) );
  avalon_controller_DW01_add_0 add_74 ( .A(address), .B({1'b0, burstcount}), 
        .CI(1'b0), .SUM({N99, N98, N97, N96, N95, N94, N93, N92, N91, 
        SYNOPSYS_UNCONNECTED__0, SYNOPSYS_UNCONNECTED__1}) );
  INVX2 U4 ( .A(n18), .Y(n2) );
  INVX1 U5 ( .A(n1), .Y(n86) );
  MUX2X1 U6 ( .B(address[10]), .A(output_address[10]), .S(n2), .Y(n1) );
  INVX1 U7 ( .A(n3), .Y(n87) );
  MUX2X1 U23 ( .B(address[9]), .A(output_address[9]), .S(n2), .Y(n3) );
  INVX1 U24 ( .A(n4), .Y(n88) );
  MUX2X1 U25 ( .B(address[8]), .A(output_address[8]), .S(n2), .Y(n4) );
  INVX1 U26 ( .A(n6), .Y(n89) );
  MUX2X1 U27 ( .B(address[7]), .A(output_address[7]), .S(n2), .Y(n6) );
  INVX1 U28 ( .A(n7), .Y(n90) );
  MUX2X1 U29 ( .B(address[6]), .A(output_address[6]), .S(n2), .Y(n7) );
  INVX1 U30 ( .A(n8), .Y(n91) );
  MUX2X1 U31 ( .B(address[5]), .A(output_address[5]), .S(n2), .Y(n8) );
  INVX1 U32 ( .A(n9), .Y(n92) );
  MUX2X1 U33 ( .B(address[4]), .A(output_address[4]), .S(n2), .Y(n9) );
  INVX1 U34 ( .A(n10), .Y(n93) );
  MUX2X1 U35 ( .B(address[3]), .A(output_address[3]), .S(n2), .Y(n10) );
  INVX1 U36 ( .A(n11), .Y(n94) );
  MUX2X1 U37 ( .B(address[2]), .A(output_address[2]), .S(n2), .Y(n11) );
  INVX1 U38 ( .A(n12), .Y(n95) );
  MUX2X1 U39 ( .B(address[1]), .A(output_address[1]), .S(n2), .Y(n12) );
  INVX1 U40 ( .A(n13), .Y(n96) );
  MUX2X1 U41 ( .B(address[0]), .A(output_address[0]), .S(n2), .Y(n13) );
  INVX1 U42 ( .A(n14), .Y(count_ena) );
  INVX1 U43 ( .A(n15), .Y(readdatavalid) );
  INVX1 U44 ( .A(n16), .Y(writeresponsevalid) );
  OAI21X1 U45 ( .A(n17), .B(n18), .C(n34), .Y(n108) );
  AND2X1 U46 ( .A(n35), .B(n36), .Y(n34) );
  OAI21X1 U47 ( .A(n37), .B(n38), .C(n39), .Y(n35) );
  OAI21X1 U48 ( .A(write), .B(n40), .C(n41), .Y(n38) );
  OAI21X1 U49 ( .A(n42), .B(n43), .C(n44), .Y(n107) );
  OAI21X1 U50 ( .A(n45), .B(n37), .C(n39), .Y(n44) );
  OAI21X1 U51 ( .A(n46), .B(n40), .C(n14), .Y(n37) );
  AND2X1 U52 ( .A(n47), .B(n48), .Y(n46) );
  INVX1 U53 ( .A(n49), .Y(n45) );
  INVX1 U54 ( .A(state[1]), .Y(n42) );
  OAI21X1 U55 ( .A(n50), .B(n43), .C(n51), .Y(n106) );
  OAI21X1 U56 ( .A(n52), .B(n53), .C(n39), .Y(n51) );
  NAND2X1 U57 ( .A(n54), .B(n55), .Y(n39) );
  INVX1 U58 ( .A(n40), .Y(n55) );
  AOI21X1 U59 ( .A(read), .B(n47), .C(write), .Y(n54) );
  INVX1 U60 ( .A(beginbursttransfer), .Y(n47) );
  NAND2X1 U61 ( .A(n41), .B(n14), .Y(n53) );
  NOR2X1 U62 ( .A(n40), .B(n56), .Y(n52) );
  MUX2X1 U63 ( .B(n57), .A(n58), .S(beginbursttransfer), .Y(n56) );
  NAND3X1 U64 ( .A(N98), .B(n59), .C(N99), .Y(n58) );
  NAND2X1 U65 ( .A(n60), .B(n61), .Y(n59) );
  NOR2X1 U66 ( .A(N97), .B(N96), .Y(n61) );
  AOI21X1 U67 ( .A(N94), .B(n62), .C(N95), .Y(n60) );
  INVX1 U68 ( .A(n63), .Y(n62) );
  AOI21X1 U69 ( .A(N92), .B(N91), .C(N93), .Y(n63) );
  AND2X1 U70 ( .A(n48), .B(write), .Y(n57) );
  MUX2X1 U71 ( .B(n64), .A(n65), .S(address[9]), .Y(n48) );
  AOI21X1 U72 ( .A(n66), .B(n67), .C(n68), .Y(n65) );
  INVX1 U73 ( .A(address[10]), .Y(n68) );
  AOI21X1 U74 ( .A(address[5]), .B(n69), .C(address[6]), .Y(n66) );
  INVX1 U75 ( .A(n70), .Y(n69) );
  AOI21X1 U76 ( .A(address[3]), .B(address[2]), .C(address[4]), .Y(n70) );
  NOR2X1 U77 ( .A(n71), .B(n72), .Y(n64) );
  NAND3X1 U78 ( .A(n73), .B(n74), .C(n75), .Y(n72) );
  NOR2X1 U79 ( .A(address[10]), .B(address[0]), .Y(n75) );
  INVX1 U80 ( .A(address[1]), .Y(n74) );
  NOR2X1 U81 ( .A(address[3]), .B(address[2]), .Y(n73) );
  NAND3X1 U82 ( .A(n67), .B(n76), .C(n77), .Y(n71) );
  NOR2X1 U83 ( .A(address[5]), .B(address[4]), .Y(n77) );
  INVX1 U84 ( .A(address[6]), .Y(n76) );
  NOR2X1 U85 ( .A(address[8]), .B(address[7]), .Y(n67) );
  NAND3X1 U86 ( .A(n17), .B(n50), .C(n78), .Y(n40) );
  OAI21X1 U87 ( .A(n79), .B(n43), .C(n36), .Y(n105) );
  OR2X1 U88 ( .A(done_burst), .B(n80), .Y(n36) );
  NAND3X1 U89 ( .A(n15), .B(n14), .C(n2), .Y(n43) );
  NAND3X1 U90 ( .A(n41), .B(n49), .C(n81), .Y(n18) );
  AND2X1 U91 ( .A(n80), .B(n16), .Y(n81) );
  NAND3X1 U92 ( .A(state[1]), .B(state[2]), .C(n82), .Y(n80) );
  NOR2X1 U93 ( .A(state[3]), .B(n17), .Y(n82) );
  NAND3X1 U94 ( .A(n78), .B(n17), .C(state[2]), .Y(n41) );
  INVX1 U95 ( .A(state[3]), .Y(n79) );
  NAND3X1 U96 ( .A(n49), .B(n83), .C(n15), .Y(end_wait) );
  NAND3X1 U97 ( .A(state[1]), .B(n17), .C(n84), .Y(n15) );
  NOR2X1 U98 ( .A(state[3]), .B(state[2]), .Y(n84) );
  INVX1 U99 ( .A(state[0]), .Y(n17) );
  INVX1 U100 ( .A(w_ena), .Y(n83) );
  NAND2X1 U101 ( .A(n16), .B(n14), .Y(w_ena) );
  NAND3X1 U102 ( .A(state[3]), .B(state[0]), .C(n85), .Y(n14) );
  NOR2X1 U103 ( .A(state[2]), .B(state[1]), .Y(n85) );
  NAND3X1 U104 ( .A(n78), .B(state[0]), .C(state[2]), .Y(n16) );
  NAND3X1 U105 ( .A(state[0]), .B(n50), .C(n78), .Y(n49) );
  NOR2X1 U106 ( .A(state[3]), .B(state[1]), .Y(n78) );
  INVX1 U107 ( .A(state[2]), .Y(n50) );
endmodule


module flex_counter_NUM_CNT_BITS10_DW01_inc_0 ( A, SUM );
  input [9:0] A;
  output [9:0] SUM;

  wire   [9:2] carry;

  HAX1 U1_1_8 ( .A(A[8]), .B(carry[8]), .YC(carry[9]), .YS(SUM[8]) );
  HAX1 U1_1_7 ( .A(A[7]), .B(carry[7]), .YC(carry[8]), .YS(SUM[7]) );
  HAX1 U1_1_6 ( .A(A[6]), .B(carry[6]), .YC(carry[7]), .YS(SUM[6]) );
  HAX1 U1_1_5 ( .A(A[5]), .B(carry[5]), .YC(carry[6]), .YS(SUM[5]) );
  HAX1 U1_1_4 ( .A(A[4]), .B(carry[4]), .YC(carry[5]), .YS(SUM[4]) );
  HAX1 U1_1_3 ( .A(A[3]), .B(carry[3]), .YC(carry[4]), .YS(SUM[3]) );
  HAX1 U1_1_2 ( .A(A[2]), .B(carry[2]), .YC(carry[3]), .YS(SUM[2]) );
  HAX1 U1_1_1 ( .A(A[1]), .B(A[0]), .YC(carry[2]), .YS(SUM[1]) );
  INVX2 U1 ( .A(A[0]), .Y(SUM[0]) );
  XOR2X1 U2 ( .A(carry[9]), .B(A[9]), .Y(SUM[9]) );
endmodule


module flex_counter_NUM_CNT_BITS10 ( clk, n_rst, clear, count_enable, 
        rollover_val, count_out, rollover_flag );
  input [9:0] rollover_val;
  output [9:0] count_out;
  input clk, n_rst, clear, count_enable;
  output rollover_flag;
  wire   flag, N12, N13, N14, N15, N16, N17, N18, N19, N20, N21, N33, N34, N35,
         N36, N37, N38, N39, N40, N41, N42, n1, n2, n3, n4, n5, n6, n18, n19,
         n20, n21, n22, n23, n24, n25, n26, n27, n28, n29, n30, n31, n32, n33,
         n34, n35, n36, n37, n38, n39, n40, n41, n42, n43, n44, n45, n46, n47,
         n48, n49, n50, n51, n52, n53, n54, n55, n56, n57, n58, n59, n60, n61,
         n62, n63, n64, n65;
  wire   [9:0] next;

  DFFSR \count_out_reg[0]  ( .D(next[0]), .CLK(clk), .R(n_rst), .S(1'b1), .Q(
        count_out[0]) );
  DFFSR \count_out_reg[1]  ( .D(next[1]), .CLK(clk), .R(n_rst), .S(1'b1), .Q(
        count_out[1]) );
  DFFSR \count_out_reg[2]  ( .D(next[2]), .CLK(clk), .R(n_rst), .S(1'b1), .Q(
        count_out[2]) );
  DFFSR \count_out_reg[3]  ( .D(next[3]), .CLK(clk), .R(n_rst), .S(1'b1), .Q(
        count_out[3]) );
  DFFSR \count_out_reg[4]  ( .D(next[4]), .CLK(clk), .R(n_rst), .S(1'b1), .Q(
        count_out[4]) );
  DFFSR \count_out_reg[5]  ( .D(next[5]), .CLK(clk), .R(n_rst), .S(1'b1), .Q(
        count_out[5]) );
  DFFSR \count_out_reg[6]  ( .D(next[6]), .CLK(clk), .R(n_rst), .S(1'b1), .Q(
        count_out[6]) );
  DFFSR \count_out_reg[7]  ( .D(next[7]), .CLK(clk), .R(n_rst), .S(1'b1), .Q(
        count_out[7]) );
  DFFSR \count_out_reg[8]  ( .D(next[8]), .CLK(clk), .R(n_rst), .S(1'b1), .Q(
        count_out[8]) );
  DFFSR \count_out_reg[9]  ( .D(next[9]), .CLK(clk), .R(n_rst), .S(1'b1), .Q(
        count_out[9]) );
  DFFSR rollover_flag_reg ( .D(flag), .CLK(clk), .R(n_rst), .S(1'b1), .Q(
        rollover_flag) );
  flex_counter_NUM_CNT_BITS10_DW01_inc_0 add_46_aco ( .A({N42, N41, N40, N39, 
        N38, N37, N36, N35, N34, N33}), .SUM({N21, N20, N19, N18, N17, N16, 
        N15, N14, N13, N12}) );
  NOR2X1 U6 ( .A(clear), .B(n1), .Y(next[9]) );
  NOR2X1 U7 ( .A(clear), .B(n2), .Y(next[8]) );
  NOR2X1 U16 ( .A(clear), .B(n3), .Y(next[7]) );
  NOR2X1 U17 ( .A(clear), .B(n4), .Y(next[6]) );
  NOR2X1 U18 ( .A(clear), .B(n5), .Y(next[5]) );
  NOR2X1 U19 ( .A(clear), .B(n6), .Y(next[4]) );
  NOR2X1 U20 ( .A(clear), .B(n18), .Y(next[3]) );
  NOR2X1 U21 ( .A(clear), .B(n19), .Y(next[2]) );
  NOR2X1 U22 ( .A(clear), .B(n20), .Y(next[1]) );
  NOR2X1 U23 ( .A(clear), .B(n21), .Y(next[0]) );
  NOR2X1 U24 ( .A(n22), .B(n23), .Y(flag) );
  NAND3X1 U25 ( .A(n24), .B(n25), .C(n26), .Y(n23) );
  NOR2X1 U26 ( .A(n27), .B(n28), .Y(n26) );
  XNOR2X1 U27 ( .A(rollover_val[6]), .B(n4), .Y(n28) );
  MUX2X1 U28 ( .B(count_out[6]), .A(N18), .S(count_enable), .Y(n4) );
  XNOR2X1 U29 ( .A(rollover_val[8]), .B(n2), .Y(n27) );
  MUX2X1 U30 ( .B(count_out[8]), .A(N20), .S(count_enable), .Y(n2) );
  XOR2X1 U31 ( .A(rollover_val[5]), .B(n5), .Y(n25) );
  MUX2X1 U32 ( .B(count_out[5]), .A(N17), .S(count_enable), .Y(n5) );
  NOR2X1 U33 ( .A(n29), .B(n30), .Y(n24) );
  XNOR2X1 U34 ( .A(rollover_val[4]), .B(n6), .Y(n30) );
  MUX2X1 U35 ( .B(count_out[4]), .A(N16), .S(count_enable), .Y(n6) );
  XNOR2X1 U36 ( .A(rollover_val[7]), .B(n3), .Y(n29) );
  MUX2X1 U37 ( .B(count_out[7]), .A(N19), .S(count_enable), .Y(n3) );
  OR2X1 U38 ( .A(n31), .B(n32), .Y(n22) );
  NAND3X1 U39 ( .A(n33), .B(n34), .C(n35), .Y(n32) );
  XOR2X1 U40 ( .A(rollover_val[0]), .B(n21), .Y(n35) );
  MUX2X1 U41 ( .B(count_out[0]), .A(N12), .S(count_enable), .Y(n21) );
  XOR2X1 U42 ( .A(rollover_val[1]), .B(n20), .Y(n34) );
  MUX2X1 U43 ( .B(count_out[1]), .A(N13), .S(count_enable), .Y(n20) );
  XOR2X1 U44 ( .A(rollover_val[9]), .B(n1), .Y(n33) );
  MUX2X1 U45 ( .B(count_out[9]), .A(N21), .S(count_enable), .Y(n1) );
  NAND3X1 U46 ( .A(n36), .B(n37), .C(n38), .Y(n31) );
  XOR2X1 U47 ( .A(rollover_val[2]), .B(n19), .Y(n38) );
  MUX2X1 U48 ( .B(count_out[2]), .A(N14), .S(count_enable), .Y(n19) );
  INVX1 U49 ( .A(clear), .Y(n37) );
  XOR2X1 U50 ( .A(rollover_val[3]), .B(n18), .Y(n36) );
  MUX2X1 U51 ( .B(count_out[3]), .A(N15), .S(count_enable), .Y(n18) );
  NOR2X1 U52 ( .A(n39), .B(n40), .Y(N42) );
  INVX1 U53 ( .A(count_out[9]), .Y(n40) );
  NOR2X1 U54 ( .A(n39), .B(n41), .Y(N41) );
  INVX1 U55 ( .A(count_out[8]), .Y(n41) );
  NOR2X1 U56 ( .A(n39), .B(n42), .Y(N40) );
  INVX1 U57 ( .A(count_out[7]), .Y(n42) );
  NOR2X1 U58 ( .A(n39), .B(n43), .Y(N39) );
  INVX1 U59 ( .A(count_out[6]), .Y(n43) );
  NOR2X1 U60 ( .A(n39), .B(n44), .Y(N38) );
  INVX1 U61 ( .A(count_out[5]), .Y(n44) );
  NOR2X1 U62 ( .A(n39), .B(n45), .Y(N37) );
  INVX1 U63 ( .A(count_out[4]), .Y(n45) );
  NOR2X1 U64 ( .A(n39), .B(n46), .Y(N36) );
  INVX1 U65 ( .A(count_out[3]), .Y(n46) );
  NOR2X1 U66 ( .A(n39), .B(n47), .Y(N35) );
  INVX1 U67 ( .A(count_out[2]), .Y(n47) );
  NOR2X1 U68 ( .A(n39), .B(n48), .Y(N34) );
  INVX1 U69 ( .A(count_out[1]), .Y(n48) );
  NOR2X1 U70 ( .A(n39), .B(n49), .Y(N33) );
  INVX1 U71 ( .A(count_out[0]), .Y(n49) );
  AND2X1 U72 ( .A(n50), .B(n51), .Y(n39) );
  NOR2X1 U73 ( .A(n52), .B(n53), .Y(n51) );
  NAND2X1 U74 ( .A(n54), .B(n55), .Y(n53) );
  XNOR2X1 U75 ( .A(count_out[3]), .B(rollover_val[3]), .Y(n55) );
  XNOR2X1 U76 ( .A(count_out[4]), .B(rollover_val[4]), .Y(n54) );
  NAND3X1 U77 ( .A(n56), .B(n57), .C(n58), .Y(n52) );
  XNOR2X1 U78 ( .A(count_out[1]), .B(rollover_val[1]), .Y(n58) );
  XNOR2X1 U79 ( .A(count_out[2]), .B(rollover_val[2]), .Y(n57) );
  XNOR2X1 U80 ( .A(count_out[0]), .B(rollover_val[0]), .Y(n56) );
  NOR2X1 U81 ( .A(n59), .B(n60), .Y(n50) );
  NAND2X1 U82 ( .A(n61), .B(n62), .Y(n60) );
  XNOR2X1 U83 ( .A(count_out[8]), .B(rollover_val[8]), .Y(n62) );
  XNOR2X1 U84 ( .A(count_out[9]), .B(rollover_val[9]), .Y(n61) );
  NAND3X1 U85 ( .A(n63), .B(n64), .C(n65), .Y(n59) );
  XNOR2X1 U86 ( .A(count_out[6]), .B(rollover_val[6]), .Y(n65) );
  XNOR2X1 U87 ( .A(count_out[7]), .B(rollover_val[7]), .Y(n64) );
  XNOR2X1 U88 ( .A(count_out[5]), .B(rollover_val[5]), .Y(n63) );
endmodule


module avalon_interface_DW01_add_0 ( A, B, CI, SUM, CO );
  input [10:0] A;
  input [10:0] B;
  output [10:0] SUM;
  input CI;
  output CO;
  wire   n1;
  wire   [10:1] carry;

  FAX1 U1_9 ( .A(A[9]), .B(B[9]), .C(carry[9]), .YC(carry[10]), .YS(SUM[9]) );
  FAX1 U1_8 ( .A(A[8]), .B(B[8]), .C(carry[8]), .YC(carry[9]), .YS(SUM[8]) );
  FAX1 U1_7 ( .A(A[7]), .B(B[7]), .C(carry[7]), .YC(carry[8]), .YS(SUM[7]) );
  FAX1 U1_6 ( .A(A[6]), .B(B[6]), .C(carry[6]), .YC(carry[7]), .YS(SUM[6]) );
  FAX1 U1_5 ( .A(A[5]), .B(B[5]), .C(carry[5]), .YC(carry[6]), .YS(SUM[5]) );
  FAX1 U1_4 ( .A(A[4]), .B(B[4]), .C(carry[4]), .YC(carry[5]), .YS(SUM[4]) );
  FAX1 U1_3 ( .A(A[3]), .B(B[3]), .C(carry[3]), .YC(carry[4]), .YS(SUM[3]) );
  FAX1 U1_2 ( .A(A[2]), .B(B[2]), .C(carry[2]), .YC(carry[3]), .YS(SUM[2]) );
  FAX1 U1_1 ( .A(A[1]), .B(B[1]), .C(n1), .YC(carry[2]), .YS(SUM[1]) );
  AND2X2 U1 ( .A(B[0]), .B(A[0]), .Y(n1) );
  XOR2X1 U2 ( .A(A[10]), .B(carry[10]), .Y(SUM[10]) );
  XOR2X1 U3 ( .A(B[0]), .B(A[0]), .Y(SUM[0]) );
endmodule


module avalon_interface_DW01_add_1 ( A, B, CI, SUM, CO );
  input [10:0] A;
  input [10:0] B;
  output [10:0] SUM;
  input CI;
  output CO;
  wire   n1;
  wire   [10:1] carry;

  FAX1 U1_9 ( .A(A[9]), .B(B[9]), .C(carry[9]), .YC(carry[10]), .YS(SUM[9]) );
  FAX1 U1_8 ( .A(A[8]), .B(B[8]), .C(carry[8]), .YC(carry[9]), .YS(SUM[8]) );
  FAX1 U1_7 ( .A(A[7]), .B(B[7]), .C(carry[7]), .YC(carry[8]), .YS(SUM[7]) );
  FAX1 U1_6 ( .A(A[6]), .B(B[6]), .C(carry[6]), .YC(carry[7]), .YS(SUM[6]) );
  FAX1 U1_5 ( .A(A[5]), .B(B[5]), .C(carry[5]), .YC(carry[6]), .YS(SUM[5]) );
  FAX1 U1_4 ( .A(A[4]), .B(B[4]), .C(carry[4]), .YC(carry[5]), .YS(SUM[4]) );
  FAX1 U1_3 ( .A(A[3]), .B(B[3]), .C(carry[3]), .YC(carry[4]), .YS(SUM[3]) );
  FAX1 U1_2 ( .A(A[2]), .B(B[2]), .C(carry[2]), .YC(carry[3]), .YS(SUM[2]) );
  FAX1 U1_1 ( .A(A[1]), .B(B[1]), .C(n1), .YC(carry[2]), .YS(SUM[1]) );
  AND2X2 U1 ( .A(B[0]), .B(A[0]), .Y(n1) );
  XOR2X1 U2 ( .A(A[10]), .B(carry[10]), .Y(SUM[10]) );
  XOR2X1 U3 ( .A(B[0]), .B(A[0]), .Y(SUM[0]) );
endmodule


module avalon_interface ( clk, n_rst, write, read, beginbursttransfer, 
        burstcount, address, writedata, readdata, result_output, done_calc, 
        weight_address, pixel_address, w_enable_weights, w_enable_pixels, 
        readdatavalid, writeresponsevalid, store_data, output_address, 
        waitrequest, start_calc, response );
  input [9:0] burstcount;
  input [10:0] address;
  input [31:0] writedata;
  output [31:0] readdata;
  input [16:0] result_output;
  output [10:0] weight_address;
  output [10:0] pixel_address;
  output [15:0] store_data;
  output [3:0] output_address;
  output [1:0] response;
  input clk, n_rst, write, read, beginbursttransfer, done_calc;
  output w_enable_weights, w_enable_pixels, readdatavalid, writeresponsevalid,
         waitrequest, start_calc;
  wire   done_burst, end_wait, count_ena, w_ena, csr_2, csr_1, csr_0, N4, N5,
         N6, N7, N8, N9, N10, N11, N12, N13, N14, N85, N86, N87, N88, N89, N90,
         N91, N92, N93, N94, N95, N96, N97, N98, N99, N100, N101, N102, N103,
         N104, N105, N106, n168, n169, n170, n171, n172, n173, n174, n175,
         n176, n177, n178, n179, n180, n181, n182, n183, n184, n185, n186,
         n187, n188, n189, n190, n191, n192, n193, n194, n195, n196, n197,
         n198, n199, n200, n201, n202, n203, n204, n205, n206, n207, n208,
         n209, n210, n211, n212, n213, n214, n215, n216, n217, n218, n219,
         n220, n221, n222, n223, n224, n225, n226, n227, n228, n229, n230,
         n231, n232, n233, n234, n235, n236, n237, n238, n239, n240, n241,
         n242, n243, n244, n245, n246, n247, n248, n249, n250, n251, n252,
         n253, n254, n255, n256, n257, n258, n259, n260, n261, n262, n263,
         n264, n265, n266, n267, n268, n269, n270, n271, n272, n273, n274,
         n275, n276, n277, n278, n279, n280, n281, n282, n283, n284, n285,
         n286, n287, n288, n289, n290, n291, n292, n293, n294, n295, n296,
         n297, n298, n299, n300, n301, n302, n303, n304, n305, n306, n307,
         n308, n309, n310, n312;
  wire   [10:0] int_addr;
  wire   [9:0] cnt;
  wire   [31:4] csr;
  wire   [31:0] next_csr;
  assign response[1] = 1'b0;
  assign response[0] = 1'b0;

  LATCH \weight_address_reg[10]  ( .CLK(w_enable_weights), .D(N106), .Q(
        weight_address[10]) );
  LATCH \weight_address_reg[9]  ( .CLK(w_enable_weights), .D(N105), .Q(
        weight_address[9]) );
  LATCH \weight_address_reg[8]  ( .CLK(w_enable_weights), .D(N104), .Q(
        weight_address[8]) );
  LATCH \weight_address_reg[7]  ( .CLK(w_enable_weights), .D(N103), .Q(
        weight_address[7]) );
  LATCH \weight_address_reg[6]  ( .CLK(w_enable_weights), .D(N102), .Q(
        weight_address[6]) );
  LATCH \weight_address_reg[5]  ( .CLK(w_enable_weights), .D(N101), .Q(
        weight_address[5]) );
  LATCH \weight_address_reg[4]  ( .CLK(w_enable_weights), .D(N100), .Q(
        weight_address[4]) );
  LATCH \weight_address_reg[3]  ( .CLK(w_enable_weights), .D(N99), .Q(
        weight_address[3]) );
  LATCH \weight_address_reg[2]  ( .CLK(w_enable_weights), .D(N98), .Q(
        weight_address[2]) );
  LATCH \weight_address_reg[1]  ( .CLK(w_enable_weights), .D(N97), .Q(
        weight_address[1]) );
  LATCH \weight_address_reg[0]  ( .CLK(w_enable_weights), .D(N96), .Q(
        weight_address[0]) );
  LATCH \output_address_reg[3]  ( .CLK(n168), .D(int_addr[3]), .Q(
        output_address[3]) );
  LATCH \output_address_reg[2]  ( .CLK(n168), .D(int_addr[2]), .Q(
        output_address[2]) );
  LATCH \output_address_reg[1]  ( .CLK(n168), .D(int_addr[1]), .Q(
        output_address[1]) );
  LATCH \output_address_reg[0]  ( .CLK(n168), .D(int_addr[0]), .Q(
        output_address[0]) );
  DFFSR \csr_reg[31]  ( .D(next_csr[31]), .CLK(clk), .R(n_rst), .S(1'b1), .Q(
        csr[31]) );
  DFFSR \csr_reg[30]  ( .D(next_csr[30]), .CLK(clk), .R(n_rst), .S(1'b1), .Q(
        csr[30]) );
  DFFSR \csr_reg[29]  ( .D(next_csr[29]), .CLK(clk), .R(n_rst), .S(1'b1), .Q(
        csr[29]) );
  DFFSR \csr_reg[28]  ( .D(next_csr[28]), .CLK(clk), .R(n_rst), .S(1'b1), .Q(
        csr[28]) );
  DFFSR \csr_reg[27]  ( .D(next_csr[27]), .CLK(clk), .R(n_rst), .S(1'b1), .Q(
        csr[27]) );
  DFFSR \csr_reg[26]  ( .D(next_csr[26]), .CLK(clk), .R(n_rst), .S(1'b1), .Q(
        csr[26]) );
  DFFSR \csr_reg[25]  ( .D(next_csr[25]), .CLK(clk), .R(n_rst), .S(1'b1), .Q(
        csr[25]) );
  DFFSR \csr_reg[24]  ( .D(next_csr[24]), .CLK(clk), .R(n_rst), .S(1'b1), .Q(
        csr[24]) );
  DFFSR \csr_reg[23]  ( .D(next_csr[23]), .CLK(clk), .R(n_rst), .S(1'b1), .Q(
        csr[23]) );
  DFFSR \csr_reg[22]  ( .D(next_csr[22]), .CLK(clk), .R(n_rst), .S(1'b1), .Q(
        csr[22]) );
  DFFSR \csr_reg[21]  ( .D(next_csr[21]), .CLK(clk), .R(n_rst), .S(1'b1), .Q(
        csr[21]) );
  DFFSR \csr_reg[20]  ( .D(next_csr[20]), .CLK(clk), .R(n_rst), .S(1'b1), .Q(
        csr[20]) );
  DFFSR \csr_reg[19]  ( .D(next_csr[19]), .CLK(clk), .R(n_rst), .S(1'b1), .Q(
        csr[19]) );
  DFFSR \csr_reg[18]  ( .D(next_csr[18]), .CLK(clk), .R(n_rst), .S(1'b1), .Q(
        csr[18]) );
  DFFSR \csr_reg[17]  ( .D(next_csr[17]), .CLK(clk), .R(n_rst), .S(1'b1), .Q(
        csr[17]) );
  DFFSR \csr_reg[16]  ( .D(next_csr[16]), .CLK(clk), .R(n_rst), .S(1'b1), .Q(
        csr[16]) );
  DFFSR \csr_reg[15]  ( .D(next_csr[15]), .CLK(clk), .R(n_rst), .S(1'b1), .Q(
        csr[15]) );
  DFFSR \csr_reg[14]  ( .D(next_csr[14]), .CLK(clk), .R(n_rst), .S(1'b1), .Q(
        csr[14]) );
  DFFSR \csr_reg[13]  ( .D(next_csr[13]), .CLK(clk), .R(n_rst), .S(1'b1), .Q(
        csr[13]) );
  DFFSR \csr_reg[12]  ( .D(next_csr[12]), .CLK(clk), .R(n_rst), .S(1'b1), .Q(
        csr[12]) );
  DFFSR \csr_reg[11]  ( .D(next_csr[11]), .CLK(clk), .R(n_rst), .S(1'b1), .Q(
        csr[11]) );
  DFFSR \csr_reg[10]  ( .D(next_csr[10]), .CLK(clk), .R(n_rst), .S(1'b1), .Q(
        csr[10]) );
  DFFSR \csr_reg[9]  ( .D(next_csr[9]), .CLK(clk), .R(n_rst), .S(1'b1), .Q(
        csr[9]) );
  DFFSR \csr_reg[8]  ( .D(next_csr[8]), .CLK(clk), .R(n_rst), .S(1'b1), .Q(
        csr[8]) );
  DFFSR \csr_reg[7]  ( .D(next_csr[7]), .CLK(clk), .R(n_rst), .S(1'b1), .Q(
        csr[7]) );
  DFFSR \csr_reg[6]  ( .D(next_csr[6]), .CLK(clk), .R(n_rst), .S(1'b1), .Q(
        csr[6]) );
  DFFSR \csr_reg[5]  ( .D(next_csr[5]), .CLK(clk), .R(n_rst), .S(1'b1), .Q(
        csr[5]) );
  DFFSR \csr_reg[4]  ( .D(next_csr[4]), .CLK(clk), .R(n_rst), .S(1'b1), .Q(
        csr[4]) );
  DFFSR \csr_reg[3]  ( .D(next_csr[3]), .CLK(clk), .R(n_rst), .S(1'b1), .Q(
        start_calc) );
  DFFSR \csr_reg[2]  ( .D(next_csr[2]), .CLK(clk), .R(n_rst), .S(1'b1), .Q(
        csr_2) );
  DFFSR \csr_reg[1]  ( .D(next_csr[1]), .CLK(clk), .R(n_rst), .S(1'b1), .Q(
        csr_1) );
  DFFSR \csr_reg[0]  ( .D(next_csr[0]), .CLK(clk), .R(n_rst), .S(1'b1), .Q(
        csr_0) );
  avalon_controller AC ( .clk(clk), .n_rst(n_rst), .write(write), .read(read), 
        .beginbursttransfer(beginbursttransfer), .burstcount(burstcount), 
        .address(address), .writedata(writedata), .done_calc(done_calc), 
        .done_burst(done_burst), .readdatavalid(readdatavalid), 
        .writeresponsevalid(writeresponsevalid), .output_address(int_addr), 
        .end_wait(end_wait), .count_ena(count_ena), .w_ena(w_ena) );
  flex_counter_NUM_CNT_BITS10 burstcounter ( .clk(clk), .n_rst(n_rst), .clear(
        1'b0), .count_enable(count_ena), .rollover_val(burstcount), 
        .count_out(cnt), .rollover_flag(done_burst) );
  avalon_interface_DW01_add_0 r389 ( .A(int_addr), .B({1'b0, cnt}), .CI(1'b0), 
        .SUM({N95, N94, N93, N92, N91, N90, N89, N88, N87, N86, N85}) );
  avalon_interface_DW01_add_1 r361 ( .A(int_addr), .B({1'b0, cnt}), .CI(1'b0), 
        .SUM({N14, N13, N12, N11, N10, N9, N8, N7, N6, N5, N4}) );
  BUFX2 U216 ( .A(n312), .Y(n168) );
  INVX2 U217 ( .A(n263), .Y(n231) );
  INVX2 U218 ( .A(n270), .Y(w_enable_weights) );
  NOR2X1 U219 ( .A(n220), .B(n221), .Y(n170) );
  INVX4 U220 ( .A(n170), .Y(n169) );
  INVX4 U221 ( .A(n269), .Y(n229) );
  OAI21X1 U222 ( .A(n169), .B(n171), .C(n172), .Y(readdata[9]) );
  NAND2X1 U223 ( .A(result_output[9]), .B(n168), .Y(n172) );
  OAI21X1 U224 ( .A(n169), .B(n173), .C(n174), .Y(readdata[8]) );
  NAND2X1 U225 ( .A(result_output[8]), .B(n168), .Y(n174) );
  OAI21X1 U226 ( .A(n169), .B(n175), .C(n176), .Y(readdata[7]) );
  NAND2X1 U227 ( .A(result_output[7]), .B(n168), .Y(n176) );
  OAI21X1 U228 ( .A(n169), .B(n177), .C(n178), .Y(readdata[6]) );
  NAND2X1 U229 ( .A(result_output[6]), .B(n168), .Y(n178) );
  OAI21X1 U230 ( .A(n169), .B(n179), .C(n180), .Y(readdata[5]) );
  NAND2X1 U231 ( .A(result_output[5]), .B(n168), .Y(n180) );
  OAI21X1 U232 ( .A(n169), .B(n181), .C(n182), .Y(readdata[4]) );
  NAND2X1 U233 ( .A(result_output[4]), .B(n168), .Y(n182) );
  OAI21X1 U234 ( .A(n169), .B(n183), .C(n184), .Y(readdata[3]) );
  NAND2X1 U235 ( .A(result_output[3]), .B(n168), .Y(n184) );
  NOR2X1 U236 ( .A(n169), .B(n185), .Y(readdata[31]) );
  NOR2X1 U237 ( .A(n169), .B(n186), .Y(readdata[30]) );
  OAI21X1 U238 ( .A(n169), .B(n187), .C(n188), .Y(readdata[2]) );
  NAND2X1 U239 ( .A(result_output[2]), .B(n168), .Y(n188) );
  NOR2X1 U240 ( .A(n169), .B(n189), .Y(readdata[29]) );
  NOR2X1 U241 ( .A(n169), .B(n190), .Y(readdata[28]) );
  NOR2X1 U242 ( .A(n169), .B(n191), .Y(readdata[27]) );
  NOR2X1 U243 ( .A(n169), .B(n192), .Y(readdata[26]) );
  NOR2X1 U244 ( .A(n169), .B(n193), .Y(readdata[25]) );
  NOR2X1 U245 ( .A(n169), .B(n194), .Y(readdata[24]) );
  NOR2X1 U246 ( .A(n169), .B(n195), .Y(readdata[23]) );
  NOR2X1 U247 ( .A(n169), .B(n196), .Y(readdata[22]) );
  NOR2X1 U248 ( .A(n169), .B(n197), .Y(readdata[21]) );
  NOR2X1 U249 ( .A(n169), .B(n198), .Y(readdata[20]) );
  OAI21X1 U250 ( .A(n169), .B(n199), .C(n200), .Y(readdata[1]) );
  NAND2X1 U251 ( .A(result_output[1]), .B(n168), .Y(n200) );
  NOR2X1 U252 ( .A(n169), .B(n201), .Y(readdata[19]) );
  NOR2X1 U253 ( .A(n169), .B(n202), .Y(readdata[18]) );
  NOR2X1 U254 ( .A(n169), .B(n203), .Y(readdata[17]) );
  OAI21X1 U255 ( .A(n169), .B(n204), .C(n205), .Y(readdata[16]) );
  NAND2X1 U256 ( .A(result_output[16]), .B(n168), .Y(n205) );
  OAI21X1 U257 ( .A(n169), .B(n206), .C(n207), .Y(readdata[15]) );
  NAND2X1 U258 ( .A(result_output[15]), .B(n168), .Y(n207) );
  OAI21X1 U259 ( .A(n169), .B(n208), .C(n209), .Y(readdata[14]) );
  NAND2X1 U260 ( .A(result_output[14]), .B(n168), .Y(n209) );
  OAI21X1 U261 ( .A(n169), .B(n210), .C(n211), .Y(readdata[13]) );
  NAND2X1 U262 ( .A(result_output[13]), .B(n168), .Y(n211) );
  OAI21X1 U263 ( .A(n169), .B(n212), .C(n213), .Y(readdata[12]) );
  NAND2X1 U264 ( .A(result_output[12]), .B(n168), .Y(n213) );
  OAI21X1 U265 ( .A(n169), .B(n214), .C(n215), .Y(readdata[11]) );
  NAND2X1 U266 ( .A(result_output[11]), .B(n168), .Y(n215) );
  OAI21X1 U267 ( .A(n169), .B(n216), .C(n217), .Y(readdata[10]) );
  NAND2X1 U268 ( .A(result_output[10]), .B(n168), .Y(n217) );
  OAI21X1 U269 ( .A(n169), .B(n218), .C(n219), .Y(readdata[0]) );
  NAND2X1 U270 ( .A(result_output[0]), .B(n168), .Y(n219) );
  AND2X1 U271 ( .A(w_enable_pixels), .B(N94), .Y(pixel_address[9]) );
  NOR2X1 U272 ( .A(n222), .B(n223), .Y(pixel_address[8]) );
  NOR2X1 U273 ( .A(n222), .B(n224), .Y(pixel_address[7]) );
  NOR2X1 U274 ( .A(n222), .B(n225), .Y(pixel_address[6]) );
  NOR2X1 U275 ( .A(n222), .B(n226), .Y(pixel_address[5]) );
  NOR2X1 U276 ( .A(n222), .B(n227), .Y(pixel_address[4]) );
  NOR2X1 U277 ( .A(n222), .B(n228), .Y(pixel_address[3]) );
  AND2X1 U278 ( .A(w_enable_pixels), .B(N87), .Y(pixel_address[2]) );
  AND2X1 U279 ( .A(w_enable_pixels), .B(N86), .Y(pixel_address[1]) );
  AND2X1 U280 ( .A(w_enable_pixels), .B(N95), .Y(pixel_address[10]) );
  NOR2X1 U281 ( .A(N96), .B(n222), .Y(pixel_address[0]) );
  OAI21X1 U282 ( .A(n229), .B(n171), .C(n230), .Y(next_csr[9]) );
  NAND2X1 U283 ( .A(writedata[9]), .B(n231), .Y(n230) );
  INVX1 U284 ( .A(csr[9]), .Y(n171) );
  OAI21X1 U285 ( .A(n229), .B(n173), .C(n232), .Y(next_csr[8]) );
  NAND2X1 U286 ( .A(writedata[8]), .B(n231), .Y(n232) );
  INVX1 U287 ( .A(csr[8]), .Y(n173) );
  OAI21X1 U288 ( .A(n229), .B(n175), .C(n233), .Y(next_csr[7]) );
  NAND2X1 U289 ( .A(writedata[7]), .B(n231), .Y(n233) );
  INVX1 U290 ( .A(csr[7]), .Y(n175) );
  OAI21X1 U291 ( .A(n229), .B(n177), .C(n234), .Y(next_csr[6]) );
  NAND2X1 U292 ( .A(writedata[6]), .B(n231), .Y(n234) );
  INVX1 U293 ( .A(csr[6]), .Y(n177) );
  OAI21X1 U294 ( .A(n229), .B(n179), .C(n235), .Y(next_csr[5]) );
  NAND2X1 U295 ( .A(writedata[5]), .B(n231), .Y(n235) );
  INVX1 U296 ( .A(csr[5]), .Y(n179) );
  OAI21X1 U297 ( .A(n229), .B(n181), .C(n236), .Y(next_csr[4]) );
  NAND2X1 U298 ( .A(writedata[4]), .B(n231), .Y(n236) );
  INVX1 U299 ( .A(csr[4]), .Y(n181) );
  OAI21X1 U300 ( .A(n229), .B(n183), .C(n237), .Y(next_csr[3]) );
  NAND2X1 U301 ( .A(writedata[3]), .B(n231), .Y(n237) );
  INVX1 U302 ( .A(start_calc), .Y(n183) );
  OAI21X1 U303 ( .A(n229), .B(n185), .C(n238), .Y(next_csr[31]) );
  NAND2X1 U304 ( .A(writedata[31]), .B(n231), .Y(n238) );
  INVX1 U305 ( .A(csr[31]), .Y(n185) );
  OAI21X1 U306 ( .A(n229), .B(n186), .C(n239), .Y(next_csr[30]) );
  NAND2X1 U307 ( .A(writedata[30]), .B(n231), .Y(n239) );
  INVX1 U308 ( .A(csr[30]), .Y(n186) );
  OAI21X1 U309 ( .A(n229), .B(n187), .C(n240), .Y(next_csr[2]) );
  NAND2X1 U310 ( .A(writedata[2]), .B(n231), .Y(n240) );
  INVX1 U311 ( .A(csr_2), .Y(n187) );
  OAI21X1 U312 ( .A(n229), .B(n189), .C(n241), .Y(next_csr[29]) );
  NAND2X1 U313 ( .A(writedata[29]), .B(n231), .Y(n241) );
  INVX1 U314 ( .A(csr[29]), .Y(n189) );
  OAI21X1 U315 ( .A(n229), .B(n190), .C(n242), .Y(next_csr[28]) );
  NAND2X1 U316 ( .A(writedata[28]), .B(n231), .Y(n242) );
  INVX1 U317 ( .A(csr[28]), .Y(n190) );
  OAI21X1 U318 ( .A(n229), .B(n191), .C(n243), .Y(next_csr[27]) );
  NAND2X1 U319 ( .A(writedata[27]), .B(n231), .Y(n243) );
  INVX1 U320 ( .A(csr[27]), .Y(n191) );
  OAI21X1 U321 ( .A(n229), .B(n192), .C(n244), .Y(next_csr[26]) );
  NAND2X1 U322 ( .A(writedata[26]), .B(n231), .Y(n244) );
  INVX1 U323 ( .A(csr[26]), .Y(n192) );
  OAI21X1 U324 ( .A(n229), .B(n193), .C(n245), .Y(next_csr[25]) );
  NAND2X1 U325 ( .A(writedata[25]), .B(n231), .Y(n245) );
  INVX1 U326 ( .A(csr[25]), .Y(n193) );
  OAI21X1 U327 ( .A(n229), .B(n194), .C(n246), .Y(next_csr[24]) );
  NAND2X1 U328 ( .A(writedata[24]), .B(n231), .Y(n246) );
  INVX1 U329 ( .A(csr[24]), .Y(n194) );
  OAI21X1 U330 ( .A(n229), .B(n195), .C(n247), .Y(next_csr[23]) );
  NAND2X1 U331 ( .A(writedata[23]), .B(n231), .Y(n247) );
  INVX1 U332 ( .A(csr[23]), .Y(n195) );
  OAI21X1 U333 ( .A(n229), .B(n196), .C(n248), .Y(next_csr[22]) );
  NAND2X1 U334 ( .A(writedata[22]), .B(n231), .Y(n248) );
  INVX1 U335 ( .A(csr[22]), .Y(n196) );
  OAI21X1 U336 ( .A(n229), .B(n197), .C(n249), .Y(next_csr[21]) );
  NAND2X1 U337 ( .A(writedata[21]), .B(n231), .Y(n249) );
  INVX1 U338 ( .A(csr[21]), .Y(n197) );
  OAI21X1 U339 ( .A(n229), .B(n198), .C(n250), .Y(next_csr[20]) );
  NAND2X1 U340 ( .A(writedata[20]), .B(n231), .Y(n250) );
  INVX1 U341 ( .A(csr[20]), .Y(n198) );
  OAI21X1 U342 ( .A(n229), .B(n199), .C(n251), .Y(next_csr[1]) );
  NAND2X1 U343 ( .A(writedata[1]), .B(n231), .Y(n251) );
  INVX1 U344 ( .A(csr_1), .Y(n199) );
  OAI21X1 U345 ( .A(n229), .B(n201), .C(n252), .Y(next_csr[19]) );
  NAND2X1 U346 ( .A(writedata[19]), .B(n231), .Y(n252) );
  INVX1 U347 ( .A(csr[19]), .Y(n201) );
  OAI21X1 U348 ( .A(n229), .B(n202), .C(n253), .Y(next_csr[18]) );
  NAND2X1 U349 ( .A(writedata[18]), .B(n231), .Y(n253) );
  INVX1 U350 ( .A(csr[18]), .Y(n202) );
  OAI21X1 U351 ( .A(n229), .B(n203), .C(n254), .Y(next_csr[17]) );
  NAND2X1 U352 ( .A(writedata[17]), .B(n231), .Y(n254) );
  INVX1 U353 ( .A(csr[17]), .Y(n203) );
  OAI21X1 U354 ( .A(n229), .B(n204), .C(n255), .Y(next_csr[16]) );
  NAND2X1 U355 ( .A(writedata[16]), .B(n231), .Y(n255) );
  INVX1 U356 ( .A(csr[16]), .Y(n204) );
  OAI21X1 U357 ( .A(n229), .B(n206), .C(n256), .Y(next_csr[15]) );
  NAND2X1 U358 ( .A(writedata[15]), .B(n231), .Y(n256) );
  INVX1 U359 ( .A(csr[15]), .Y(n206) );
  OAI21X1 U360 ( .A(n229), .B(n208), .C(n257), .Y(next_csr[14]) );
  NAND2X1 U361 ( .A(writedata[14]), .B(n231), .Y(n257) );
  INVX1 U362 ( .A(csr[14]), .Y(n208) );
  OAI21X1 U363 ( .A(n229), .B(n210), .C(n258), .Y(next_csr[13]) );
  NAND2X1 U364 ( .A(writedata[13]), .B(n231), .Y(n258) );
  INVX1 U365 ( .A(csr[13]), .Y(n210) );
  OAI21X1 U366 ( .A(n229), .B(n212), .C(n259), .Y(next_csr[12]) );
  NAND2X1 U367 ( .A(writedata[12]), .B(n231), .Y(n259) );
  INVX1 U368 ( .A(csr[12]), .Y(n212) );
  OAI21X1 U369 ( .A(n229), .B(n214), .C(n260), .Y(next_csr[11]) );
  NAND2X1 U370 ( .A(writedata[11]), .B(n231), .Y(n260) );
  INVX1 U371 ( .A(csr[11]), .Y(n214) );
  OAI21X1 U372 ( .A(n229), .B(n216), .C(n261), .Y(next_csr[10]) );
  NAND2X1 U373 ( .A(writedata[10]), .B(n231), .Y(n261) );
  INVX1 U374 ( .A(csr[10]), .Y(n216) );
  OAI21X1 U375 ( .A(n229), .B(n218), .C(n262), .Y(next_csr[0]) );
  NAND2X1 U376 ( .A(writedata[0]), .B(n231), .Y(n262) );
  NAND3X1 U377 ( .A(n264), .B(w_ena), .C(n265), .Y(n263) );
  NOR2X1 U378 ( .A(n221), .B(n266), .Y(n265) );
  NOR2X1 U379 ( .A(n267), .B(n268), .Y(n264) );
  INVX1 U380 ( .A(csr_0), .Y(n218) );
  NAND3X1 U381 ( .A(n270), .B(n222), .C(n271), .Y(n269) );
  NOR2X1 U382 ( .A(n272), .B(n221), .Y(n271) );
  INVX1 U383 ( .A(w_enable_pixels), .Y(n222) );
  NOR2X1 U384 ( .A(n272), .B(n273), .Y(w_enable_pixels) );
  INVX1 U385 ( .A(w_ena), .Y(n272) );
  NAND3X1 U386 ( .A(n274), .B(n273), .C(w_ena), .Y(n270) );
  OAI21X1 U387 ( .A(n268), .B(n275), .C(n266), .Y(n273) );
  INVX1 U388 ( .A(N14), .Y(n266) );
  OAI21X1 U389 ( .A(n276), .B(n277), .C(N12), .Y(n275) );
  NAND2X1 U390 ( .A(n278), .B(n279), .Y(n277) );
  INVX1 U391 ( .A(N13), .Y(n268) );
  NAND3X1 U392 ( .A(N13), .B(n280), .C(N14), .Y(n274) );
  INVX1 U393 ( .A(n267), .Y(n280) );
  NOR2X1 U394 ( .A(n276), .B(n281), .Y(n267) );
  OAI21X1 U395 ( .A(n278), .B(n279), .C(n282), .Y(n281) );
  INVX1 U396 ( .A(N12), .Y(n282) );
  INVX1 U397 ( .A(N8), .Y(n279) );
  NAND3X1 U398 ( .A(N7), .B(N6), .C(n283), .Y(n278) );
  AND2X1 U399 ( .A(N5), .B(N4), .Y(n283) );
  OR2X1 U400 ( .A(N10), .B(n284), .Y(n276) );
  OR2X1 U401 ( .A(N9), .B(N11), .Y(n284) );
  NOR2X1 U402 ( .A(n220), .B(n285), .Y(n312) );
  INVX1 U403 ( .A(n221), .Y(n285) );
  NAND3X1 U404 ( .A(int_addr[10]), .B(n286), .C(int_addr[9]), .Y(n221) );
  OAI21X1 U405 ( .A(n287), .B(n288), .C(n289), .Y(n286) );
  INVX1 U406 ( .A(int_addr[5]), .Y(n288) );
  AOI21X1 U407 ( .A(int_addr[2]), .B(int_addr[3]), .C(n290), .Y(n287) );
  NAND2X1 U408 ( .A(n291), .B(n292), .Y(n290) );
  INVX1 U409 ( .A(int_addr[4]), .Y(n292) );
  NAND3X1 U410 ( .A(int_addr[9]), .B(int_addr[10]), .C(n293), .Y(n220) );
  AOI21X1 U411 ( .A(n294), .B(n289), .C(w_ena), .Y(n293) );
  NOR2X1 U412 ( .A(int_addr[6]), .B(n295), .Y(n289) );
  OR2X1 U413 ( .A(int_addr[8]), .B(int_addr[7]), .Y(n295) );
  AOI21X1 U414 ( .A(n296), .B(int_addr[4]), .C(int_addr[5]), .Y(n294) );
  NOR2X1 U415 ( .A(n291), .B(n297), .Y(n296) );
  INVX1 U416 ( .A(int_addr[2]), .Y(n297) );
  NAND3X1 U417 ( .A(int_addr[1]), .B(int_addr[0]), .C(int_addr[3]), .Y(n291)
         );
  INVX1 U418 ( .A(end_wait), .Y(waitrequest) );
  XOR2X1 U419 ( .A(n228), .B(n298), .Y(N99) );
  XNOR2X1 U420 ( .A(N87), .B(n299), .Y(N98) );
  NAND2X1 U421 ( .A(N86), .B(N85), .Y(n299) );
  XOR2X1 U422 ( .A(N86), .B(N85), .Y(N97) );
  INVX1 U423 ( .A(N85), .Y(N96) );
  XOR2X1 U424 ( .A(n300), .B(N95), .Y(N106) );
  NAND2X1 U425 ( .A(n301), .B(N94), .Y(n300) );
  XOR2X1 U426 ( .A(N94), .B(n301), .Y(N105) );
  NOR2X1 U427 ( .A(n223), .B(n302), .Y(n301) );
  XOR2X1 U428 ( .A(n223), .B(n302), .Y(N104) );
  INVX1 U429 ( .A(n303), .Y(n302) );
  INVX1 U430 ( .A(N93), .Y(n223) );
  OAI21X1 U431 ( .A(n304), .B(n224), .C(n303), .Y(N103) );
  NAND2X1 U432 ( .A(n304), .B(n224), .Y(n303) );
  INVX1 U433 ( .A(N92), .Y(n224) );
  INVX1 U434 ( .A(n305), .Y(n304) );
  OAI21X1 U435 ( .A(n306), .B(n225), .C(n305), .Y(N102) );
  NAND2X1 U436 ( .A(n306), .B(n225), .Y(n305) );
  INVX1 U437 ( .A(N91), .Y(n225) );
  INVX1 U438 ( .A(n307), .Y(n306) );
  OAI21X1 U439 ( .A(n308), .B(n226), .C(n307), .Y(N101) );
  NAND2X1 U440 ( .A(n308), .B(n226), .Y(n307) );
  INVX1 U441 ( .A(N90), .Y(n226) );
  INVX1 U442 ( .A(n309), .Y(n308) );
  OAI21X1 U443 ( .A(n298), .B(n310), .C(n309), .Y(N100) );
  OAI21X1 U444 ( .A(n228), .B(n298), .C(n227), .Y(n309) );
  INVX1 U445 ( .A(N89), .Y(n227) );
  INVX1 U446 ( .A(N88), .Y(n228) );
  NAND2X1 U447 ( .A(N88), .B(N89), .Y(n310) );
  NAND3X1 U448 ( .A(N87), .B(N85), .C(N86), .Y(n298) );
endmodule

