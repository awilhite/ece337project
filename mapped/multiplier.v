/////////////////////////////////////////////////////////////
// Created by: Synopsys DC Expert(TM) in wire load mode
// Version   : K-2015.06-SP1
// Date      : Tue Dec  6 21:11:01 2016
/////////////////////////////////////////////////////////////


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
  flex_counter_NUM_CNT_BITS10_DW01_inc_0 add_47_aco ( .A({N42, N41, N40, N39, 
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


module multiplier_DW01_add_1 ( A, B, CI, SUM, CO );
  input [16:0] A;
  input [16:0] B;
  output [16:0] SUM;
  input CI;
  output CO;
  wire   n1;
  wire   [16:1] carry;

  FAX1 U1_15 ( .A(A[15]), .B(B[15]), .C(carry[15]), .YC(carry[16]), .YS(
        SUM[15]) );
  FAX1 U1_14 ( .A(A[14]), .B(B[14]), .C(carry[14]), .YC(carry[15]), .YS(
        SUM[14]) );
  FAX1 U1_13 ( .A(A[13]), .B(B[13]), .C(carry[13]), .YC(carry[14]), .YS(
        SUM[13]) );
  FAX1 U1_12 ( .A(A[12]), .B(B[12]), .C(carry[12]), .YC(carry[13]), .YS(
        SUM[12]) );
  FAX1 U1_11 ( .A(A[11]), .B(B[11]), .C(carry[11]), .YC(carry[12]), .YS(
        SUM[11]) );
  FAX1 U1_10 ( .A(A[10]), .B(B[10]), .C(carry[10]), .YC(carry[11]), .YS(
        SUM[10]) );
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
  XOR2X1 U2 ( .A(B[16]), .B(carry[16]), .Y(SUM[16]) );
  XOR2X1 U3 ( .A(B[0]), .B(A[0]), .Y(SUM[0]) );
endmodule


module multiplier_DW01_add_2 ( A, B, CI, SUM, CO );
  input [16:0] A;
  input [16:0] B;
  output [16:0] SUM;
  input CI;
  output CO;
  wire   n1;
  wire   [16:1] carry;

  FAX1 U1_15 ( .A(A[15]), .B(B[15]), .C(carry[15]), .YC(carry[16]), .YS(
        SUM[15]) );
  FAX1 U1_14 ( .A(A[14]), .B(B[14]), .C(carry[14]), .YC(carry[15]), .YS(
        SUM[14]) );
  FAX1 U1_13 ( .A(A[13]), .B(B[13]), .C(carry[13]), .YC(carry[14]), .YS(
        SUM[13]) );
  FAX1 U1_12 ( .A(A[12]), .B(B[12]), .C(carry[12]), .YC(carry[13]), .YS(
        SUM[12]) );
  FAX1 U1_11 ( .A(A[11]), .B(B[11]), .C(carry[11]), .YC(carry[12]), .YS(
        SUM[11]) );
  FAX1 U1_10 ( .A(A[10]), .B(B[10]), .C(carry[10]), .YC(carry[11]), .YS(
        SUM[10]) );
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
  XOR2X1 U2 ( .A(A[16]), .B(carry[16]), .Y(SUM[16]) );
  XOR2X1 U3 ( .A(B[0]), .B(A[0]), .Y(SUM[0]) );
endmodule


module multiplier_DW_mult_uns_4 ( a, b, product );
  input [7:0] a;
  input [15:0] b;
  output [23:0] product;
  wire   n1, n2, n3, n4, n5, n6, n7, n8, n9, n10, n11, n12, n13, n14, n15, n16,
         n17, n18, n19, n20, n21, n22, n23, n24, n25, n26, n27, n28, n29, n30,
         n31, n32, n33, n34, n35, n36, n37, n38, n39, n40, n41, n42, n43, n44,
         n45, n46, n47, n48, n49, n50, n51, n52, n53, n54, n55, n56, n57, n58,
         n59, n60, n61, n62, n63, n64, n65, n66, n67, n68, n69, n70, n71, n72,
         n73, n74, n75, n76, n77, n78, n79, n80, n81, n82, n83, n84, n85, n86,
         n87, n88, n89, n90, n91, n92, n93, n94, n95, n96, n97, n98, n99, n100,
         n101, n102, n103, n104, n105, n106, n107, n108, n109, n110, n111,
         n112, n113, n114, n115, n116, n117, n118, n119, n120, n121, n122,
         n123, n124, n125, n126, n127, n128, n129, n130, n131, n132, n133,
         n134, n135, n136, n137, n138, n139, n140, n141, n142, n143, n144,
         n145, n146, n147, n148, n149, n150, n151, n152, n153, n154, n155,
         n156, n157, n158, n159, n160, n161, n162, n163, n164, n165, n166,
         n167, n168, n169, n170, n171, n172, n173, n174, n175, n176, n177,
         n178, n179, n180, n181, n182, n183, n184, n185, n186, n187, n188,
         n189, n190, n191, n192, n193, n194, n195, n196, n197, n198, n199,
         n200, n201, n202, n203, n204, n205, n206, n207, n208, n209, n210,
         n211, n212, n213, n214, n215, n216, n217, n218, n219, n220, n221,
         n222, n223, n224, n225, n226, n227, n228, n229, n230, n231, n232,
         n233, n234, n235, n236, n237, n238, n239, n240, n241, n242, n243,
         n244, n245, n246, n247, n248, n249, n250, n251, n252, n253, n254,
         n255, n256, n257, n258, n259, n260, n261, n262, n263, n264, n265,
         n266, n267, n268, n269, n270, n271, n272, n273, n274, n275, n276;

  XOR2X1 U1 ( .A(n2), .B(n1), .Y(product[15]) );
  XOR2X1 U2 ( .A(n28), .B(n17), .Y(n1) );
  FAX1 U3 ( .A(n40), .B(n29), .C(n3), .YC(n2), .YS(product[14]) );
  FAX1 U4 ( .A(n52), .B(n41), .C(n4), .YC(n3), .YS(product[13]) );
  FAX1 U5 ( .A(n64), .B(n53), .C(n5), .YC(n4), .YS(product[12]) );
  FAX1 U6 ( .A(n76), .B(n65), .C(n6), .YC(n5), .YS(product[11]) );
  FAX1 U7 ( .A(n88), .B(n77), .C(n7), .YC(n6), .YS(product[10]) );
  FAX1 U8 ( .A(n100), .B(n89), .C(n8), .YC(n7), .YS(product[9]) );
  FAX1 U9 ( .A(n112), .B(n101), .C(n9), .YC(n8), .YS(product[8]) );
  FAX1 U10 ( .A(n124), .B(n113), .C(n10), .YC(n9), .YS(product[7]) );
  FAX1 U11 ( .A(n134), .B(n125), .C(n11), .YC(n10), .YS(product[6]) );
  FAX1 U12 ( .A(n142), .B(n135), .C(n12), .YC(n11), .YS(product[5]) );
  FAX1 U13 ( .A(n148), .B(n143), .C(n13), .YC(n12), .YS(product[4]) );
  FAX1 U14 ( .A(n151), .B(n149), .C(n14), .YC(n13), .YS(product[3]) );
  FAX1 U15 ( .A(n222), .B(n15), .C(n153), .YC(n14), .YS(product[2]) );
  HAX1 U16 ( .A(n237), .B(n252), .YC(n15), .YS(product[1]) );
  XOR2X1 U17 ( .A(n32), .B(n16), .Y(n17) );
  XOR2X1 U18 ( .A(n30), .B(n19), .Y(n16) );
  XOR2X1 U19 ( .A(n36), .B(n18), .Y(n19) );
  XOR2X1 U20 ( .A(n34), .B(n21), .Y(n18) );
  XOR2X1 U21 ( .A(n27), .B(n20), .Y(n21) );
  XOR2X1 U22 ( .A(n38), .B(n23), .Y(n20) );
  XOR2X1 U23 ( .A(n196), .B(n22), .Y(n23) );
  XOR2X1 U24 ( .A(n25), .B(n184), .Y(n22) );
  XOR2X1 U25 ( .A(n209), .B(n24), .Y(n25) );
  XOR2X1 U26 ( .A(n223), .B(n238), .Y(n24) );
  XOR2X1 U27 ( .A(n163), .B(n26), .Y(n27) );
  XOR2X1 U28 ( .A(n173), .B(n154), .Y(n26) );
  FAX1 U29 ( .A(n33), .B(n42), .C(n31), .YC(n28), .YS(n29) );
  FAX1 U30 ( .A(n46), .B(n35), .C(n44), .YC(n30), .YS(n31) );
  FAX1 U31 ( .A(n48), .B(n37), .C(n39), .YC(n32), .YS(n33) );
  FAX1 U32 ( .A(n210), .B(n197), .C(n50), .YC(n34), .YS(n35) );
  FAX1 U33 ( .A(n239), .B(n185), .C(n224), .YC(n36), .YS(n37) );
  FAX1 U34 ( .A(n164), .B(n155), .C(n174), .YC(n38), .YS(n39) );
  FAX1 U35 ( .A(n45), .B(n54), .C(n43), .YC(n40), .YS(n41) );
  FAX1 U36 ( .A(n58), .B(n47), .C(n56), .YC(n42), .YS(n43) );
  FAX1 U37 ( .A(n60), .B(n49), .C(n51), .YC(n44), .YS(n45) );
  FAX1 U38 ( .A(n211), .B(n198), .C(n62), .YC(n46), .YS(n47) );
  FAX1 U39 ( .A(n240), .B(n186), .C(n225), .YC(n48), .YS(n49) );
  FAX1 U40 ( .A(n165), .B(n156), .C(n175), .YC(n50), .YS(n51) );
  FAX1 U41 ( .A(n57), .B(n66), .C(n55), .YC(n52), .YS(n53) );
  FAX1 U42 ( .A(n70), .B(n59), .C(n68), .YC(n54), .YS(n55) );
  FAX1 U43 ( .A(n72), .B(n61), .C(n63), .YC(n56), .YS(n57) );
  FAX1 U44 ( .A(n212), .B(n199), .C(n74), .YC(n58), .YS(n59) );
  FAX1 U45 ( .A(n241), .B(n187), .C(n226), .YC(n60), .YS(n61) );
  FAX1 U46 ( .A(n166), .B(n157), .C(n176), .YC(n62), .YS(n63) );
  FAX1 U47 ( .A(n69), .B(n78), .C(n67), .YC(n64), .YS(n65) );
  FAX1 U48 ( .A(n82), .B(n71), .C(n80), .YC(n66), .YS(n67) );
  FAX1 U49 ( .A(n84), .B(n73), .C(n75), .YC(n68), .YS(n69) );
  FAX1 U50 ( .A(n213), .B(n200), .C(n86), .YC(n70), .YS(n71) );
  FAX1 U51 ( .A(n242), .B(n188), .C(n227), .YC(n72), .YS(n73) );
  FAX1 U52 ( .A(n167), .B(n158), .C(n177), .YC(n74), .YS(n75) );
  FAX1 U53 ( .A(n81), .B(n90), .C(n79), .YC(n76), .YS(n77) );
  FAX1 U54 ( .A(n94), .B(n83), .C(n92), .YC(n78), .YS(n79) );
  FAX1 U55 ( .A(n96), .B(n85), .C(n87), .YC(n80), .YS(n81) );
  FAX1 U56 ( .A(n214), .B(n201), .C(n98), .YC(n82), .YS(n83) );
  FAX1 U57 ( .A(n243), .B(n189), .C(n228), .YC(n84), .YS(n85) );
  FAX1 U58 ( .A(n168), .B(n159), .C(n178), .YC(n86), .YS(n87) );
  FAX1 U59 ( .A(n93), .B(n102), .C(n91), .YC(n88), .YS(n89) );
  FAX1 U60 ( .A(n106), .B(n95), .C(n104), .YC(n90), .YS(n91) );
  FAX1 U61 ( .A(n108), .B(n97), .C(n99), .YC(n92), .YS(n93) );
  FAX1 U62 ( .A(n215), .B(n202), .C(n110), .YC(n94), .YS(n95) );
  FAX1 U63 ( .A(n244), .B(n190), .C(n229), .YC(n96), .YS(n97) );
  FAX1 U64 ( .A(n169), .B(n160), .C(n179), .YC(n98), .YS(n99) );
  FAX1 U65 ( .A(n105), .B(n114), .C(n103), .YC(n100), .YS(n101) );
  FAX1 U66 ( .A(n109), .B(n107), .C(n116), .YC(n102), .YS(n103) );
  FAX1 U67 ( .A(n120), .B(n118), .C(n111), .YC(n104), .YS(n105) );
  FAX1 U68 ( .A(n230), .B(n216), .C(n122), .YC(n106), .YS(n107) );
  FAX1 U69 ( .A(n245), .B(n191), .C(n203), .YC(n108), .YS(n109) );
  FAX1 U70 ( .A(n170), .B(n161), .C(n180), .YC(n110), .YS(n111) );
  FAX1 U71 ( .A(n117), .B(n126), .C(n115), .YC(n112), .YS(n113) );
  FAX1 U72 ( .A(n119), .B(n121), .C(n128), .YC(n114), .YS(n115) );
  FAX1 U73 ( .A(n132), .B(n123), .C(n130), .YC(n116), .YS(n117) );
  FAX1 U74 ( .A(n217), .B(n192), .C(n204), .YC(n118), .YS(n119) );
  FAX1 U75 ( .A(n246), .B(n181), .C(n231), .YC(n120), .YS(n121) );
  HAX1 U76 ( .A(n171), .B(n162), .YC(n122), .YS(n123) );
  FAX1 U77 ( .A(n129), .B(n136), .C(n127), .YC(n124), .YS(n125) );
  FAX1 U78 ( .A(n133), .B(n138), .C(n131), .YC(n126), .YS(n127) );
  FAX1 U79 ( .A(n218), .B(n205), .C(n140), .YC(n128), .YS(n129) );
  FAX1 U80 ( .A(n247), .B(n193), .C(n232), .YC(n130), .YS(n131) );
  HAX1 U81 ( .A(n182), .B(n172), .YC(n132), .YS(n133) );
  FAX1 U82 ( .A(n144), .B(n139), .C(n137), .YC(n134), .YS(n135) );
  FAX1 U83 ( .A(n233), .B(n146), .C(n141), .YC(n136), .YS(n137) );
  FAX1 U84 ( .A(n248), .B(n206), .C(n219), .YC(n138), .YS(n139) );
  HAX1 U85 ( .A(n194), .B(n183), .YC(n140), .YS(n141) );
  FAX1 U86 ( .A(n150), .B(n147), .C(n145), .YC(n142), .YS(n143) );
  FAX1 U87 ( .A(n249), .B(n220), .C(n234), .YC(n144), .YS(n145) );
  HAX1 U88 ( .A(n207), .B(n195), .YC(n146), .YS(n147) );
  FAX1 U89 ( .A(n250), .B(n235), .C(n152), .YC(n148), .YS(n149) );
  HAX1 U90 ( .A(n221), .B(n208), .YC(n150), .YS(n151) );
  HAX1 U91 ( .A(n251), .B(n236), .YC(n152), .YS(n153) );
  NOR2X1 U92 ( .A(n269), .B(n260), .Y(n154) );
  NOR2X1 U93 ( .A(n269), .B(n261), .Y(n155) );
  NOR2X1 U94 ( .A(n269), .B(n262), .Y(n156) );
  NOR2X1 U95 ( .A(n269), .B(n263), .Y(n157) );
  NOR2X1 U96 ( .A(n269), .B(n264), .Y(n158) );
  NOR2X1 U97 ( .A(n269), .B(n265), .Y(n159) );
  NOR2X1 U98 ( .A(n269), .B(n266), .Y(n160) );
  NOR2X1 U99 ( .A(n269), .B(n267), .Y(n161) );
  NOR2X1 U100 ( .A(n269), .B(n268), .Y(n162) );
  NOR2X1 U101 ( .A(n270), .B(n259), .Y(n163) );
  NOR2X1 U102 ( .A(n270), .B(n260), .Y(n164) );
  NOR2X1 U103 ( .A(n270), .B(n261), .Y(n165) );
  NOR2X1 U104 ( .A(n270), .B(n262), .Y(n166) );
  NOR2X1 U105 ( .A(n270), .B(n263), .Y(n167) );
  NOR2X1 U106 ( .A(n270), .B(n264), .Y(n168) );
  NOR2X1 U107 ( .A(n270), .B(n265), .Y(n169) );
  NOR2X1 U108 ( .A(n270), .B(n266), .Y(n170) );
  NOR2X1 U109 ( .A(n270), .B(n267), .Y(n171) );
  NOR2X1 U110 ( .A(n270), .B(n268), .Y(n172) );
  NOR2X1 U111 ( .A(n271), .B(n258), .Y(n173) );
  NOR2X1 U112 ( .A(n271), .B(n259), .Y(n174) );
  NOR2X1 U113 ( .A(n271), .B(n260), .Y(n175) );
  NOR2X1 U114 ( .A(n271), .B(n261), .Y(n176) );
  NOR2X1 U115 ( .A(n271), .B(n262), .Y(n177) );
  NOR2X1 U116 ( .A(n271), .B(n263), .Y(n178) );
  NOR2X1 U117 ( .A(n271), .B(n264), .Y(n179) );
  NOR2X1 U118 ( .A(n271), .B(n265), .Y(n180) );
  NOR2X1 U119 ( .A(n271), .B(n266), .Y(n181) );
  NOR2X1 U120 ( .A(n271), .B(n267), .Y(n182) );
  NOR2X1 U121 ( .A(n271), .B(n268), .Y(n183) );
  NOR2X1 U122 ( .A(n272), .B(n257), .Y(n184) );
  NOR2X1 U123 ( .A(n272), .B(n258), .Y(n185) );
  NOR2X1 U124 ( .A(n272), .B(n259), .Y(n186) );
  NOR2X1 U125 ( .A(n272), .B(n260), .Y(n187) );
  NOR2X1 U126 ( .A(n272), .B(n261), .Y(n188) );
  NOR2X1 U127 ( .A(n272), .B(n262), .Y(n189) );
  NOR2X1 U128 ( .A(n272), .B(n263), .Y(n190) );
  NOR2X1 U129 ( .A(n272), .B(n264), .Y(n191) );
  NOR2X1 U130 ( .A(n272), .B(n265), .Y(n192) );
  NOR2X1 U131 ( .A(n272), .B(n266), .Y(n193) );
  NOR2X1 U132 ( .A(n272), .B(n267), .Y(n194) );
  NOR2X1 U133 ( .A(n272), .B(n268), .Y(n195) );
  NOR2X1 U134 ( .A(n273), .B(n256), .Y(n196) );
  NOR2X1 U135 ( .A(n273), .B(n257), .Y(n197) );
  NOR2X1 U136 ( .A(n273), .B(n258), .Y(n198) );
  NOR2X1 U137 ( .A(n273), .B(n259), .Y(n199) );
  NOR2X1 U138 ( .A(n273), .B(n260), .Y(n200) );
  NOR2X1 U139 ( .A(n273), .B(n261), .Y(n201) );
  NOR2X1 U140 ( .A(n273), .B(n262), .Y(n202) );
  NOR2X1 U141 ( .A(n273), .B(n263), .Y(n203) );
  NOR2X1 U142 ( .A(n273), .B(n264), .Y(n204) );
  NOR2X1 U143 ( .A(n273), .B(n265), .Y(n205) );
  NOR2X1 U144 ( .A(n273), .B(n266), .Y(n206) );
  NOR2X1 U145 ( .A(n273), .B(n267), .Y(n207) );
  NOR2X1 U146 ( .A(n273), .B(n268), .Y(n208) );
  NOR2X1 U147 ( .A(n274), .B(n255), .Y(n209) );
  NOR2X1 U148 ( .A(n274), .B(n256), .Y(n210) );
  NOR2X1 U149 ( .A(n274), .B(n257), .Y(n211) );
  NOR2X1 U150 ( .A(n274), .B(n258), .Y(n212) );
  NOR2X1 U151 ( .A(n274), .B(n259), .Y(n213) );
  NOR2X1 U152 ( .A(n274), .B(n260), .Y(n214) );
  NOR2X1 U153 ( .A(n274), .B(n261), .Y(n215) );
  NOR2X1 U154 ( .A(n274), .B(n262), .Y(n216) );
  NOR2X1 U155 ( .A(n274), .B(n263), .Y(n217) );
  NOR2X1 U156 ( .A(n274), .B(n264), .Y(n218) );
  NOR2X1 U157 ( .A(n274), .B(n265), .Y(n219) );
  NOR2X1 U158 ( .A(n274), .B(n266), .Y(n220) );
  NOR2X1 U159 ( .A(n274), .B(n267), .Y(n221) );
  NOR2X1 U160 ( .A(n274), .B(n268), .Y(n222) );
  NOR2X1 U161 ( .A(n275), .B(n254), .Y(n223) );
  NOR2X1 U162 ( .A(n275), .B(n255), .Y(n224) );
  NOR2X1 U163 ( .A(n275), .B(n256), .Y(n225) );
  NOR2X1 U164 ( .A(n275), .B(n257), .Y(n226) );
  NOR2X1 U165 ( .A(n275), .B(n258), .Y(n227) );
  NOR2X1 U166 ( .A(n275), .B(n259), .Y(n228) );
  NOR2X1 U167 ( .A(n275), .B(n260), .Y(n229) );
  NOR2X1 U168 ( .A(n275), .B(n261), .Y(n230) );
  NOR2X1 U169 ( .A(n275), .B(n262), .Y(n231) );
  NOR2X1 U170 ( .A(n275), .B(n263), .Y(n232) );
  NOR2X1 U171 ( .A(n275), .B(n264), .Y(n233) );
  NOR2X1 U172 ( .A(n275), .B(n265), .Y(n234) );
  NOR2X1 U173 ( .A(n275), .B(n266), .Y(n235) );
  NOR2X1 U174 ( .A(n275), .B(n267), .Y(n236) );
  NOR2X1 U175 ( .A(n275), .B(n268), .Y(n237) );
  NOR2X1 U176 ( .A(n276), .B(n253), .Y(n238) );
  NOR2X1 U177 ( .A(n276), .B(n254), .Y(n239) );
  NOR2X1 U178 ( .A(n276), .B(n255), .Y(n240) );
  NOR2X1 U179 ( .A(n276), .B(n256), .Y(n241) );
  NOR2X1 U180 ( .A(n276), .B(n257), .Y(n242) );
  NOR2X1 U181 ( .A(n276), .B(n258), .Y(n243) );
  NOR2X1 U182 ( .A(n276), .B(n259), .Y(n244) );
  NOR2X1 U183 ( .A(n276), .B(n260), .Y(n245) );
  NOR2X1 U184 ( .A(n276), .B(n261), .Y(n246) );
  NOR2X1 U185 ( .A(n276), .B(n262), .Y(n247) );
  NOR2X1 U186 ( .A(n276), .B(n263), .Y(n248) );
  NOR2X1 U187 ( .A(n276), .B(n264), .Y(n249) );
  NOR2X1 U188 ( .A(n276), .B(n265), .Y(n250) );
  NOR2X1 U189 ( .A(n276), .B(n266), .Y(n251) );
  NOR2X1 U190 ( .A(n276), .B(n267), .Y(n252) );
  NOR2X1 U191 ( .A(n276), .B(n268), .Y(product[0]) );
  INVX2 U218 ( .A(a[0]), .Y(n276) );
  INVX2 U219 ( .A(a[1]), .Y(n275) );
  INVX2 U220 ( .A(b[15]), .Y(n253) );
  INVX2 U221 ( .A(a[2]), .Y(n274) );
  INVX2 U222 ( .A(a[3]), .Y(n273) );
  INVX2 U223 ( .A(a[4]), .Y(n272) );
  INVX2 U224 ( .A(a[5]), .Y(n271) );
  INVX2 U225 ( .A(a[6]), .Y(n270) );
  INVX2 U226 ( .A(a[7]), .Y(n269) );
  INVX2 U227 ( .A(b[0]), .Y(n268) );
  INVX2 U228 ( .A(b[1]), .Y(n267) );
  INVX2 U229 ( .A(b[2]), .Y(n266) );
  INVX2 U230 ( .A(b[3]), .Y(n265) );
  INVX2 U231 ( .A(b[4]), .Y(n264) );
  INVX2 U232 ( .A(b[8]), .Y(n260) );
  INVX2 U233 ( .A(b[6]), .Y(n262) );
  INVX2 U234 ( .A(b[5]), .Y(n263) );
  INVX2 U235 ( .A(b[7]), .Y(n261) );
  INVX2 U236 ( .A(b[9]), .Y(n259) );
  INVX2 U237 ( .A(b[10]), .Y(n258) );
  INVX2 U238 ( .A(b[11]), .Y(n257) );
  INVX2 U239 ( .A(b[12]), .Y(n256) );
  INVX2 U240 ( .A(b[13]), .Y(n255) );
  INVX2 U241 ( .A(b[14]), .Y(n254) );
endmodule


module multiplier_DW_mult_uns_5 ( a, b, product );
  input [7:0] a;
  input [15:0] b;
  output [23:0] product;
  wire   n1, n2, n3, n4, n5, n6, n7, n8, n9, n10, n11, n12, n13, n14, n15, n16,
         n17, n18, n19, n20, n21, n22, n23, n24, n25, n26, n27, n28, n29, n30,
         n31, n32, n33, n34, n35, n36, n37, n38, n39, n40, n41, n42, n43, n44,
         n45, n46, n47, n48, n49, n50, n51, n52, n53, n54, n55, n56, n57, n58,
         n59, n60, n61, n62, n63, n64, n65, n66, n67, n68, n69, n70, n71, n72,
         n73, n74, n75, n76, n77, n78, n79, n80, n81, n82, n83, n84, n85, n86,
         n87, n88, n89, n90, n91, n92, n93, n94, n95, n96, n97, n98, n99, n100,
         n101, n102, n103, n104, n105, n106, n107, n108, n109, n110, n111,
         n112, n113, n114, n115, n116, n117, n118, n119, n120, n121, n122,
         n123, n124, n125, n126, n127, n128, n129, n130, n131, n132, n133,
         n134, n135, n136, n137, n138, n139, n140, n141, n142, n143, n144,
         n145, n146, n147, n148, n149, n150, n151, n152, n153, n154, n155,
         n156, n157, n158, n159, n160, n161, n162, n163, n164, n165, n166,
         n167, n168, n169, n170, n171, n172, n173, n174, n175, n176, n177,
         n178, n179, n180, n181, n182, n183, n184, n185, n186, n187, n188,
         n189, n190, n191, n192, n193, n194, n195, n196, n197, n198, n199,
         n200, n201, n202, n203, n204, n205, n206, n207, n208, n209, n210,
         n211, n212, n213, n214, n215, n216, n217, n218, n219, n220, n221,
         n222, n223, n224, n225, n226, n227, n228, n229, n230, n231, n232,
         n233, n234, n235, n236, n237, n238, n239, n240, n241, n242, n243,
         n244, n245, n246, n247, n248, n249, n250, n251, n252, n253, n254,
         n255, n256, n257, n258, n259, n260, n261, n262, n263, n264, n265,
         n266, n267, n268, n269, n270, n271, n272, n273, n274, n275, n276;

  XOR2X1 U1 ( .A(n2), .B(n1), .Y(product[15]) );
  XOR2X1 U2 ( .A(n28), .B(n17), .Y(n1) );
  FAX1 U3 ( .A(n40), .B(n29), .C(n3), .YC(n2), .YS(product[14]) );
  FAX1 U4 ( .A(n52), .B(n41), .C(n4), .YC(n3), .YS(product[13]) );
  FAX1 U5 ( .A(n64), .B(n53), .C(n5), .YC(n4), .YS(product[12]) );
  FAX1 U6 ( .A(n76), .B(n65), .C(n6), .YC(n5), .YS(product[11]) );
  FAX1 U7 ( .A(n88), .B(n77), .C(n7), .YC(n6), .YS(product[10]) );
  FAX1 U8 ( .A(n100), .B(n89), .C(n8), .YC(n7), .YS(product[9]) );
  FAX1 U9 ( .A(n112), .B(n101), .C(n9), .YC(n8), .YS(product[8]) );
  FAX1 U10 ( .A(n124), .B(n113), .C(n10), .YC(n9), .YS(product[7]) );
  FAX1 U11 ( .A(n134), .B(n125), .C(n11), .YC(n10), .YS(product[6]) );
  FAX1 U12 ( .A(n142), .B(n135), .C(n12), .YC(n11), .YS(product[5]) );
  FAX1 U13 ( .A(n148), .B(n143), .C(n13), .YC(n12), .YS(product[4]) );
  FAX1 U14 ( .A(n151), .B(n149), .C(n14), .YC(n13), .YS(product[3]) );
  FAX1 U15 ( .A(n222), .B(n15), .C(n153), .YC(n14), .YS(product[2]) );
  HAX1 U16 ( .A(n237), .B(n252), .YC(n15), .YS(product[1]) );
  XOR2X1 U17 ( .A(n32), .B(n16), .Y(n17) );
  XOR2X1 U18 ( .A(n30), .B(n19), .Y(n16) );
  XOR2X1 U19 ( .A(n36), .B(n18), .Y(n19) );
  XOR2X1 U20 ( .A(n34), .B(n21), .Y(n18) );
  XOR2X1 U21 ( .A(n27), .B(n20), .Y(n21) );
  XOR2X1 U22 ( .A(n38), .B(n23), .Y(n20) );
  XOR2X1 U23 ( .A(n196), .B(n22), .Y(n23) );
  XOR2X1 U24 ( .A(n25), .B(n184), .Y(n22) );
  XOR2X1 U25 ( .A(n209), .B(n24), .Y(n25) );
  XOR2X1 U26 ( .A(n223), .B(n238), .Y(n24) );
  XOR2X1 U27 ( .A(n163), .B(n26), .Y(n27) );
  XOR2X1 U28 ( .A(n173), .B(n154), .Y(n26) );
  FAX1 U29 ( .A(n33), .B(n42), .C(n31), .YC(n28), .YS(n29) );
  FAX1 U30 ( .A(n46), .B(n35), .C(n44), .YC(n30), .YS(n31) );
  FAX1 U31 ( .A(n48), .B(n37), .C(n39), .YC(n32), .YS(n33) );
  FAX1 U32 ( .A(n210), .B(n197), .C(n50), .YC(n34), .YS(n35) );
  FAX1 U33 ( .A(n239), .B(n185), .C(n224), .YC(n36), .YS(n37) );
  FAX1 U34 ( .A(n164), .B(n155), .C(n174), .YC(n38), .YS(n39) );
  FAX1 U35 ( .A(n45), .B(n54), .C(n43), .YC(n40), .YS(n41) );
  FAX1 U36 ( .A(n58), .B(n47), .C(n56), .YC(n42), .YS(n43) );
  FAX1 U37 ( .A(n60), .B(n49), .C(n51), .YC(n44), .YS(n45) );
  FAX1 U38 ( .A(n211), .B(n198), .C(n62), .YC(n46), .YS(n47) );
  FAX1 U39 ( .A(n240), .B(n186), .C(n225), .YC(n48), .YS(n49) );
  FAX1 U40 ( .A(n165), .B(n156), .C(n175), .YC(n50), .YS(n51) );
  FAX1 U41 ( .A(n57), .B(n66), .C(n55), .YC(n52), .YS(n53) );
  FAX1 U42 ( .A(n70), .B(n59), .C(n68), .YC(n54), .YS(n55) );
  FAX1 U43 ( .A(n72), .B(n61), .C(n63), .YC(n56), .YS(n57) );
  FAX1 U44 ( .A(n212), .B(n199), .C(n74), .YC(n58), .YS(n59) );
  FAX1 U45 ( .A(n241), .B(n187), .C(n226), .YC(n60), .YS(n61) );
  FAX1 U46 ( .A(n166), .B(n157), .C(n176), .YC(n62), .YS(n63) );
  FAX1 U47 ( .A(n69), .B(n78), .C(n67), .YC(n64), .YS(n65) );
  FAX1 U48 ( .A(n82), .B(n71), .C(n80), .YC(n66), .YS(n67) );
  FAX1 U49 ( .A(n84), .B(n73), .C(n75), .YC(n68), .YS(n69) );
  FAX1 U50 ( .A(n213), .B(n200), .C(n86), .YC(n70), .YS(n71) );
  FAX1 U51 ( .A(n242), .B(n188), .C(n227), .YC(n72), .YS(n73) );
  FAX1 U52 ( .A(n167), .B(n158), .C(n177), .YC(n74), .YS(n75) );
  FAX1 U53 ( .A(n81), .B(n90), .C(n79), .YC(n76), .YS(n77) );
  FAX1 U54 ( .A(n94), .B(n83), .C(n92), .YC(n78), .YS(n79) );
  FAX1 U55 ( .A(n96), .B(n85), .C(n87), .YC(n80), .YS(n81) );
  FAX1 U56 ( .A(n214), .B(n201), .C(n98), .YC(n82), .YS(n83) );
  FAX1 U57 ( .A(n243), .B(n189), .C(n228), .YC(n84), .YS(n85) );
  FAX1 U58 ( .A(n168), .B(n159), .C(n178), .YC(n86), .YS(n87) );
  FAX1 U59 ( .A(n93), .B(n102), .C(n91), .YC(n88), .YS(n89) );
  FAX1 U60 ( .A(n106), .B(n95), .C(n104), .YC(n90), .YS(n91) );
  FAX1 U61 ( .A(n108), .B(n97), .C(n99), .YC(n92), .YS(n93) );
  FAX1 U62 ( .A(n215), .B(n202), .C(n110), .YC(n94), .YS(n95) );
  FAX1 U63 ( .A(n244), .B(n190), .C(n229), .YC(n96), .YS(n97) );
  FAX1 U64 ( .A(n169), .B(n160), .C(n179), .YC(n98), .YS(n99) );
  FAX1 U65 ( .A(n105), .B(n114), .C(n103), .YC(n100), .YS(n101) );
  FAX1 U66 ( .A(n109), .B(n107), .C(n116), .YC(n102), .YS(n103) );
  FAX1 U67 ( .A(n120), .B(n118), .C(n111), .YC(n104), .YS(n105) );
  FAX1 U68 ( .A(n230), .B(n216), .C(n122), .YC(n106), .YS(n107) );
  FAX1 U69 ( .A(n245), .B(n191), .C(n203), .YC(n108), .YS(n109) );
  FAX1 U70 ( .A(n170), .B(n161), .C(n180), .YC(n110), .YS(n111) );
  FAX1 U71 ( .A(n117), .B(n126), .C(n115), .YC(n112), .YS(n113) );
  FAX1 U72 ( .A(n119), .B(n121), .C(n128), .YC(n114), .YS(n115) );
  FAX1 U73 ( .A(n132), .B(n123), .C(n130), .YC(n116), .YS(n117) );
  FAX1 U74 ( .A(n217), .B(n192), .C(n204), .YC(n118), .YS(n119) );
  FAX1 U75 ( .A(n246), .B(n181), .C(n231), .YC(n120), .YS(n121) );
  HAX1 U76 ( .A(n171), .B(n162), .YC(n122), .YS(n123) );
  FAX1 U77 ( .A(n129), .B(n136), .C(n127), .YC(n124), .YS(n125) );
  FAX1 U78 ( .A(n133), .B(n138), .C(n131), .YC(n126), .YS(n127) );
  FAX1 U79 ( .A(n218), .B(n205), .C(n140), .YC(n128), .YS(n129) );
  FAX1 U80 ( .A(n247), .B(n193), .C(n232), .YC(n130), .YS(n131) );
  HAX1 U81 ( .A(n182), .B(n172), .YC(n132), .YS(n133) );
  FAX1 U82 ( .A(n144), .B(n139), .C(n137), .YC(n134), .YS(n135) );
  FAX1 U83 ( .A(n233), .B(n146), .C(n141), .YC(n136), .YS(n137) );
  FAX1 U84 ( .A(n248), .B(n206), .C(n219), .YC(n138), .YS(n139) );
  HAX1 U85 ( .A(n194), .B(n183), .YC(n140), .YS(n141) );
  FAX1 U86 ( .A(n150), .B(n147), .C(n145), .YC(n142), .YS(n143) );
  FAX1 U87 ( .A(n249), .B(n220), .C(n234), .YC(n144), .YS(n145) );
  HAX1 U88 ( .A(n207), .B(n195), .YC(n146), .YS(n147) );
  FAX1 U89 ( .A(n250), .B(n235), .C(n152), .YC(n148), .YS(n149) );
  HAX1 U90 ( .A(n221), .B(n208), .YC(n150), .YS(n151) );
  HAX1 U91 ( .A(n251), .B(n236), .YC(n152), .YS(n153) );
  NOR2X1 U92 ( .A(n269), .B(n260), .Y(n154) );
  NOR2X1 U93 ( .A(n269), .B(n261), .Y(n155) );
  NOR2X1 U94 ( .A(n269), .B(n262), .Y(n156) );
  NOR2X1 U95 ( .A(n269), .B(n263), .Y(n157) );
  NOR2X1 U96 ( .A(n269), .B(n264), .Y(n158) );
  NOR2X1 U97 ( .A(n269), .B(n265), .Y(n159) );
  NOR2X1 U98 ( .A(n269), .B(n266), .Y(n160) );
  NOR2X1 U99 ( .A(n269), .B(n267), .Y(n161) );
  NOR2X1 U100 ( .A(n269), .B(n268), .Y(n162) );
  NOR2X1 U101 ( .A(n270), .B(n259), .Y(n163) );
  NOR2X1 U102 ( .A(n270), .B(n260), .Y(n164) );
  NOR2X1 U103 ( .A(n270), .B(n261), .Y(n165) );
  NOR2X1 U104 ( .A(n270), .B(n262), .Y(n166) );
  NOR2X1 U105 ( .A(n270), .B(n263), .Y(n167) );
  NOR2X1 U106 ( .A(n270), .B(n264), .Y(n168) );
  NOR2X1 U107 ( .A(n270), .B(n265), .Y(n169) );
  NOR2X1 U108 ( .A(n270), .B(n266), .Y(n170) );
  NOR2X1 U109 ( .A(n270), .B(n267), .Y(n171) );
  NOR2X1 U110 ( .A(n270), .B(n268), .Y(n172) );
  NOR2X1 U111 ( .A(n271), .B(n258), .Y(n173) );
  NOR2X1 U112 ( .A(n271), .B(n259), .Y(n174) );
  NOR2X1 U113 ( .A(n271), .B(n260), .Y(n175) );
  NOR2X1 U114 ( .A(n271), .B(n261), .Y(n176) );
  NOR2X1 U115 ( .A(n271), .B(n262), .Y(n177) );
  NOR2X1 U116 ( .A(n271), .B(n263), .Y(n178) );
  NOR2X1 U117 ( .A(n271), .B(n264), .Y(n179) );
  NOR2X1 U118 ( .A(n271), .B(n265), .Y(n180) );
  NOR2X1 U119 ( .A(n271), .B(n266), .Y(n181) );
  NOR2X1 U120 ( .A(n271), .B(n267), .Y(n182) );
  NOR2X1 U121 ( .A(n271), .B(n268), .Y(n183) );
  NOR2X1 U122 ( .A(n272), .B(n257), .Y(n184) );
  NOR2X1 U123 ( .A(n272), .B(n258), .Y(n185) );
  NOR2X1 U124 ( .A(n272), .B(n259), .Y(n186) );
  NOR2X1 U125 ( .A(n272), .B(n260), .Y(n187) );
  NOR2X1 U126 ( .A(n272), .B(n261), .Y(n188) );
  NOR2X1 U127 ( .A(n272), .B(n262), .Y(n189) );
  NOR2X1 U128 ( .A(n272), .B(n263), .Y(n190) );
  NOR2X1 U129 ( .A(n272), .B(n264), .Y(n191) );
  NOR2X1 U130 ( .A(n272), .B(n265), .Y(n192) );
  NOR2X1 U131 ( .A(n272), .B(n266), .Y(n193) );
  NOR2X1 U132 ( .A(n272), .B(n267), .Y(n194) );
  NOR2X1 U133 ( .A(n272), .B(n268), .Y(n195) );
  NOR2X1 U134 ( .A(n273), .B(n256), .Y(n196) );
  NOR2X1 U135 ( .A(n273), .B(n257), .Y(n197) );
  NOR2X1 U136 ( .A(n273), .B(n258), .Y(n198) );
  NOR2X1 U137 ( .A(n273), .B(n259), .Y(n199) );
  NOR2X1 U138 ( .A(n273), .B(n260), .Y(n200) );
  NOR2X1 U139 ( .A(n273), .B(n261), .Y(n201) );
  NOR2X1 U140 ( .A(n273), .B(n262), .Y(n202) );
  NOR2X1 U141 ( .A(n273), .B(n263), .Y(n203) );
  NOR2X1 U142 ( .A(n273), .B(n264), .Y(n204) );
  NOR2X1 U143 ( .A(n273), .B(n265), .Y(n205) );
  NOR2X1 U144 ( .A(n273), .B(n266), .Y(n206) );
  NOR2X1 U145 ( .A(n273), .B(n267), .Y(n207) );
  NOR2X1 U146 ( .A(n273), .B(n268), .Y(n208) );
  NOR2X1 U147 ( .A(n274), .B(n255), .Y(n209) );
  NOR2X1 U148 ( .A(n274), .B(n256), .Y(n210) );
  NOR2X1 U149 ( .A(n274), .B(n257), .Y(n211) );
  NOR2X1 U150 ( .A(n274), .B(n258), .Y(n212) );
  NOR2X1 U151 ( .A(n274), .B(n259), .Y(n213) );
  NOR2X1 U152 ( .A(n274), .B(n260), .Y(n214) );
  NOR2X1 U153 ( .A(n274), .B(n261), .Y(n215) );
  NOR2X1 U154 ( .A(n274), .B(n262), .Y(n216) );
  NOR2X1 U155 ( .A(n274), .B(n263), .Y(n217) );
  NOR2X1 U156 ( .A(n274), .B(n264), .Y(n218) );
  NOR2X1 U157 ( .A(n274), .B(n265), .Y(n219) );
  NOR2X1 U158 ( .A(n274), .B(n266), .Y(n220) );
  NOR2X1 U159 ( .A(n274), .B(n267), .Y(n221) );
  NOR2X1 U160 ( .A(n274), .B(n268), .Y(n222) );
  NOR2X1 U161 ( .A(n275), .B(n254), .Y(n223) );
  NOR2X1 U162 ( .A(n275), .B(n255), .Y(n224) );
  NOR2X1 U163 ( .A(n275), .B(n256), .Y(n225) );
  NOR2X1 U164 ( .A(n275), .B(n257), .Y(n226) );
  NOR2X1 U165 ( .A(n275), .B(n258), .Y(n227) );
  NOR2X1 U166 ( .A(n275), .B(n259), .Y(n228) );
  NOR2X1 U167 ( .A(n275), .B(n260), .Y(n229) );
  NOR2X1 U168 ( .A(n275), .B(n261), .Y(n230) );
  NOR2X1 U169 ( .A(n275), .B(n262), .Y(n231) );
  NOR2X1 U170 ( .A(n275), .B(n263), .Y(n232) );
  NOR2X1 U171 ( .A(n275), .B(n264), .Y(n233) );
  NOR2X1 U172 ( .A(n275), .B(n265), .Y(n234) );
  NOR2X1 U173 ( .A(n275), .B(n266), .Y(n235) );
  NOR2X1 U174 ( .A(n275), .B(n267), .Y(n236) );
  NOR2X1 U175 ( .A(n275), .B(n268), .Y(n237) );
  NOR2X1 U176 ( .A(n276), .B(n253), .Y(n238) );
  NOR2X1 U177 ( .A(n276), .B(n254), .Y(n239) );
  NOR2X1 U178 ( .A(n276), .B(n255), .Y(n240) );
  NOR2X1 U179 ( .A(n276), .B(n256), .Y(n241) );
  NOR2X1 U180 ( .A(n276), .B(n257), .Y(n242) );
  NOR2X1 U181 ( .A(n276), .B(n258), .Y(n243) );
  NOR2X1 U182 ( .A(n276), .B(n259), .Y(n244) );
  NOR2X1 U183 ( .A(n276), .B(n260), .Y(n245) );
  NOR2X1 U184 ( .A(n276), .B(n261), .Y(n246) );
  NOR2X1 U185 ( .A(n276), .B(n262), .Y(n247) );
  NOR2X1 U186 ( .A(n276), .B(n263), .Y(n248) );
  NOR2X1 U187 ( .A(n276), .B(n264), .Y(n249) );
  NOR2X1 U188 ( .A(n276), .B(n265), .Y(n250) );
  NOR2X1 U189 ( .A(n276), .B(n266), .Y(n251) );
  NOR2X1 U190 ( .A(n276), .B(n267), .Y(n252) );
  NOR2X1 U191 ( .A(n276), .B(n268), .Y(product[0]) );
  INVX2 U218 ( .A(a[0]), .Y(n276) );
  INVX2 U219 ( .A(a[1]), .Y(n275) );
  INVX2 U220 ( .A(b[15]), .Y(n253) );
  INVX2 U221 ( .A(a[2]), .Y(n274) );
  INVX2 U222 ( .A(a[3]), .Y(n273) );
  INVX2 U223 ( .A(a[4]), .Y(n272) );
  INVX2 U224 ( .A(a[5]), .Y(n271) );
  INVX2 U225 ( .A(a[6]), .Y(n270) );
  INVX2 U226 ( .A(a[7]), .Y(n269) );
  INVX2 U227 ( .A(b[0]), .Y(n268) );
  INVX2 U228 ( .A(b[1]), .Y(n267) );
  INVX2 U229 ( .A(b[2]), .Y(n266) );
  INVX2 U230 ( .A(b[3]), .Y(n265) );
  INVX2 U231 ( .A(b[4]), .Y(n264) );
  INVX2 U232 ( .A(b[8]), .Y(n260) );
  INVX2 U233 ( .A(b[6]), .Y(n262) );
  INVX2 U234 ( .A(b[5]), .Y(n263) );
  INVX2 U235 ( .A(b[7]), .Y(n261) );
  INVX2 U236 ( .A(b[9]), .Y(n259) );
  INVX2 U237 ( .A(b[10]), .Y(n258) );
  INVX2 U238 ( .A(b[11]), .Y(n257) );
  INVX2 U239 ( .A(b[12]), .Y(n256) );
  INVX2 U240 ( .A(b[13]), .Y(n255) );
  INVX2 U241 ( .A(b[14]), .Y(n254) );
endmodule


module multiplier ( clk, n_rst, row_select, begin_mult, pixel_value_1, 
        pixel_value_2, weight_value_1, weight_value_2, pixel_address_1, 
        pixel_address_2, weight_address_1, weight_address_2, done_row, 
        row_result, overflow, w_result_ena );
  input [3:0] row_select;
  input [7:0] pixel_value_1;
  input [7:0] pixel_value_2;
  input [15:0] weight_value_1;
  input [15:0] weight_value_2;
  output [9:0] pixel_address_1;
  output [9:0] pixel_address_2;
  output [12:0] weight_address_1;
  output [12:0] weight_address_2;
  output [15:0] row_result;
  input clk, n_rst, begin_mult;
  output done_row, overflow, w_result_ena;
  wire   rollover_flag, count_enable, N55, N56, N57, N58, N59, N60, N61, N62,
         N63, N64, N65, N66, N67, N68, N69, N70, N71, N72, N73, N74, N75, N76,
         N77, N78, N79, N80, N81, N82, N83, N84, N85, N86, N87, N88, N89, N90,
         N91, N92, N93, N94, N95, N96, N97, N98, N99, N100, N101, N102, N103,
         N104, N105, N106, N107, N108, N109, N110, N111, N112, N113, N114,
         N115, N116, N117, N118, N119, N120, N127, N128, N129, N130, N152,
         N153, N154, N155, N156, N157, N158, N161, N162, N163, n138, n139,
         n140, n141, n142, n143, n145, n146, n147, n148, n149, n150, n151,
         n152, n153, n154, n155, n156, n157, n158, n159, n160, n161, n162,
         n163, n164, n165, n166, n167, n168, n169, n170, n171, n172, n173,
         n174, n175, n176, n177, n178, n179, n180, n181, n182, n183, n184,
         n185, n186, n187, n188, n189, n190, n191, n192, n193, n194, n195,
         n196, n197, n198, n199, n200, n201, n202, n203, n204, n205, n206,
         n207, n208, n209, n210, n211, n212, n213, n214, n215, n216, n217,
         n218, n219, n220, n221, n222, n223, n224, n225, n226, n227, n228,
         n229, n230, n231, n232, n233, n234, n235, n236, n237, n238, n239,
         n240, n241, n242, n243, n244, n245, n246, n247, n248, n249, n250,
         n251, n252, n253, n254, n255, n256, n257, n258, n259, n260, n261,
         n262, n263, n264, n265, n266, n267, n268, n269, n270, n271, n272,
         n273, n274, n275, n276, n277, n278, n279, n280, n281, n282, n283,
         n284, n285, n286, n287, n288, n289, n290, n291, n292, n293, n294,
         n295, n296, n297, n298, n299, n300, n301, n302, n303, n304, n305,
         n306, n307, n308, n309, n310, n311, n312, n313, n314, n315, n316,
         n317, n318, n319, n320, n321, n322, n323, n324, n325, n326, n327,
         n328, n329, n330, n331, n332, n333, n334, n335, n336;
  wire   [1:0] state;
  wire   SYNOPSYS_UNCONNECTED__0, SYNOPSYS_UNCONNECTED__1, 
        SYNOPSYS_UNCONNECTED__2, SYNOPSYS_UNCONNECTED__3, 
        SYNOPSYS_UNCONNECTED__4, SYNOPSYS_UNCONNECTED__5, 
        SYNOPSYS_UNCONNECTED__6, SYNOPSYS_UNCONNECTED__7, 
        SYNOPSYS_UNCONNECTED__8, SYNOPSYS_UNCONNECTED__9, 
        SYNOPSYS_UNCONNECTED__10, SYNOPSYS_UNCONNECTED__11, 
        SYNOPSYS_UNCONNECTED__12, SYNOPSYS_UNCONNECTED__13, 
        SYNOPSYS_UNCONNECTED__14, SYNOPSYS_UNCONNECTED__15;
  assign pixel_address_1[0] = 1'b0;
  assign pixel_address_1[9] = pixel_address_2[9];
  assign pixel_address_1[8] = pixel_address_2[8];
  assign pixel_address_1[7] = pixel_address_2[7];
  assign pixel_address_1[6] = pixel_address_2[6];
  assign pixel_address_1[5] = pixel_address_2[5];
  assign pixel_address_1[4] = pixel_address_2[4];
  assign weight_address_1[3] = weight_address_2[3];
  assign pixel_address_1[3] = weight_address_2[3];
  assign pixel_address_2[3] = weight_address_2[3];
  assign weight_address_1[2] = weight_address_2[2];
  assign pixel_address_1[2] = weight_address_2[2];
  assign pixel_address_2[2] = weight_address_2[2];
  assign weight_address_1[1] = weight_address_2[1];
  assign pixel_address_1[1] = weight_address_2[1];
  assign pixel_address_2[1] = weight_address_2[1];
  assign N127 = row_select[1];
  assign N128 = row_select[2];
  assign N129 = row_select[3];
  assign N130 = row_select[0];
  assign weight_address_2[0] = 1'b1;
  assign pixel_address_2[0] = 1'b1;

  DFFSR \state_reg[0]  ( .D(n140), .CLK(clk), .R(n_rst), .S(1'b1), .Q(state[0]) );
  DFFSR \state_reg[1]  ( .D(n139), .CLK(clk), .R(n_rst), .S(1'b1), .Q(state[1]) );
  DFFSR write_enable_reg ( .D(n138), .CLK(clk), .R(n_rst), .S(1'b1), .Q(
        w_result_ena) );
  DFFSR \result_reg[0]  ( .D(n336), .CLK(clk), .R(n_rst), .S(1'b1), .Q(
        row_result[0]) );
  DFFSR \result_reg[1]  ( .D(n335), .CLK(clk), .R(n_rst), .S(1'b1), .Q(
        row_result[1]) );
  DFFSR \result_reg[2]  ( .D(n334), .CLK(clk), .R(n_rst), .S(1'b1), .Q(
        row_result[2]) );
  DFFSR \result_reg[3]  ( .D(n333), .CLK(clk), .R(n_rst), .S(1'b1), .Q(
        row_result[3]) );
  DFFSR \result_reg[4]  ( .D(n332), .CLK(clk), .R(n_rst), .S(1'b1), .Q(
        row_result[4]) );
  DFFSR \result_reg[5]  ( .D(n331), .CLK(clk), .R(n_rst), .S(1'b1), .Q(
        row_result[5]) );
  DFFSR \result_reg[6]  ( .D(n330), .CLK(clk), .R(n_rst), .S(1'b1), .Q(
        row_result[6]) );
  DFFSR \result_reg[7]  ( .D(n329), .CLK(clk), .R(n_rst), .S(1'b1), .Q(
        row_result[7]) );
  DFFSR \result_reg[8]  ( .D(n328), .CLK(clk), .R(n_rst), .S(1'b1), .Q(
        row_result[8]) );
  DFFSR \result_reg[9]  ( .D(n327), .CLK(clk), .R(n_rst), .S(1'b1), .Q(
        row_result[9]) );
  DFFSR \result_reg[10]  ( .D(n326), .CLK(clk), .R(n_rst), .S(1'b1), .Q(
        row_result[10]) );
  DFFSR \result_reg[11]  ( .D(n325), .CLK(clk), .R(n_rst), .S(1'b1), .Q(
        row_result[11]) );
  DFFSR \result_reg[12]  ( .D(n324), .CLK(clk), .R(n_rst), .S(1'b1), .Q(
        row_result[12]) );
  DFFSR \result_reg[13]  ( .D(n323), .CLK(clk), .R(n_rst), .S(1'b1), .Q(
        row_result[13]) );
  DFFSR \result_reg[14]  ( .D(n322), .CLK(clk), .R(n_rst), .S(1'b1), .Q(
        row_result[14]) );
  DFFSR \result_reg[15]  ( .D(n321), .CLK(clk), .R(n_rst), .S(1'b1), .Q(
        row_result[15]) );
  DFFSR \result_reg[16]  ( .D(n320), .CLK(clk), .R(n_rst), .S(1'b1), .Q(
        overflow) );
  flex_counter_NUM_CNT_BITS10 counter ( .clk(clk), .n_rst(n_rst), .clear(
        begin_mult), .count_enable(count_enable), .rollover_val({1'b0, 1'b1, 
        1'b1, 1'b0, 1'b0, 1'b0, 1'b1, 1'b0, 1'b0, 1'b0}), .count_out({N158, 
        N157, N156, N155, N154, N153, N152, N163, N162, N161}), 
        .rollover_flag(rollover_flag) );
  multiplier_DW01_add_1 add_0_root_add_169_2 ( .A({1'b0, N86, N85, N84, N83, 
        N82, N81, N80, N79, N78, N77, N76, N75, N74, N73, N72, N71}), .B({N103, 
        N102, N101, N100, N99, N98, N97, N96, N95, N94, N93, N92, N91, N90, 
        N89, N88, N87}), .CI(1'b0), .SUM({N120, N119, N118, N117, N116, N115, 
        N114, N113, N112, N111, N110, N109, N108, N107, N106, N105, N104}) );
  multiplier_DW01_add_2 add_1_root_add_169_2 ( .A({overflow, row_result}), .B(
        {1'b0, N70, N69, N68, N67, N66, N65, N64, N63, N62, N61, N60, N59, N58, 
        N57, N56, N55}), .CI(1'b0), .SUM({N103, N102, N101, N100, N99, N98, 
        N97, N96, N95, N94, N93, N92, N91, N90, N89, N88, N87}) );
  multiplier_DW_mult_uns_4 mult_167 ( .a(pixel_value_2), .b(weight_value_2), 
        .product({SYNOPSYS_UNCONNECTED__0, SYNOPSYS_UNCONNECTED__1, 
        SYNOPSYS_UNCONNECTED__2, SYNOPSYS_UNCONNECTED__3, 
        SYNOPSYS_UNCONNECTED__4, SYNOPSYS_UNCONNECTED__5, 
        SYNOPSYS_UNCONNECTED__6, SYNOPSYS_UNCONNECTED__7, N86, N85, N84, N83, 
        N82, N81, N80, N79, N78, N77, N76, N75, N74, N73, N72, N71}) );
  multiplier_DW_mult_uns_5 mult_166 ( .a(pixel_value_1), .b(weight_value_1), 
        .product({SYNOPSYS_UNCONNECTED__8, SYNOPSYS_UNCONNECTED__9, 
        SYNOPSYS_UNCONNECTED__10, SYNOPSYS_UNCONNECTED__11, 
        SYNOPSYS_UNCONNECTED__12, SYNOPSYS_UNCONNECTED__13, 
        SYNOPSYS_UNCONNECTED__14, SYNOPSYS_UNCONNECTED__15, N70, N69, N68, N67, 
        N66, N65, N64, N63, N62, N61, N60, N59, N58, N57, N56, N55}) );
  INVX2 U168 ( .A(n204), .Y(n141) );
  OAI21X1 U169 ( .A(state[1]), .B(state[0]), .C(n314), .Y(n142) );
  OR2X2 U170 ( .A(n142), .B(n155), .Y(n317) );
  BUFX2 U171 ( .A(n294), .Y(n143) );
  NAND2X1 U172 ( .A(n145), .B(n146), .Y(weight_address_2[9]) );
  MUX2X1 U173 ( .B(n147), .A(n148), .S(n149), .Y(n146) );
  NOR2X1 U174 ( .A(n150), .B(n151), .Y(n148) );
  INVX1 U175 ( .A(n152), .Y(n147) );
  AOI22X1 U176 ( .A(n153), .B(n154), .C(n155), .D(n156), .Y(n145) );
  XOR2X1 U177 ( .A(n157), .B(n150), .Y(n154) );
  NOR2X1 U178 ( .A(N157), .B(n141), .Y(n153) );
  NAND2X1 U179 ( .A(n159), .B(n160), .Y(weight_address_2[8]) );
  MUX2X1 U180 ( .B(n161), .A(n162), .S(n163), .Y(n160) );
  NOR2X1 U181 ( .A(N130), .B(n164), .Y(n162) );
  INVX1 U182 ( .A(n165), .Y(n161) );
  AOI22X1 U183 ( .A(n166), .B(n167), .C(n155), .D(n168), .Y(n159) );
  XOR2X1 U184 ( .A(n169), .B(n163), .Y(n167) );
  NOR2X1 U185 ( .A(N156), .B(n141), .Y(n166) );
  NAND2X1 U186 ( .A(n170), .B(n171), .Y(weight_address_2[7]) );
  MUX2X1 U187 ( .B(n172), .A(n173), .S(n174), .Y(n171) );
  NOR2X1 U188 ( .A(N129), .B(n175), .Y(n173) );
  INVX1 U189 ( .A(n176), .Y(n172) );
  AOI22X1 U190 ( .A(n177), .B(n178), .C(n155), .D(n179), .Y(n170) );
  XOR2X1 U191 ( .A(n180), .B(n174), .Y(n178) );
  NOR2X1 U192 ( .A(N155), .B(n141), .Y(n177) );
  NAND2X1 U193 ( .A(n181), .B(n182), .Y(weight_address_2[6]) );
  MUX2X1 U194 ( .B(n183), .A(n184), .S(n185), .Y(n182) );
  NOR2X1 U195 ( .A(N128), .B(n186), .Y(n184) );
  INVX1 U196 ( .A(n187), .Y(n183) );
  AOI22X1 U197 ( .A(n188), .B(n189), .C(n155), .D(n190), .Y(n181) );
  XOR2X1 U198 ( .A(n191), .B(n185), .Y(n189) );
  NOR2X1 U199 ( .A(N154), .B(n141), .Y(n188) );
  NAND2X1 U200 ( .A(n192), .B(n193), .Y(weight_address_2[5]) );
  MUX2X1 U201 ( .B(n194), .A(n195), .S(n196), .Y(n193) );
  INVX1 U202 ( .A(n197), .Y(n195) );
  NOR2X1 U203 ( .A(N127), .B(n198), .Y(n194) );
  AOI22X1 U204 ( .A(n199), .B(n200), .C(n155), .D(n201), .Y(n192) );
  INVX1 U205 ( .A(N153), .Y(n200) );
  MUX2X1 U206 ( .B(n202), .A(n203), .S(N127), .Y(n199) );
  NAND2X1 U207 ( .A(n204), .B(n205), .Y(n203) );
  OAI21X1 U208 ( .A(n206), .B(n207), .C(n208), .Y(weight_address_2[4]) );
  MUX2X1 U209 ( .B(pixel_address_2[4]), .A(n209), .S(N130), .Y(n208) );
  NOR2X1 U210 ( .A(N152), .B(n158), .Y(n209) );
  OAI22X1 U211 ( .A(n207), .B(n210), .C(n158), .D(n211), .Y(
        weight_address_2[12]) );
  XNOR2X1 U212 ( .A(n212), .B(n213), .Y(n211) );
  NAND2X1 U213 ( .A(n214), .B(n215), .Y(n212) );
  OAI22X1 U214 ( .A(n207), .B(n216), .C(n217), .D(n158), .Y(
        weight_address_2[11]) );
  XOR2X1 U215 ( .A(n215), .B(n218), .Y(n217) );
  OAI21X1 U216 ( .A(n219), .B(n220), .C(n221), .Y(n215) );
  OAI21X1 U217 ( .A(n222), .B(n223), .C(N158), .Y(n221) );
  NAND2X1 U218 ( .A(n224), .B(n225), .Y(weight_address_2[10]) );
  MUX2X1 U219 ( .B(n226), .A(n227), .S(n219), .Y(n225) );
  INVX1 U220 ( .A(n223), .Y(n219) );
  NOR2X1 U221 ( .A(n222), .B(n228), .Y(n227) );
  INVX1 U222 ( .A(n229), .Y(n226) );
  AOI22X1 U223 ( .A(n230), .B(n231), .C(n155), .D(n232), .Y(n224) );
  XOR2X1 U224 ( .A(n223), .B(n222), .Y(n231) );
  OAI21X1 U225 ( .A(n149), .B(n233), .C(n234), .Y(n223) );
  OAI21X1 U226 ( .A(n150), .B(n157), .C(N157), .Y(n234) );
  INVX1 U227 ( .A(n157), .Y(n149) );
  OAI21X1 U228 ( .A(n163), .B(n169), .C(n235), .Y(n157) );
  OAI21X1 U229 ( .A(N130), .B(n236), .C(N156), .Y(n235) );
  INVX1 U230 ( .A(n236), .Y(n163) );
  OAI21X1 U231 ( .A(n174), .B(n180), .C(n237), .Y(n236) );
  OAI21X1 U232 ( .A(N129), .B(n238), .C(N155), .Y(n237) );
  INVX1 U233 ( .A(n238), .Y(n174) );
  OAI21X1 U234 ( .A(n185), .B(n191), .C(n239), .Y(n238) );
  OAI21X1 U235 ( .A(N128), .B(n240), .C(N154), .Y(n239) );
  INVX1 U236 ( .A(n240), .Y(n185) );
  OAI21X1 U237 ( .A(n205), .B(n241), .C(n242), .Y(n240) );
  OAI21X1 U238 ( .A(n196), .B(N127), .C(N153), .Y(n242) );
  NOR2X1 U239 ( .A(N158), .B(n158), .Y(n230) );
  OAI22X1 U241 ( .A(n233), .B(n207), .C(n243), .D(n158), .Y(
        weight_address_1[9]) );
  INVX1 U242 ( .A(n156), .Y(n243) );
  OAI21X1 U243 ( .A(n244), .B(n152), .C(n245), .Y(n156) );
  MUX2X1 U244 ( .B(n246), .A(n247), .S(pixel_address_2[9]), .Y(n245) );
  NOR2X1 U245 ( .A(n150), .B(n248), .Y(n247) );
  XOR2X1 U246 ( .A(n248), .B(n150), .Y(n246) );
  INVX1 U247 ( .A(n150), .Y(n233) );
  OAI22X1 U248 ( .A(n169), .B(n207), .C(n249), .D(n158), .Y(
        weight_address_1[8]) );
  INVX1 U249 ( .A(n168), .Y(n249) );
  OAI21X1 U250 ( .A(n250), .B(n165), .C(n251), .Y(n168) );
  MUX2X1 U251 ( .B(n252), .A(n253), .S(N130), .Y(n251) );
  NOR2X1 U252 ( .A(pixel_address_2[8]), .B(n254), .Y(n253) );
  XOR2X1 U253 ( .A(n254), .B(pixel_address_2[8]), .Y(n252) );
  OAI22X1 U254 ( .A(n180), .B(n207), .C(n255), .D(n158), .Y(
        weight_address_1[7]) );
  INVX1 U255 ( .A(n179), .Y(n255) );
  OAI21X1 U256 ( .A(n256), .B(n176), .C(n257), .Y(n179) );
  MUX2X1 U257 ( .B(n258), .A(n259), .S(N129), .Y(n257) );
  NOR2X1 U258 ( .A(pixel_address_2[7]), .B(n260), .Y(n259) );
  XOR2X1 U259 ( .A(n260), .B(pixel_address_2[7]), .Y(n258) );
  INVX1 U260 ( .A(n260), .Y(n256) );
  INVX1 U261 ( .A(N129), .Y(n180) );
  OAI22X1 U262 ( .A(n191), .B(n207), .C(n261), .D(n158), .Y(
        weight_address_1[6]) );
  INVX1 U263 ( .A(n190), .Y(n261) );
  OAI21X1 U264 ( .A(n262), .B(n187), .C(n263), .Y(n190) );
  MUX2X1 U265 ( .B(n264), .A(n265), .S(N128), .Y(n263) );
  NOR2X1 U266 ( .A(pixel_address_2[6]), .B(n266), .Y(n265) );
  XOR2X1 U267 ( .A(n266), .B(pixel_address_2[6]), .Y(n264) );
  OAI22X1 U268 ( .A(n241), .B(n207), .C(n267), .D(n158), .Y(
        weight_address_1[5]) );
  INVX1 U269 ( .A(n201), .Y(n267) );
  OAI21X1 U270 ( .A(n202), .B(n197), .C(n268), .Y(n201) );
  MUX2X1 U271 ( .B(n269), .A(n270), .S(N127), .Y(n268) );
  NOR2X1 U272 ( .A(pixel_address_2[5]), .B(n271), .Y(n270) );
  XOR2X1 U273 ( .A(pixel_address_2[5]), .B(n271), .Y(n269) );
  INVX1 U274 ( .A(n202), .Y(n271) );
  OAI22X1 U275 ( .A(n169), .B(n207), .C(n206), .D(n158), .Y(
        weight_address_1[4]) );
  XOR2X1 U276 ( .A(n169), .B(pixel_address_2[4]), .Y(n206) );
  INVX1 U277 ( .A(N130), .Y(n169) );
  OAI22X1 U278 ( .A(n207), .B(n213), .C(n158), .D(n210), .Y(
        weight_address_1[12]) );
  XNOR2X1 U279 ( .A(n272), .B(n213), .Y(n210) );
  NAND2X1 U280 ( .A(n214), .B(n273), .Y(n272) );
  XNOR2X1 U281 ( .A(n274), .B(N129), .Y(n213) );
  OAI21X1 U282 ( .A(n275), .B(n191), .C(n276), .Y(n274) );
  OAI21X1 U283 ( .A(N128), .B(n277), .C(N129), .Y(n276) );
  INVX1 U284 ( .A(n277), .Y(n275) );
  OAI22X1 U285 ( .A(n207), .B(n218), .C(n216), .D(n158), .Y(
        weight_address_1[11]) );
  XOR2X1 U286 ( .A(n273), .B(n218), .Y(n216) );
  OAI21X1 U287 ( .A(n278), .B(n279), .C(n229), .Y(n273) );
  NOR2X1 U288 ( .A(n280), .B(n222), .Y(n279) );
  INVX1 U289 ( .A(n214), .Y(n218) );
  XOR2X1 U290 ( .A(n277), .B(n281), .Y(n214) );
  XOR2X1 U291 ( .A(N129), .B(N128), .Y(n281) );
  OAI21X1 U292 ( .A(n241), .B(n191), .C(n282), .Y(n277) );
  INVX1 U293 ( .A(N128), .Y(n191) );
  OAI22X1 U294 ( .A(n220), .B(n207), .C(n283), .D(n158), .Y(
        weight_address_1[10]) );
  INVX1 U295 ( .A(n232), .Y(n283) );
  OAI21X1 U296 ( .A(n278), .B(n229), .C(n284), .Y(n232) );
  MUX2X1 U297 ( .B(n285), .A(n286), .S(n222), .Y(n284) );
  NOR2X1 U298 ( .A(n280), .B(n287), .Y(n286) );
  XOR2X1 U299 ( .A(n287), .B(n280), .Y(n285) );
  NAND2X1 U300 ( .A(n280), .B(n222), .Y(n229) );
  INVX1 U301 ( .A(n220), .Y(n222) );
  INVX1 U302 ( .A(n228), .Y(n280) );
  NAND2X1 U303 ( .A(N158), .B(n204), .Y(n228) );
  INVX1 U304 ( .A(n287), .Y(n278) );
  OAI21X1 U305 ( .A(n244), .B(n288), .C(n152), .Y(n287) );
  NAND2X1 U306 ( .A(pixel_address_2[9]), .B(n150), .Y(n152) );
  NOR2X1 U307 ( .A(pixel_address_2[9]), .B(n150), .Y(n288) );
  XNOR2X1 U308 ( .A(n241), .B(N130), .Y(n150) );
  INVX1 U309 ( .A(N127), .Y(n241) );
  INVX1 U310 ( .A(n248), .Y(n244) );
  OAI21X1 U311 ( .A(n250), .B(n289), .C(n165), .Y(n248) );
  NAND2X1 U312 ( .A(pixel_address_2[8]), .B(N130), .Y(n165) );
  NOR2X1 U313 ( .A(pixel_address_2[8]), .B(N130), .Y(n289) );
  INVX1 U314 ( .A(n254), .Y(n250) );
  NAND2X1 U315 ( .A(n176), .B(n290), .Y(n254) );
  OAI21X1 U316 ( .A(pixel_address_2[7]), .B(N129), .C(n260), .Y(n290) );
  OAI21X1 U317 ( .A(n262), .B(n291), .C(n187), .Y(n260) );
  NAND2X1 U318 ( .A(pixel_address_2[6]), .B(N128), .Y(n187) );
  NOR2X1 U319 ( .A(pixel_address_2[6]), .B(N128), .Y(n291) );
  INVX1 U320 ( .A(n266), .Y(n262) );
  OAI21X1 U321 ( .A(n292), .B(n202), .C(n197), .Y(n266) );
  NAND2X1 U322 ( .A(pixel_address_2[5]), .B(N127), .Y(n197) );
  NAND2X1 U323 ( .A(n204), .B(n196), .Y(n202) );
  INVX1 U324 ( .A(n205), .Y(n196) );
  NAND2X1 U325 ( .A(N152), .B(N130), .Y(n205) );
  NOR2X1 U326 ( .A(pixel_address_2[5]), .B(N127), .Y(n292) );
  NAND2X1 U327 ( .A(pixel_address_2[7]), .B(N129), .Y(n176) );
  XOR2X1 U328 ( .A(n282), .B(n293), .Y(n220) );
  XOR2X1 U329 ( .A(N128), .B(N127), .Y(n293) );
  NAND2X1 U330 ( .A(N127), .B(N130), .Y(n282) );
  NOR2X1 U331 ( .A(n141), .B(n207), .Y(weight_address_1[0]) );
  INVX1 U332 ( .A(n151), .Y(pixel_address_2[9]) );
  NAND2X1 U333 ( .A(N157), .B(n204), .Y(n151) );
  INVX1 U334 ( .A(n164), .Y(pixel_address_2[8]) );
  NAND2X1 U335 ( .A(n204), .B(N156), .Y(n164) );
  INVX1 U336 ( .A(n175), .Y(pixel_address_2[7]) );
  NAND2X1 U337 ( .A(n204), .B(N155), .Y(n175) );
  INVX1 U338 ( .A(n186), .Y(pixel_address_2[6]) );
  NAND2X1 U339 ( .A(n204), .B(N154), .Y(n186) );
  INVX1 U340 ( .A(n198), .Y(pixel_address_2[5]) );
  NAND2X1 U341 ( .A(n204), .B(N153), .Y(n198) );
  AND2X1 U342 ( .A(n204), .B(N152), .Y(pixel_address_2[4]) );
  AND2X1 U343 ( .A(N163), .B(n204), .Y(weight_address_2[3]) );
  AND2X1 U344 ( .A(N162), .B(n204), .Y(weight_address_2[2]) );
  AND2X1 U345 ( .A(N161), .B(n204), .Y(weight_address_2[1]) );
  INVX1 U346 ( .A(n158), .Y(n204) );
  NAND2X1 U347 ( .A(n143), .B(n295), .Y(n158) );
  INVX1 U348 ( .A(n296), .Y(n320) );
  AOI22X1 U349 ( .A(overflow), .B(n297), .C(N120), .D(n143), .Y(n296) );
  INVX1 U350 ( .A(n298), .Y(n321) );
  AOI22X1 U351 ( .A(row_result[15]), .B(n142), .C(N119), .D(n143), .Y(n298) );
  INVX1 U352 ( .A(n299), .Y(n322) );
  AOI22X1 U353 ( .A(row_result[14]), .B(n297), .C(N118), .D(n143), .Y(n299) );
  INVX1 U354 ( .A(n300), .Y(n323) );
  AOI22X1 U355 ( .A(row_result[13]), .B(n142), .C(N117), .D(n143), .Y(n300) );
  INVX1 U356 ( .A(n301), .Y(n324) );
  AOI22X1 U357 ( .A(row_result[12]), .B(n297), .C(N116), .D(n143), .Y(n301) );
  INVX1 U358 ( .A(n302), .Y(n325) );
  AOI22X1 U359 ( .A(row_result[11]), .B(n142), .C(N115), .D(n143), .Y(n302) );
  INVX1 U360 ( .A(n303), .Y(n326) );
  AOI22X1 U361 ( .A(row_result[10]), .B(n297), .C(N114), .D(n143), .Y(n303) );
  INVX1 U362 ( .A(n304), .Y(n327) );
  AOI22X1 U363 ( .A(row_result[9]), .B(n142), .C(N113), .D(n143), .Y(n304) );
  INVX1 U364 ( .A(n305), .Y(n328) );
  AOI22X1 U365 ( .A(row_result[8]), .B(n297), .C(N112), .D(n143), .Y(n305) );
  INVX1 U366 ( .A(n306), .Y(n329) );
  AOI22X1 U367 ( .A(row_result[7]), .B(n142), .C(N111), .D(n143), .Y(n306) );
  INVX1 U368 ( .A(n307), .Y(n330) );
  AOI22X1 U369 ( .A(row_result[6]), .B(n297), .C(N110), .D(n143), .Y(n307) );
  INVX1 U370 ( .A(n308), .Y(n331) );
  AOI22X1 U371 ( .A(row_result[5]), .B(n142), .C(N109), .D(n143), .Y(n308) );
  INVX1 U372 ( .A(n309), .Y(n332) );
  AOI22X1 U373 ( .A(row_result[4]), .B(n297), .C(N108), .D(n143), .Y(n309) );
  INVX1 U374 ( .A(n310), .Y(n333) );
  AOI22X1 U375 ( .A(row_result[3]), .B(n142), .C(N107), .D(n143), .Y(n310) );
  INVX1 U376 ( .A(n311), .Y(n334) );
  AOI22X1 U377 ( .A(row_result[2]), .B(n297), .C(N106), .D(n143), .Y(n311) );
  INVX1 U378 ( .A(n312), .Y(n335) );
  AOI22X1 U379 ( .A(row_result[1]), .B(n142), .C(N105), .D(n143), .Y(n312) );
  INVX1 U380 ( .A(n313), .Y(n336) );
  AOI22X1 U381 ( .A(row_result[0]), .B(n297), .C(N104), .D(n143), .Y(n313) );
  INVX1 U382 ( .A(n314), .Y(done_row) );
  NOR2X1 U383 ( .A(state[0]), .B(n315), .Y(n140) );
  MUX2X1 U384 ( .B(begin_mult), .A(rollover_flag), .S(state[1]), .Y(n315) );
  INVX1 U385 ( .A(n316), .Y(n139) );
  OAI21X1 U386 ( .A(n295), .B(n317), .C(n318), .Y(n138) );
  INVX1 U387 ( .A(w_result_ena), .Y(n318) );
  OAI21X1 U388 ( .A(state[1]), .B(state[0]), .C(n314), .Y(n297) );
  INVX1 U389 ( .A(rollover_flag), .Y(n295) );
  NAND2X1 U390 ( .A(n316), .B(n314), .Y(count_enable) );
  NAND2X1 U391 ( .A(state[0]), .B(state[1]), .Y(n314) );
  NOR2X1 U392 ( .A(n155), .B(n143), .Y(n316) );
  NOR2X1 U393 ( .A(n319), .B(state[0]), .Y(n294) );
  INVX1 U394 ( .A(n207), .Y(n155) );
  NAND2X1 U395 ( .A(state[0]), .B(n319), .Y(n207) );
  INVX1 U396 ( .A(state[1]), .Y(n319) );
endmodule

